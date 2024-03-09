import { redirect } from '@sveltejs/kit';
import { generateCodeVerifier, generateState } from 'oslo/oauth2';

import type { RequestEvent } from '@sveltejs/kit';
import oauth2Client from '$lib/server/auth/sustech-cloud';

export async function GET(event: RequestEvent): Promise<Response> {
	const state = generateState();
	const codeVerifier = generateCodeVerifier();
	const url = await oauth2Client.createAuthorizationURL({
		state,
		scopes: ['openid profile sustech']
		// codeVerifier
	});

	event.cookies.set('_oauth_state', state, {
		path: '/',
		secure: import.meta.env.PROD,
		httpOnly: true,
		maxAge: 60 * 10,
		sameSite: 'lax'
	});

	redirect(302, url.toString());
}
