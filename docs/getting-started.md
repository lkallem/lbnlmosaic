---
layout: page
title: Getting Started
parent: Documentation
permalink: /docs/getting-started
nav_order: 1
---
# Getting Started

## Verifying Proper Installation
1. Go to `/tools/generate`
2. Execute `perl mosaic_2x2_vivado.pl` in the command line.

If successful, you should see `INFO: Finish without errors`.

{: .warning-title}
> Note
>
> If you are not using our servers, you may need to reset the tools path as specified by the `$MosaicGlobal` param in `tools/generate/gen_mosaic.pm`. 
>
> You may also need to change the source of the tools as indicated by line 25 in `vivado/launch_sim.sh`.


## Using Vivado

{: .warning-title}
> Note
>
> Do step 1 only if using our servers.

### 1. Access a remote graphical desktop. 
[Guide here.](https://lbnlcomputerarch.github.io/docs/) 
### 2. Run the Commands
In your remote desktop, run:
```
source /tools/source-vitis.sh 2022.2
```
If the above was successful, run:
```
vivado
```
### 3. Open the project
Open `MoSAIC_P38/vivado/mosaic`

### 4. Top level file
Open `Simulation sources → sim_1`. If `tb_mosaic.sv` is not the top level file, set it as the top level file (right click → set as top)


<div style="display: flex; justify-content: space-between;">
  <a href="{{ '/docs/dependencies' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-left-long"></i> Go back</a>
  <a href="{{ '/docs/using-mosaic' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-right-long"></i> Continue</a>
</div>
