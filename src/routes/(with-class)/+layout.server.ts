import { db } from '$lib/server/db';
import { getUserClasses } from '$lib/server/db/class';
import { luciaUser } from '$lib/server/drizzle/schema';
import { redirect, type Actions, type ServerLoad } from '@sveltejs/kit';
import { eq } from 'drizzle-orm';

export const load: ServerLoad = async ({ params, locals }) => {
	const { user } = locals;
	if (!user) {
		console.log('no user');
		redirect(302, '/login');
	}

	const { classes } = await getUserClasses(user.id);

	return {
		user: {
			name: user.name,
			imageUrl: user.image,
			sid: user.sid
		},
		classes
	};
};
