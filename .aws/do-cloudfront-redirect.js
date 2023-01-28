	/**
	* Handles the incoming requests to AWS Cloudfront
	* @param event The event that is coming in
	* @returns request The maybe modified request
	*/
	function handler(event) {
		var request = event.request;
		var headers = request.headers;

		if(
			(request.uri.startsWith('/api')) ||
			(request.uri.startsWith('/blog')) ||
			(request.uri.startsWith('/wp-json')) ||
			(request.uri.startsWith('/nodeinfo'))
		)
		{
			// Stupid old page request and old ActivityPub requests
			return {
				statusCode: 410,
				statusDescription: 'Gone'
			};
		}

		if((request.uri.startsWith('/wishlist')))
		{
			// Wishlist redirect
			return {
				statusCode: 308,
				statusDescription: 'Permanent Redirect',
				headers: {
					"location": {
						"value": "https://mywishlist.online/w/75dd8k/nathans-wishlist"
					}
				}
			}
		}

		if(
			(request.uri.endsWith('/feed')) ||
			(request.uri.endsWith('/feed/'))
		)
		{
			// This redirect is to help with users who may have had my feed from
			// when I was using either WordPress or WriteFreely
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
