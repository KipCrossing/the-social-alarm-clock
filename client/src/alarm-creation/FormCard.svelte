<script lang="ts">
  import { writable } from "svelte/store";
  import { onMount } from "svelte";
  import { fade, scale } from "svelte/transition";

  type T = $$Generic;
  export let inputEmpty: boolean;
  export let inputValid: boolean;
  export let emptyHeader: string;
  export let filledHeader: string;
  export let itemNumber: number;

  let active = false;
  let container: HTMLElement;
  let initialWidth = writable(0);
  onMount(() => {
    $initialWidth = container.getBoundingClientRect().width;
  });

  function activeOnChildClick(node: HTMLElement) {
    const handleFocusIn = (e: MouseEvent) => {
      active = node.contains(e.target as Node);
    };

    document.addEventListener("click", handleFocusIn);
    return {
      destroy: () => {
        document.removeEventListener("click", handleFocusIn);
      },
    };
  }

  $: buttonClasses = () => {
    const classes = [];
    if (active) classes.push(" duration-500 scale-105 shadow-lg ");
    if (inputEmpty) return classes.join(" ");
    if (inputValid) classes.push(" border border-cyan-400 ");
    if (!inputValid) classes.push(" border border-red-500 ");
    return classes.join(" ");
  };
</script>

<button
  class={`bg-highlight-transparent-grey relative z-50 flex h-[65px] flex-col justify-start rounded-xl px-2 transition 
    ${buttonClasses()} ${active || !inputEmpty ? "" : "pb-2"}`}
  use:activeOnChildClick
  bind:this={container}
>
  <div class={"text-s text-bold pt-1 text-zinc-500"} style="line-height: 1em">
    {itemNumber}
    {#if active || !inputEmpty}
      <span transition:fade>{active || !inputEmpty ? filledHeader : ""}</span>
    {/if}
  </div>
  <div class="grid flex-grow items-center">
    {#if active || !inputEmpty}
      <div class="col-start-1 row-start-1 self-center px-1" transition:scale>
        <slot />
      </div>
    {:else}
      <div
        out:fade={{ duration: 200 }}
        in:fade={{ delay: 200 }}
        class="col-start-1 row-start-1 whitespace-nowrap"
      >
        {emptyHeader}
      </div>
    {/if}
  </div>
</button>
