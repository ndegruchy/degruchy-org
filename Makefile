all: upload set-meta invalidate finish

upload :
	aws s3 sync $(shell pwd) s3://degruchy-org --quiet --exclude ".git**" --exclude ".aws**" --exclude ".vscode**" --exclude "*.code-workspace" --exclude ".idea**" --exclude ".editorconfig" --exclude "Makefile" --exclude ".kateproject"

set-meta:
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "text/css" --exclude "*" --include "*.css" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "text/javascript" --exclude "*" --include "*.js" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "image/jpeg" --exclude "*" --include "*.jpg" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "image/jpeg" --exclude "*" --include "*.jpeg" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "image/webp" --exclude "*" --include "*.webp" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "image/heic" --exclude "*" --include "*.heic" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "image/png" --exclude "*" --include "*.png" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "video/mp4" --exclude "*" --include "*.mp4" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "video/ogv" --exclude "*" --include "*.ogv" --metadata-directive REPLACE --recursive
	aws s3 cp s3://degruchy-org/assets s3://degruchy-org/assets --quiet --cache-control "max-age=15778476" --content-type "video/webm" --exclude "*" --include "*.webm" --metadata-directive REPLACE --recursive

invalidate:
	aws cloudfront create-invalidation --distribution-id $(CLOUDFRONT_ID) --paths=/\* --no-cli-pager

finish:
	notify-send --app-name="Emacs" --urgency=low --expire-time=3600 --icon=emacs --category=job --wait "Website Update Complete."
