all: upload finish

upload:
	rsync --recursive --update --delete-excluded --delete-after --exclude=Makefile --exclude=.editorconfig --exclude=.fslckout --exclude=templates --exclude=README.md --progress . nathan@degruchy.org:/mnt/HC_Volume_100401178/degruchy-infra/degruchy-blog

finish:
	fossil git export
	notify-send --app-name="Emacs" --urgency=low --expire-time=3600 --icon=emacs --category=job --wait "Website Update Complete."
