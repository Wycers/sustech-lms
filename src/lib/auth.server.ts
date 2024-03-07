import { Lucia } from 'lucia';
import { dev } from '$app/environment';

declare module 'lucia' {
	interface Register {
		Lucia: typeof lucia;
	}
}

import { DrizzleMySQLAdapter, DrizzlePostgreSQLAdapter } from '@lucia-auth/adapter-drizzle';

import { db } from './db/db.server';
import { luciaSession, luciaUser } from './drizzle/schema';
const adapter = new DrizzleMySQLAdapter(db, luciaSession, luciaUser);

export const lucia = new Lucia(adapter, {
	sessionCookie: {
		attributes: {
			// set to `true` when using HTTPS
			secure: !dev
		}
	}
});