// +page.server.ts

import { db } from '$lib/db/db.server';
import { user } from '$lib/drizzle/schema';
import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load = (async (event) => {
	const result = await db.select().from(user);
	return {
		result
	};
}) satisfies PageServerLoad;
