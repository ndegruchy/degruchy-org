all: minify precompress upload mirror notify clean

precompress:
	find . -type f -iname "*.css"  -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.html" ! -iname "*.original.*" -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.js"   -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.txt"  -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.xml"  -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.svg"  -exec brotli --force --best --keep {} \;
	find . -type f -iname "*.css"  -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.html" ! -iname "*.original.*" -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.js"   -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.txt"  -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.xml"  -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.svg"  -exec zstd   --force --keep --threads=4 --no-progress --quiet {} \;
	find . -type f -iname "*.css"  -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.html" ! -iname "*.original.*" -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.js"   -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.txt"  -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.xml"  -exec gzip   --force --keep --quiet {} \;
	find . -type f -iname "*.svg"  -exec gzip   --force --keep --quiet {} \;

minify:
	cp index.html index.original.html
	cp error.html error.original.html
	cp wishlist/index.html wishlist/index.original.html
	htmlmin --remove-comments --remove-empty-space index.original.html index.html
	htmlmin --remove-comments --remove-empty-space index.original.html error.html
	htmlmin --remove-comments --remove-empty-space wishlist/index.original.html wishlist/index.html

upload:
	rsync --recursive --update --delete-excluded --delete-after --exclude=Makefile --exclude=.editorconfig --exclude=.fslckout --exclude=templates --exclude=README.md --exclude="*.original.*" --progress . nathan@degruchy.org:~/blog

mirror:
	fossil git export

clean:
	mv index.original.html index.html
	mv error.original.html error.html
	mv wishlist/index.original.html wishlist/index.html
	find . -type f -iname "*.zst"        -delete
	find . -type f -iname "*.br"         -delete
	find . -type f -iname "*.gz"         -delete
	find . -type f -iname "*.original.*" -delete

notify:
	notify-send --app-name="Emacs" --urgency=low --expire-time=3600 --icon=emacs --category=job --wait "Website Update Complete."

