import { lucia } from '$lib/server/auth';
import { db } from '$lib/server/db';
import { luciaUser } from '$lib/server/drizzle/schema';
import { redirect, type Handle } from '@sveltejs/kit';
import { eq } from 'drizzle-orm';

export const handle: Handle = async ({ event, resolve }) => {
	const sessionId = event.cookies.get(lucia.sessionCookieName);
	if (!sessionId) {
		event.locals.user = null;
		event.locals.session = null;
		return resolve(event);
	}

	const { session, user } = await lucia.validateSession(sessionId);
	console.log(session, user);
	if (session && session.fresh) {
		const sessionCookie = lucia.createSessionCookie(session.id);
		// sveltekit types deviates from the de-facto standard
		// you can use 'as any' too
		event.cookies.set(sessionCookie.name, sessionCookie.value, {
			path: '.',
			...sessionCookie.attributes
		});
	}
	if (!session) {
		const sessionCookie = lucia.createBlankSessionCookie();
		event.cookies.set(sessionCookie.name, sessionCookie.value, {
			path: '.',
			...sessionCookie.attributes
		});
		event.locals.user = null;
		event.locals.session = null;
		return resolve(event);
	}

	const lu = await db.query.luciaUser.findFirst({
		where: eq(luciaUser.id, user!.id),
		with: { user: true }
	});
	if (!lu) {
		console.log('no user');
		redirect(302, '/login');
	}
	event.locals.user = lu.user;
	event.locals.session = session;
	return resolve(event);
};
