---
layout: home
title: Home
nav_order: 1
permalink: /
---

<div style="display: flex; align-items: center;">
  <img src="{{ 'assets/logos/mosaiclogo.png' | relative_url }}" alt="Your Logo" style="max-height: 100px">&nbsp;&nbsp;
  <h2>Modular System for Acceleration Integration (MoSAIC)</h2>
</div>

*A Multi-Tiled Architecture for Accurate and Fast Message-Driven Computing Exploration by LBNL.*

[<i class="fa-brands fa-github"></i> Github]({{ 'https://github.com/lbnlcomputerarch/MoSAIC-P38' }}){:target="_blank" .btn .btn-purple .mr-2}
[<i class="fa-brands fa-readme"></i> Documentation]({{ '/docs' | relative_url }}){: .btn .btn-blue .mr-2}
[<i class="fa-solid fa-chalkboard"></i> Learn More]({{ '/Research' | relative_url }}){: .btn .btn-primary .mr-2}

<div style="display: flex; justify-content: center;">
  <img src="{{ 'assets/images/Processors talking.png' | relative_url }}" alt="Processors talking" style="max-height: 400px">
</div>


### About This Project

<!-- - MoSAIC is a multi-tiled architecture for accurate and fast message-driven computing exploration. -->
- MoSAIC is written in SystemVerilog.
- Each tile can house a lightweight RISCV processor such as the PICORV32 or a generic accelerator.
- The tiles are connected through a lightweight network on chip (NoC) following an AXIStream protocol.
- Each tile has a hardware message queue for inter-tile communication used for message-driven computation.
- A RISCV ISA extension enables straight access to the physical message queue or remote memory through C/C++ primitives (qPut, qGet, qWait, qPoll, mPut, mGet).
- Partitioned global address scheme (PGAS). 


<div class="card-grid">
  <a href="https://lbnlcomputerarch.github.io/docs/" class="site-card" target="_blank">🗂️<div class="card-title">Access our Resources</div><p> Guides on connecting to our servers via SSH, using a remote graphical desktop via VNC or XRDP, and others.</p></a>
  <a href="/docs/dependencies" class="site-card" target="_blank">📦<div class="card-title">Dependencies</div><p>Not using our servers? Find out what tools you need!</p></a>
  <a href="/docs/getting-started" class="site-card" target="_blank">🚀<div class="card-title">Getting Started</div><p>Use MoSAIC!</p></a>
  <a href="/people" class="site-card" target="_blank">🔎<div class="card-title">About Us</div><p>Meet the people behind MoSAIC!</p></a>
</div>

{: .new-title }
> New to MoSAIC?
>
> 1. Start with *Documentation → Getting Started*
> 2. Find tutorials in *Documentation → Using MoSAIC*

<div style="display: flex; justify-content: right;">
  <!-- <a href="{{ '/docs/using-mosaic' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-left-long"></i> Go back</a> -->
  <a href="{{ '/docs' | relative_url }}" class="btn btn-light mr-2"><i class="fa-solid fa-arrow-right-long"></i> Continue</a>
</div>
