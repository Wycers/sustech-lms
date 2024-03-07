import { building, dev } from '$app/environment';
import { DATABASE_URL } from '$env/static/private';
import * as schema from '$lib/drizzle/schema';

import { drizzle, type MySql2Database } from 'drizzle-orm/mysql2';
import mysql from 'mysql2/promise';

let db: MySql2Database<typeof schema>;

declare global {
	var __db: MySql2Database<typeof schema> | undefined;
}

if (dev) {
	const connection = await mysql.createConnection({
		uri: DATABASE_URL
	});
	db = drizzle(connection, { schema, mode: 'default' });
} else {
	if (!building) {
		if (!global.__db) {
			const connection = await mysql.createConnection({
				uri: DATABASE_URL
			});
			global.__db = drizzle(connection, { schema, mode: 'default' });
		}
		db = global.__db;
	}
}
export { db };
