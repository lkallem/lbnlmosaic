---
layout: page
title: Existing Accelerators
parent: Using MoSAIC
nav_order: 5
has_children: true
---
# Existing Accelerators

A guide to the accelerator tiles and example testcases currently in the `MoSAIC-P38` repository (`src/Tile.HDL/`), based on a review of their HDL source.

## Accelerator Tiles

| Tile | Type | Notes |
|---|---|---|
| [ASA](existing-accelerators/asa) | Key/data associative accelerator | NoC glue is in-repo; the ASA compute core itself is an external black box |
| [Cache](existing-accelerators/cache) | Direct-mapped, write-back DRAM cache | Backs the mesh's shared-memory (`mPut`/`mGet`/`mLoad`/`mStore`) address space |
| [FFT](existing-accelerators/fft) | Fast Fourier Transform | Chisel-generated, single-precision floating point, multiple size/width configs |
| [FP](existing-accelerators/fp) | Floating point ALU | Adder, multiplier, divider, square root — one tile type each |
| [TSQR](existing-accelerators/tsqr) | Tall-Skinny QR decomposition | Chisel-generated Householder-QR pipeline; typically paired with FFT |
| [MoDIN](existing-accelerators/modin) | Spiking neuromorphic processor | Lives on the `modin` git branch, not `main` |

## Example Testcases

A few pages in this section document **testcases** rather than standalone accelerator hardware — they combine or stress-test the tiles above:

| Testcase | Demonstrates |
|---|---|
| [SCF](existing-accelerators/scf) | Combined FFT + TSQR pipeline across a 3x3 mesh |
| [Sweep](existing-accelerators/sweep) | FP adder tile inside a larger 8x8 mesh |
| [Demo](existing-accelerators/demo) | Software-only asynchronous triangular solver using the cache tile |
| [SNE](existing-accelerators/sne) | Placeholder — no corresponding hardware/software found in the repository |

See the sub-pages for detailed specifications, NoC protocol details, and worked software examples for each.

<div style="display: flex; justify-content: space-between;">
  <a href="{{ '/docs/testcases/boards' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-left-long"></i> Go back</a>
  <a href="{{ '/docs/existing-accelerators/asa' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-right-long"></i> Continue</a>
</div>
