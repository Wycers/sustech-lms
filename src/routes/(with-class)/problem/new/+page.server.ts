import { type ServerLoad } from '@sveltejs/kit';
import _ from 'lodash';

export const load: ServerLoad = async ({ params }) => {
	return {
		data: ''
	};
};
