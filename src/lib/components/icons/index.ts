import Loader2 from 'lucide-svelte/icons/loader-2';

import type { SvelteComponent } from 'svelte';
import SustechCloud from './sustech-cloud.svelte';

export type Icon = SvelteComponent;

export const Icons = {
	spinner: Loader2,
	sustechCloud: SustechCloud
};
