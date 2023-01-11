/**
 * Handles the incoming requests to AWS Cloudfront
 * @param event The event that is coming in
 * @returns request The maybe modified request
 */
function handler(event) {
	const request = event.request;

	switch (request.uri)
	{
		case request.uri.startsWith('/api'):
		case request.uri.startsWith('/blog'):
		case request.uri.startsWith('/wp-json'):
		case request.uri.startsWith('/nodeinfo'):
			// Please stop trying to visit these pages
			return {
				statusCode: 410,
				statusDescription: 'Gone'
			};
		case request.uri.startsWith('/wishlist'):
			// redirect to wishlist
			return {
				statusCode: 308,
				statusDescription: 'Permanent Redirect',
				headers: {
					"location": {
						"value": "https://mywishlist.online/w/75dd8k/nathans-wishlist"
					}
				}
			};
		case request.uri.endsWith('/feed'):
		case request.uri.endsWith('/feed/'):
			// feed fixes
			return {
				statusCode: 308,
				statusDescription: "Permanent Redirect",
				headers: {
					"location": {
						"value": "https://degruchy.org/feed.xml"
					}
				}
			}
	}

	// Last resort, just return the URL
	return request;
}
