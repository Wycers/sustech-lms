import { DATABASE_URL } from '$env/static/private';
import * as schema from '$lib/drizzle/schema';

import { drizzle } from 'drizzle-orm/mysql2';
import mysql from 'mysql2/promise';

const connection = await mysql.createConnection({
	uri: DATABASE_URL
});

export const db = drizzle(connection, { schema, mode: 'default' });
