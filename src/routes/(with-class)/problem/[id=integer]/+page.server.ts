import { db } from '$lib/server/db';
import { problem } from '$lib/server/drizzle/schema';
import { error, redirect, type ServerLoad } from '@sveltejs/kit';
import { eq } from 'drizzle-orm';
import _ from 'lodash';

export const load: ServerLoad = async ({ params }) => {
	const id = _.toNumber(params.id);
	const p = await db.query.problem.findFirst({ where: eq(problem.id, id) });
	console.log(p);

	if (_.isNil(p)) {
		error(404, {
			message: 'Not found'
		});
	}

	return {
		data: p.description
	};
};
