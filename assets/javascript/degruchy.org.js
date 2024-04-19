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
    const eTimes = document.querySelectorAll("header > time");
    const oTheWatcher = lozad(); // Lazy loader.

    // Start time ago
    if
    (
	eTimes.length > 0
	&&
	undefined !== typeof timeago // Guard against failed loading of timeago
    )
    {
	timeago.render(eTimes);
    }
    else
    {
	return false;
    }

    if (undefined !== typeof lozad())
    {
	oTheWatcher.observe();
    }

    return true;
}

main(); // lets gooo!
