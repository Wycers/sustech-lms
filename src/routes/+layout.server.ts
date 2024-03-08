import { getUserClasses } from '$lib/db/class.server';
import { redirect, type ServerLoad } from '@sveltejs/kit';

export const load: ServerLoad = async ({ params, locals }) => {
	// if (!locals.user) redirect(302, '/login');

	const classes = await getUserClasses(1);

	return { ...classes };
};
