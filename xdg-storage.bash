#!/bin/bash
# Kopiere Dateien ins Storage

set -x
set -e

#
# Fnk. die anhand des MIME-Type und xdg-user-dirs,
# das zu verwendene Verz. auf STDOUT zurück gibt.
#

get_xdg_user_dir() {
    case "$*" in
        audio/*)
            echo "$XDG_MUSIC_DIR/$*"
            ;;
        image/*)
            echo "$XDG_PICTURES_DIR/$*"
            ;;
        text/*)
            echo "$XDG_DOCUMENTS_DIR/$*"
            ;;
        video/*)
            echo "$XDG_VIDEOS_DIR/$*"
            ;;
        application/*|chemical/*|*)
            echo "$HOME/$*"
            ;;
    esac
}


# Die xdg-user-dirs Definitionen einlesen
if test -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"; then
    . "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"
fi
# Standardpfade für fehlende xdg-user-dirs setzen
XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME}"
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME}"
XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME}"
XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME}"

# Optionen einlesen
config="${XDG_CONFIG_HOME:-$HOME/.config}/xdg-storage/config"
mkdir -p "`dirname "$config"`"
touch "$config"
. "${XDG_CONFIG_HOME:-$HOME/.config}/xdg-storage/config"
# Standardwerte für nicht gesetzte Optionen setzen
XDG_STORAGE_DIR="${XDG_STORAGE_DIR:-$HOME/Storage}"

TEMP=$(getopt -o 'id:' --long 'ignore-directorys,directory:' -n "$0" -- "$@")

if [ $? -ne 0 ]; then
	usage
	echo 'Terminating...' >&2
	exit 1
fi

# Note the quotes around "$TEMP": they are essential!
eval set -- "$TEMP"
unset TEMP

while true; do
	case "$1" in

		'-d'|'--directory')
			echo "Option -d, --directory; argument '$2'"
			XDG_STORAGE_DIR="$2"
			shift 2
			continue
		;;

		'-i'|'--ignore-directorys')
			echo "Option -i, --ignore-directorys"
			ignore_directorys="true"
			shift
			continue
		;;

		'--')
			shift
			break
		;;

		*)
			echo 'Internal error!' >&2
			exit 1
		;;
	esac
done

echo 'Remaining arguments:'
for arg; do
	echo "--> '$arg'"
done

mkdir -p "$XDG_STORAGE_DIR" && [ -w "$XDG_STORAGE_DIR" ]

for path; do
    if test -d "$path"; then

	if test "$ignore_directorys" = "true"; then
	        continue
	else
	        # Arbeite Verz. rekursiv ab
        	"$0" "$path/"*
	fi

    fi

    mime_type="$(file -b --mime-type "$path")"
    dir=

    # Verz. bestimmen in das die Datei einsortiert werden soll
    if test "$XDG_STORAGE_DIR"; then
        dir="$XDG_STORAGE_DIR/$mime_type"
    else
        dir="$(get_xdg_user_dir "$mime_type")"
    fi

    #TODO: Ist die Dat. schon einsortiert?

    # Dat. ins Verz. verschieben
    mkdir -p "$dir"
    mv -v --backup=numbered "$path" "$dir"
#    gvfs-mkdir --parent "$dir"
#    gvfs-move --backup --progress "$path" "$dir"
done

