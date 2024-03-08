<script>
	import { ClassSwitcher, DashboardMainNav, Search, UserNav } from '$lib/components/dashboard';
	import '../app.pcss';
</script>

<div class="hidden flex-col md:flex">
	<div class="border-b">
		<div class="flex h-16 items-center px-4">
			<ClassSwitcher />
			<DashboardMainNav class="mx-6" />
			<div class="ml-auto flex items-center space-x-4">
				<Search />
				<UserNav />
			</div>
		</div>
	</div>
	<div class="flex-1 space-y-4 p-8 pt-6">
		<slot />
	</div>
</div>
