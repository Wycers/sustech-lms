<script lang="ts">
	import { ClassSwitcher, DashboardMainNav, Search, UserNav } from '$lib/components/dashboard';
	import '../../app.pcss';
	import type { PageData } from './$types';

	export let data: PageData;

	// const { classes } = data;

	export let classes = data.classes.map((c) => {
		return {
			id: c.id,
			name: c.name,
			semester: ''
		};
	});
</script>

<div class="hidden flex-col md:flex">
	<div class="border-b">
		<div class="flex h-16 items-center px-4">
			{#if classes.length > 0}
				<ClassSwitcher {classes} />
			{/if}
			<DashboardMainNav className="mx-6" />
			<div class="ml-auto flex items-center space-x-4">
				<Search />
				<UserNav user={data.user} />
			</div>
		</div>
	</div>
	<div class="flex-1 space-y-4 p-8 pt-6">
		<slot />
	</div>
</div>
