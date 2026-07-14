---
layout: page
title: MoSAIC 2x2
parent: Using MoSAIC
nav_order: 0
---
# MoSAIC 2x2
## About
Perl scripts in `/tools/generate` (such as `mosaic_2x2.pl`) are used to generate MoSAIC arrays. You can set the following parameters :

- MoSAIC array row and column sizes
- Tiles used in the MoSAIC array
- Icarus or Vivado simulation
- Simulation time
- C file paths (paths to C code that gives the Pico(s) instructions)
- Firmware path
- Checker files
- FPGA board type (u250 or u280)
- DDR4 inclusion
- DDR cache lines
- NoC Bandwidth
- etc.

## Configuration Overview
This is a 2x2 mosaic array with Picos on tile 0 (`000-000`) and tile 9 (`001-001`), a loop on tile 1 (`000-001`) and an SPAD on tile 8 (`001-000`).
<br><br>
<div style="display: flex; justify-content: center;">
  <img src="{{ '/assets/images/mosaic_2x2.png' | relative_url }}" alt="Processors talking" style="max-height: 400px">
</div>

## Running the Example

### Setting Row and Column Parameters
```perl
#- 2x2 Tile array
$param{'r'} = 2;
$param{'c'} = 2;
```

### Setting Tile Array and Hex Files
```perl
@tile_array = (['pico', 'spad'],
               ['loop', 'pico']);

@pico_program  = ('pico_scratchpad.hex', '', '', 'test_tile_nop.hex');
```
We can set tile positions with `@tile_array`. The hex files in `@pico_program` contain instructions for the Pico processors. Hex files can be generated and they will follow instructions written with C code. We will generate hex files in another example.

### Setting Simulation Time
```perl
#- Simulation Time
$param{'sim_loop'}     = 260;
```
Here, we set how long we want the simulation to go for. Make sure the simulation has enough time, otherwise the checkers may report a false negative.

### Setting Checker Files
```perl
#- Checkers
@checkers = ('check_pico_spad.sh');
```
Checkers are located in `/tools/checkers`. Checker files work by reading tile memory contents dumped into `.dat` files after the simulation is finished. Memory files can be found in `/icarus/`. Note that they will only work to see traffic caused by `mPuts`, and NOT `qPuts`.

### Running a Simulation with Icarus
```perl
#- Running with Icarus
$param{'run_sim'} = 1;
```
Does not launch Vivado. Waveforms can be viewed by accessing `/icarus/tb_mosaic.vcd`. To conveniently view waveforms by simply opening this file in your IDE, download a waveform viewer extension such as [Surfer for VSCode](https://marketplace.visualstudio.com/items?itemName=surfer-project.surfer).

### Running a Simulation with Vivado (`mosaic_2x2_vivado.pl`)
```perl
#- Running with Vivado
$param{'vivado'} = 1;  
$param{'vivado_project'} = 1;
$param{'run_sim'} = 1;
```
Note that rerunning a perl script with `vivado_project` set to 1 will overwrite your waveform configurations! Make sure to save your waveform files. 

<div style="display: flex; justify-content: space-between;">
  <a href="{{ '/docs/using-mosaic' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-left-long"></i> Go back</a>
  <a href="{{ '/docs/hex-files' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-right-long"></i> Continue</a>
</div>
