---
layout: page
title: Sweep
parent: Existing Accelerators
nav_order: 8
---
# Sweep: FP-Adder Mesh Testcase

{: .note }
"Sweep" is not a standalone accelerator — it is the testcase (`tools/generate/mosaic_sweep.pl`) that exercises the [FP adder tile](../fp) across a larger 8x8 mesh. This page walks through that configuration.

## Tile Layout

```perl
$new_tile{'fp_add'} = 'Tile_fp_adder';

$param{'r'} = 8;
$param{'c'} = 8;
# generic_tile_array() fills the 8x8 grid with 'pico' tiles by default, then:

$tile_array[0][1] = 'spad';   $pico_program[1]              = 'nop.hex';
$tile_array[1][1] = 'fp_add'; $pico_program[1*$c+1]         = '';
$tile_array[1][2] = 'spad';   $pico_program[1*$c+2]         = 'nop.hex';
```

Only tiles `(0,1)`, `(1,1)`, and `(1,2)` are overridden from the default all-`pico` grid: a scratchpad feeding data in, the FP adder tile, and a scratchpad receiving the result. The remaining tiles keep the default pico firmware from `generic_tile_array()`.

Because this testcase pushes more traffic through the mesh, it also widens the NoC buffer depth:

```perl
$param{'noc_buffer_addr_w'} = 9;   # default is 8
```

Firmware `pico_add3` (from `tools/picorv_c/c_fp_acc/`) drives the test; `check_fp_adder.sh` validates results after simulation. The script builds for Vivado (`board = 'u250'`) but leaves `run_sim = 0` and `vivado_project = 0` — i.e. it generates the design without automatically launching a simulation or building a full project.

## Purpose

Unlike the minimal 8x8-with-one-accelerator layout in [FP: Testcase `mosaic_fp.pl`](../fp), this configuration is meant to validate the FP adder tile sitting inside a **larger, mostly-default mesh** rather than a dedicated small test grid — useful for checking NoC routing/buffering behavior (hence the widened buffer) when the accelerator is not adjacent to the driving pico in a minimal topology.

<div style="display: flex; justify-content: space-between;">
  <a href="{{ '/docs/existing-accelerators/scf' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-left-long"></i> Go back</a>
  <a href="{{ '/docs/existing-accelerators/demo' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-right-long"></i> Continue</a>
</div>
