<script lang="ts">
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import * as Avatar from '$lib/components/ui/avatar';
	import { Button } from '$lib/components/ui/button';
	let signoutForm: HTMLFormElement;

	export let user: {
		name: string;
		sid: string;
		imageUrl: string;
	};
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger asChild let:builder>
		<Button variant="ghost" builders={[builder]} class="relative h-8 w-8 rounded-full">
			<Avatar.Root class="h-8 w-8">
				<Avatar.Image src={user.imageUrl} alt="@shadcn" />
				<Avatar.Fallback>{user.name.substring(0, 1)}</Avatar.Fallback>
			</Avatar.Root>
		</Button>
	</DropdownMenu.Trigger>
	<DropdownMenu.Content class="w-56" align="end">
		<DropdownMenu.Label class="font-normal">
			<div class="flex flex-col space-y-1">
				<p class="text-sm font-medium leading-none">{user.name}</p>
				<p class="text-xs leading-none text-muted-foreground">{user.sid}</p>
			</div>
		</DropdownMenu.Label>
		<DropdownMenu.Separator />
		<DropdownMenu.Group>
			<DropdownMenu.Item>
				Profile
				<!-- <DropdownMenu.Shortcut>⇧⌘P</DropdownMenu.Shortcut> -->
			</DropdownMenu.Item>
			<!-- <DropdownMenu.Item>
				Billing
				<DropdownMenu.Shortcut>⌘B</DropdownMenu.Shortcut>
			</DropdownMenu.Item> -->
			<DropdownMenu.Item>
				Settings
				<!-- <DropdownMenu.Shortcut>⌘S</DropdownMenu.Shortcut> -->
			</DropdownMenu.Item>
			<!-- <DropdownMenu.Item>New Team</DropdownMenu.Item> -->
		</DropdownMenu.Group>
		<DropdownMenu.Separator />
		<form method="post" action="/sign-out" bind:this={signoutForm}>
			<DropdownMenu.Item on:click={() => signoutForm.submit()}>
				Log out
				<!-- <DropdownMenu.Shortcut>⇧⌘Q</DropdownMenu.Shortcut> -->
			</DropdownMenu.Item>
		</form>
	</DropdownMenu.Content>
</DropdownMenu.Root>
