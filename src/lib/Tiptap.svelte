<script>
	import { onMount, onDestroy } from 'svelte';
	import { Editor } from '@tiptap/core';
	import StarterKit from '@tiptap/starter-kit';

	import Collaboration from '@tiptap/extension-collaboration';
	import CollaborationCursor from '@tiptap/extension-collaboration-cursor';

	import * as Y from 'yjs';
	import { WebrtcProvider } from 'y-webrtc';

	/**
	 * @type {HTMLDivElement}
	 */
	let element;
	/**
	 * @type {Editor}
	 */
	let editor;

	onMount(() => {
		const ydoc = new Y.Doc();
		const provider = new WebrtcProvider('tiptap-test', ydoc);
		editor = new Editor({
			element: element,
			extensions: [
				StarterKit,
				Collaboration.configure({
					document: ydoc
				}),
				CollaborationCursor.configure({
					provider,
					user: {
						name: 'X',
						color: '#DEBEEF'
					}
				})
			],
			content: '<p>Hello World! 🌍️ </p>',
			editorProps: {
				attributes: {
					class:
						'prose dark:prose-invert prose-sm sm:prose-base lg:prose-lg xl:prose-2xl m-5 focus:outline-none'
				}
			},
			onTransaction: () => {
				// force re-render so `editor.isActive` works as expected
				editor = editor;
			}
		});
	});

	onDestroy(() => {
		if (editor) {
			editor.destroy();
		}
	});
</script>

{#if editor}
	<button
		on:click={() => editor.chain().focus().toggleHeading({ level: 1 }).run()}
		class:active={editor.isActive('heading', { level: 1 })}
	>
		H1
	</button>
	<button
		on:click={() => editor.chain().focus().toggleHeading({ level: 2 }).run()}
		class:active={editor.isActive('heading', { level: 2 })}
	>
		H2
	</button>
	<button
		on:click={() => editor.chain().focus().setParagraph().run()}
		class:active={editor.isActive('paragraph')}
	>
		P
	</button>
{/if}

<div bind:this={element} />

<style>
	button.active {
		background: black;
		color: white;
	}
/* Give a remote user a caret */
.collaboration-cursor__caret {
  position: relative;
  margin-left: -1px;
  margin-right: -1px;
  border-left: 1px solid #0D0D0D;
  border-right: 1px solid #0D0D0D;
  word-break: normal;
  pointer-events: none;
}

/* Render the username above the caret */
.collaboration-cursor__label {
  position: absolute;
  top: -1.4em;
  left: -1px;
  font-size: 12px;
  font-style: normal;
  font-weight: 600;
  line-height: normal;
  user-select: none;
  color: #0D0D0D;
  padding: 0.1rem 0.3rem;
  border-radius: 3px 3px 3px 0;
  white-space: nowrap;
}
</style>

