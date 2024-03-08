<script lang="ts">
	import { Editor, rootCtx, defaultValueCtx } from '@milkdown/core';
	import { commonmark } from '@milkdown/preset-commonmark';
	import { gfm } from '@milkdown/preset-gfm';
	import { math } from '@milkdown/plugin-math';
	import { clipboard } from '@milkdown/plugin-clipboard';
	import { nord } from '@milkdown/theme-nord';
	import 'katex/dist/katex.min.css';

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
			.use(math)
			.use(clipboard)
			.create();
	}
</script>

<div use:editor />

<style>
</style>
