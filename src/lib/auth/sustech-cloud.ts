import { OAuth2Client } from 'oslo/oauth2';

const clientId = 'test1';
const authorizeEndpoint = 'https://im.sustech.cloud/oidc/auth';
const tokenEndpoint = 'https://im.sustech.cloud/oidc/token';

const oauth2Client = new OAuth2Client(clientId, authorizeEndpoint, tokenEndpoint, {
	redirectURI: 'http://sustech-spaces.test/api/auth/callback'
});

export default oauth2Client;
