import { type RequestEvent } from '@sveltejs/kit';
import { OAuth2RequestError } from 'oslo/oauth2';

import { luciaUser, oauth2Credential } from '$lib/server/drizzle/schema';
import oauth2Client, { credentials } from '$lib/server/auth/sustech-cloud';
import { lucia } from '$lib/server/auth';
import { db } from '$lib/server/db';
import { eq } from 'drizzle-orm';

export async function GET(event: RequestEvent): Promise<Response> {
	const code = event.url.searchParams.get('code');
	const state = event.url.searchParams.get('state');

	const storedState = event.cookies.get('_oauth_state') ?? null;
	if (!code || !state || !storedState || state !== storedState) {
		return new Response(null, {
			status: 400
		});
	}

	try {
		const tokens = await oauth2Client.validateAuthorizationCode(code, {
			credentials,
			authenticateWith: 'request_body'
		});
		console.log(tokens);

		const userResponse = await fetch('https://im.sustech.cloud/oidc/me', {
			headers: {
				Authorization: `Bearer ${tokens.access_token}`
			}
		});
		const user: SUSTechUser = await userResponse.json();
		console.log(user);

		const existingUser = await db.query.oauth2Credential.findFirst({
			where: eq(oauth2Credential.sub, user.sub),
			with: {
				user: true
			}
		});
		console.log(existingUser);

		if (existingUser) {
			// Replace this with your own DB client.
			const existingLuciaUser = await db.query.luciaUser.findFirst({
				where: eq(luciaUser.id, user.sub)
			});
			if (!existingLuciaUser) {
				await db.insert(luciaUser).values({ id: user.sub, userId: existingUser.id });
			}

			const session = await lucia.createSession(existingUser.sub, {});
			const sessionCookie = lucia.createSessionCookie(session.id);
			event.cookies.set(sessionCookie.name, sessionCookie.value, {
				path: '.',
				...sessionCookie.attributes
			});
			console.log('good');
		} else {
			// const userId = generateId(15);
			// // Replace this with your own DB client.
			// await db.insert(luciaUser).values({ id: userId, userId: existingUser });
		}
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

interface SUSTechUser {
	sub: string;
	sustech_id: number;
}
