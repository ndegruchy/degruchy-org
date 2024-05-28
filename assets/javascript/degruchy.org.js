/**
 * DeGruchy.org JavaScript
 * A bunch of initialization stuff and collecting elements to feed to
 * things like timeago
 */

function main()
{
    const lightboxImages = $("li a picture");
    const timeElements = $("header > time");
    const tableFoot = $("tfoot a");

    if(lightboxImages.length > 0)
    {
	$("li a").simpleLightbox({
	    "captionSelector": 'figcaption',
	    "captionType": "text",
	    "fileExt": "png|jpg|jpeg|gif|avif|webp|heif",
	    "nav": false,
	    "overlay": true,
	    "showCounter": false
	});
    }

    if(timeElements.length > 0)
    {
	timeElements.timeago();
    }

    // Randomize donation link
    if(tableFoot.length > 0)
    {
	const nonprofits = [
	    "https://www.spi-inc.org/donations/",                         // Debian, et al
	    "https://kde.org/community/donations/",                       // KDE
	    "https://ffmpeg.org/donations.html",                          // ffmpeg
	    "https://github.com/sponsors/ImageMagick?o=esb",              // Imagemagick
	    "https://foundation.mozilla.org/en/?form=moco-donate-footer", // Firefox
	    "https://fund.blender.org/",                                  // Blender
	    "https://krita.org/en/donations/",                            // Krita
	    "https://obsproject.com/contribute",                          // Obs
	    "https://github.com/sponsors/Tienisto",                       // LocalSend
	    "https://www.videolan.org/contribute.html",                   // VLC
	    "https://www.libreoffice.org/donate/",                        // LibreOffice
	    "https://www.shutupandsitdown.com/donate/",                   // SU&SD
	    "https://my.fsf.org/donate"                                   // GNU/FSF
	];

	selectedURL = nonprofits[
	    Math.floor(Math.random() * nonprofits.length)
	];

	tableFoot.attr("href", selectedURL);

	tableFoot.attr("rel", "nofollow").attr("target", "_blank");
    }
}

$(document).ready(main());
