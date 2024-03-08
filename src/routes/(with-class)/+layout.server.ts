import { lucia } from '$lib/auth.server';
import { getUserClasses } from '$lib/db/class.server';
import { redirect, type Actions, type ServerLoad } from '@sveltejs/kit';

export const load: ServerLoad = async ({ params, locals }) => {
	if (!locals.user) {
		console.log('no user');
		redirect(302, '/login');
	}

	const classes = await getUserClasses(1);

	return { ...classes };
};
