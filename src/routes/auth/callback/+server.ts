import { OAuth2RequestError } from 'oslo/oauth2';

import type { RequestEvent } from '@sveltejs/kit';
import oauth2Client from '$lib/auth/sustech-cloud';

export async function GET(event: RequestEvent): Promise<Response> {
	const code = event.url.searchParams.get('code');
	const state = event.url.searchParams.get('state');
	const storedState = event.cookies.get('github_oauth_state') ?? null;
	console.log(code, state, storedState);
	if (!code || !state || !storedState || state !== storedState) {
		return new Response(null, {
			status: 400
		});
	}

	try {
		const tokens = await oauth2Client.validateAuthorizationCode(code, {
			credentials: 'test1',
			authenticateWith: 'request_body'
		});
		console.log(tokens);

		const githubUserResponse = await fetch('https://im.sustech.cloud/oidc/me', {
			headers: {
				Authorization: `Bearer ${tokens.access_token}`
			}
		});
		console.log(await githubUserResponse.json());
		// const githubUser: GitHubUser = await githubUserResponse.json();

		// Replace this with your own DB client.
		// const existingUser = await db.table('user').where('github_id', '=', githubUser.id).get();

		// if (existingUser) {
		// 	const session = await lucia.createSession(existingUser.id, {});
		// 	const sessionCookie = lucia.createSessionCookie(session.id);
		// 	event.cookies.set(sessionCookie.name, sessionCookie.value, {
		// 		path: '.',
		// 		...sessionCookie.attributes
		// 	});
		// } else {
		// 	const userId = generateId(15);

		// 	// Replace this with your own DB client.
		// 	await db.table('user').insert({
		// 		id: userId,
		// 		github_id: githubUser.id,
		// 		username: githubUser.login
		// 	});

		// 	const session = await lucia.createSession(userId, {});
		// 	const sessionCookie = lucia.createSessionCookie(session.id);
		// 	event.cookies.set(sessionCookie.name, sessionCookie.value, {
		// 		path: '.',
		// 		...sessionCookie.attributes
		// 	});
		// }
		return new Response(null, {
			status: 302,
			headers: {
				Location: '/'
			}
		});
	} catch (e) {
		console.log(e);
		// the specific error message depends on the provider
		if (e instanceof OAuth2RequestError) {
			// invalid code
			console.log(e.request.url);
			return new Response(null, {
				status: 400
			});
		}
		return new Response(null, {
			status: 500
		});
	}
}

interface GitHubUser {
	id: number;
	login: string;
}
