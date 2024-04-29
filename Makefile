all: precompress upload mirror notify

precompress:
	find . -type f -iname "*.css"  -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.html" -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.js"   -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.txt"  -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.xml"  -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.css"  -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.html" -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.js"   -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.txt"  -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.xml"  -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.css"  -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.html" -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.js"   -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.txt"  -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.xml"  -exec gzip   --force --keep --quiet {} \;


upload:
	rsync --recursive --update --delete-excluded --delete-after --exclude=Makefile --exclude=.editorconfig --exclude=.fslckout --exclude=templates --exclude=README.md --progress . nathan@degruchy.org:~/blog

mirror:
	fossil git export

clean:
	find . -type f -iname "*.zst" -delete
	find . -type f -iname "*.br"  -delete
	find . -type f -iname "*.gz"  -delete

notify:
	notify-send --app-name="Emacs" --urgency=low --expire-time=3600 --icon=emacs --category=job --wait "Website Update Complete."
