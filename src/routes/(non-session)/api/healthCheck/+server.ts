import { type RequestEvent } from '@sveltejs/kit';

export async function GET(event: RequestEvent): Promise<Response> {
	return new Response(null, {
		status: 201
	});
}
