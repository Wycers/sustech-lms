<script>
	import { Editor, rootCtx, defaultValueCtx } from '@milkdown/core';
	import { commonmark } from '@milkdown/preset-commonmark';
	import { gfm } from '@milkdown/preset-gfm';
	import { nord } from '@milkdown/theme-nord';

	export let defaultValue = '';

	function editor(dom) {
		Editor.make()
			.config((ctx) => {
				ctx.set(rootCtx, dom);
				ctx.set(defaultValueCtx, defaultValue);
			})
			.config(nord)
			.use(commonmark)
			.use(gfm)
			.create();
	}
</script>

<div use:editor />

<style>
</style>
