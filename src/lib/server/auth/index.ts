import { Lucia } from 'lucia';
import { dev } from '$app/environment';

import { DrizzleMySQLAdapter } from '@lucia-auth/adapter-drizzle';

import { db } from '$lib/server/db';
import { luciaSession, luciaUser } from '$lib/server/drizzle/schema';

declare module 'lucia' {
	interface Register {
		Lucia: typeof lucia;
	}
}
const adapter = new DrizzleMySQLAdapter(db, luciaSession, luciaUser);

export const lucia = new Lucia(adapter, {
	sessionCookie: {
		attributes: {
			// set to `true` when using HTTPS
			secure: !dev
		}
	}
});
