import type { Config } from 'drizzle-kit';
export default {
	schema: './src/lib/drizzle/schema.ts',
	out: './src/lib/drizzle',
	driver: 'mysql2',
	dbCredentials: {
		uri: process.env.DATABASE_URL!
	}
} satisfies Config;