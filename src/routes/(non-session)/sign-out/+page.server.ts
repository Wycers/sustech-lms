import { lucia } from '$lib/server/auth';
import type { Actions } from '@sveltejs/kit';

export const actions: Actions = {
	default: async (event) => {
		const sessionId = event.cookies.get(lucia.sessionCookieName);
		if (!sessionId) {
			event.locals.user = null;
			event.locals.session = null;
			return { success: false };
		}

		await lucia.invalidateSession(sessionId);
		return { success: true };
	}
};
