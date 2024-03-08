<script lang="ts">
	import CaretSort from 'svelte-radix/CaretSort.svelte';
	import Check from 'svelte-radix/Check.svelte';
	import PlusCircled from 'svelte-radix/PlusCircled.svelte';

	import { cn } from '$lib/utils';
	import * as Avatar from '$lib/components/ui/avatar';
	import { Button } from '$lib/components/ui/button';
	import * as Command from '$lib/components/ui/command';
	import * as Dialog from '$lib/components/ui/dialog';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import * as Popover from '$lib/components/ui/popover';
	import * as Select from '$lib/components/ui/select';
	import { tick } from 'svelte';
	import type { Name } from 'drizzle-orm';
	import _ from 'lodash';

	let className: string | undefined | null = undefined;
	export { className as class };


	type Class = {
		id: number;
		name: string;
		semester: string;
	}
	export let classes: Class[];

	const groupedClasses = _.groupBy(classes, (c) => c.semester);

	let open = false;
	let showClassDialog = false;

	let selectedClass: Class = classes?.[0]

	function closeAndRefocusTrigger(triggerId: string) {
		open = false;

		tick().then(() => document.getElementById(triggerId)?.focus());
	}
</script>

<Dialog.Root bind:open={showClassDialog}>
	<Popover.Root bind:open let:ids>
		<Popover.Trigger asChild let:builder>
			<Button
				builders={[builder]}
				variant="outline"
				role="combobox"
				aria-expanded={open}
				aria-label="Select a class"
				class={cn('w-[200px] justify-between', className)}
			>
				<Avatar.Root class="mr-2 h-5 w-5">
					<Avatar.Image
						src="https://avatar.vercel.sh/${selectedClass.id}.png"
						alt={selectedClass.name}
						class="grayscale"
					/>
					<Avatar.Fallback>SC</Avatar.Fallback>
				</Avatar.Root>
				{selectedClass.name}
				<CaretSort class="ml-auto h-4 w-4 shrink-0 opacity-50" />
			</Button>
		</Popover.Trigger>
		<Popover.Content class="w-[200px] p-0">
			<Command.Root>
				<Command.Input placeholder="Search Class..." />
				<Command.List>
					<Command.Empty>No class found.</Command.Empty>
					{#each _.entries(groupedClasses) as [semester, classes]}
						<Command.Group heading={semester}>
							{#each classes as c}
								<Command.Item
									onSelect={() => {
										selectedClass = c;
										closeAndRefocusTrigger(ids.trigger);
									}}
									value={c.name}
									class="text-sm"
								>
									<Avatar.Root class="mr-2 h-5 w-5">
										<Avatar.Image
											src="https://avatar.vercel.sh/${c.id}.png"
											alt={c.name}
											class="grayscale"
										/>
										<Avatar.Fallback>SC</Avatar.Fallback>
									</Avatar.Root>
									{c.name}
									<Check
										class={cn(
											'ml-auto h-4 w-4',
											selectedClass.id !== c.id && 'text-transparent'
										)}
									/>
								</Command.Item>
							{/each}
						</Command.Group>
					{/each}
				</Command.List>
				<Command.Separator />
				<Command.List>
					<Command.Group>
						<Command.Item
							onSelect={() => {
								open = false;
								showClassDialog = true;
							}}
						>
							<PlusCircled class="mr-2 h-5 w-5" />
							Create Class
						</Command.Item>
					</Command.Group>
				</Command.List>
			</Command.Root>
		</Popover.Content>
	</Popover.Root>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title>Create class</Dialog.Title>
			<Dialog.Description>Add a new class to manage products and customers.</Dialog.Description>
		</Dialog.Header>
		<div>
			<div class="space-y-4 py-2 pb-4">
				<div class="space-y-2">
					<Label for="name">Class name</Label>
					<Input id="name" placeholder="Acme Inc." />
				</div>
				<div class="space-y-2">
					<Label for="plan">Subscription plan</Label>
					<Select.Root>
						<Select.Trigger>
							<Select.Value placeholder="Select a plan" />
						</Select.Trigger>
						<Select.Content>
							<Select.Item value="free">
								<span class="font-medium">Free </span>-<span class="text-muted-foreground">
									Trial for two weeks
								</span>
							</Select.Item>
							<Select.Item value="pro">
								<span class="font-medium">Pro</span> -
								<span class="text-muted-foreground"> $9/month per user </span>
							</Select.Item>
						</Select.Content>
					</Select.Root>
				</div>
			</div>
		</div>
		<Dialog.Footer>
			<Button variant="outline" on:click={() => (showClassDialog = false)}>Cancel</Button>
			<Button type="submit">Continue</Button>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>
