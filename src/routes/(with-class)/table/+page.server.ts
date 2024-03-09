// +page.server.ts

import { db } from '$lib/server/db';
import { user } from '$lib/server/drizzle/schema';
import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load = (async (event) => {
	const result = await db.select().from(user);
	return {
		result
	};
}) satisfies PageServerLoad;
