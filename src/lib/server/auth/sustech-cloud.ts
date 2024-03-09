import { OAuth2Client } from 'oslo/oauth2';
import { env } from '$env/dynamic/private';

const clientId = env.CLIENT_ID || 'test1';
export const credentials = env.CLIENT_SECRET || 'test1';
const redirectURI = env.CLIENT_CALLBACK || 'https://lms.sustech.cloud/api/auth/callback';

const authorizeEndpoint = 'https://im.sustech.cloud/oidc/auth';
const tokenEndpoint = 'https://im.sustech.cloud/oidc/token';

const oauth2Client = new OAuth2Client(clientId, authorizeEndpoint, tokenEndpoint, {
	redirectURI
});

export default oauth2Client;
