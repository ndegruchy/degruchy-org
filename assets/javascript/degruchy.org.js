/**
 * DeGruchy.org JavaScript
 * A bunch of initialization stuff and collecting elements to feed to
 * things like timeago
 */

/**
 * Main function
 * @description The function that gets triggered once the page loads
 * @returns bool - True on success, false on failure
 */
function main()
{
    const oTheWatcher = lozad(); // Lazy loader.
    oTheWatcher.observe();

    $("li a").simpleLightbox({
	"captionSelector": 'figcaption',
	"captionType": "text",
	"fileExt": "png|jpg|jpeg|gif|avif|webp|heif"
	"nav": false,
	"overlay": true,
	"showCounter": false
    });

    $("header > time").timeago();
}

$(document).ready(function (){
    main(); // lets gooo!
});
