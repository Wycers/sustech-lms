<script lang="ts">
	import CaretSort from "svelte-radix/CaretSort.svelte";
	import Check from "svelte-radix/Check.svelte";
	import PlusCircled from "svelte-radix/PlusCircled.svelte";

	import { cn } from "$lib/utils";
	import * as Avatar from "$lib/components/ui/avatar";
	import { Button } from "$lib/components/ui/button";
	import * as Command from "$lib/components/ui/command";
	import * as Dialog from "$lib/components/ui/dialog";
	import { Input } from "$lib/components/ui/input";
	import { Label } from "$lib/components/ui/label";
	import * as Popover from "$lib/components/ui/popover";
	import * as Select from "$lib/components/ui/select";
	import { tick } from "svelte";

	let className: string | undefined | null = undefined;
	export { className as class };

	const groups = [
		{
			label: "Personal Account",
			classes: [
				{
					label: "Alicia Koch",
					value: "personal",
				},
			],
		},
		{
			label: "Classes",
			classes: [
				{
					label: "Acme Inc.",
					value: "acme-inc",
				},
				{
					label: "Monsters Inc.",
					value: "monsters",
				},
			],
		},
	];

	type Class = (typeof groups)[number]["classes"][number];

	let open = false;
	let showClassDialog = false;

	let selectedClass: Class = groups[0].classes[0];

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
				class={cn("w-[200px] justify-between", className)}
			>
				<Avatar.Root class="mr-2 h-5 w-5">
					<Avatar.Image
						src="https://avatar.vercel.sh/${selectedClass.value}.png"
						alt={selectedClass.label}
						class="grayscale"
					/>
					<Avatar.Fallback>SC</Avatar.Fallback>
				</Avatar.Root>
				{selectedClass.label}
				<CaretSort class="ml-auto h-4 w-4 shrink-0 opacity-50" />
			</Button>
		</Popover.Trigger>
		<Popover.Content class="w-[200px] p-0">
			<Command.Root>
				<Command.Input placeholder="Search Class..." />
				<Command.List>
					<Command.Empty>No class found.</Command.Empty>
					{#each groups as group}
						<Command.Group heading={group.label}>
							{#each group.classes as c}
								<Command.Item
									onSelect={() => {
										selectedClass = c;
										closeAndRefocusTrigger(ids.trigger);
									}}
									value={c.label}
									class="text-sm"
								>
									<Avatar.Root class="mr-2 h-5 w-5">
										<Avatar.Image
											src="https://avatar.vercel.sh/${c.value}.png"
											alt={c.label}
											class="grayscale"
										/>
										<Avatar.Fallback>SC</Avatar.Fallback>
									</Avatar.Root>
									{c.label}
									<Check
										class={cn(
											"ml-auto h-4 w-4",
											selectedClass.value !== c.value && "text-transparent"
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
			<Dialog.Description>
				Add a new class to manage products and customers.
			</Dialog.Description>
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
								<span class="font-medium">Free </span>-<span
									class="text-muted-foreground"
								>
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