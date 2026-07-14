---
layout: page
title: Demo
parent: Existing Accelerators
nav_order: 9
---
# Demo: Asynchronous Triangular Solver Testcase

{: .note }
"Demo" is not a hardware accelerator — `mosaic_demo.pl` runs a software algorithm (an asynchronous triangular solver) entirely on plain `pico`/`spad` tiles, using the DRAM/[cache tile](../cache) for shared storage. There is no dedicated accelerator tile involved.

{: .warning }
`tools/generate/mosaic_demo.pl` sets `use lib "$ENV{PWD}/../picorv_c/c_trisolver"` and `$fw_path = "$path/../picorv_c/c_trisolver"`, but that directory does not exist in the repository — the firmware actually lives in `tools/picorv_c/c_demo/`. This looks like a leftover from a directory rename; update the path to `c_demo` before running this testcase.

## What It Does

The firmware (`tools/picorv_c/c_demo/async_trisolve.c`) implements an **asynchronous sparse triangular solver** across the mesh — each pico tile owns one row/column block of a sparse matrix (by default, a 2D Laplace/5-point-stencil matrix, `ConstructLaplace2D5pt()`), and tiles pass partial results to each other as soon as their dependencies are satisfied, rather than waiting on a global synchronization barrier. See [P38-IUSG-Graphs](https://github.com/jshalf/P38-IUSG-Graphs/tree/master/Jordi) for background on the algorithm.

## Tile Layout

```perl
$param{'r'} = 7;
$param{'c'} = 8;
# generic_tile_array() fills the grid with 'pico' tiles, then:
$tile_array[0][1] = 'spad';   # one scratchpad tile inserted into the mesh

$param{'ddr4_flag'}       = 1;   # tile memory manager / cache enabled
$param{'ddr_cache_lines'} = 8;
$param{'ddr_init_file'}   = 'test_tile_nop.hex';
```

A 7x8 = 56-tile mesh, mostly `pico` cores, with one scratchpad and the DRAM/cache tile providing shared backing storage. Firmware is compiled from `async_trisolve.c`, and `check_pico_spad.sh`, `check_pico_ddr4_ctrl.sh`, and `check_pkt_cache.sh` validate the run.

## Software: `async_trisolve.c`

Each tile computes its own logical tile ID (accounting for the scratchpad tile occupying a slot in the middle of the grid) and, on tile 0, constructs the input matrix:

```c
int tid_h = atoi(argv[1]);
int tid_r = tid_h % 8;
int tid_c = tid_h / 8;
int tid   = tid_c * IN_HW_ROW + tid_r;
if (tid_h > 8) { tid = tid - 1; }   // account for the scratchpad occupying slot 8

if (tid_h == 0) {
    ConstructLaplace2D5pt();        // build the sparse input matrix (or smallExample())
}
```

Tiles then pass a "start" token down the array (`qPut`/`qWait`) to sequence dependent work, and use `qGet` to receive their initialization message (header + data) before beginning their portion of the triangular solve:

```c
if (last tile in the array) {
    qPut(0, 0);                      // signal completion back to tile 0
} else {
    qWait(0, header);
    qPut(next_tid_h, 0);             // kick off the next tile in sequence
}

qGet(0, header);
qGet(0, data);
```

This models a data-flow-driven (rather than bulk-synchronous) solve: each tile only proceeds once it has received the values it depends on from its predecessor(s), which is the core idea behind an *asynchronous* triangular solver.

<div style="display: flex; justify-content: space-between;">
  <a href="{{ '/docs/existing-accelerators/sweep' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-left-long"></i> Go back</a>
  <a href="{{ '/docs/existing-accelerators/sne' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-right-long"></i> Continue</a>
</div>
