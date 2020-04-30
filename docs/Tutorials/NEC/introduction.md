---
title: "0. Introduction"
date: 2020-04-09
draft: false
---

<!-- <Last revision: 2020-04-09 by M. Hermanowicz <m.hermanowicz@icm.edu.pl> -->

!!! Note
    Please note that a PDF version of the materials contained herein is also [available][en_nec_tsubasa_pdf].

[en_nec_tsubasa_pdf]: ./pdf/en_nec_tsubasa.pdf

!!! Info
    This document aims to provide basic information on how to use the NEC SX-Aurora Tsubasa system
    available at ICM UW computational facility. The contents herein are based on a number of documents,
    as referenced in the text, to provide a concise quick start guide and suggest further reading material for
    the ICM users.

[NEC SX-Aurora Tsubasa][1], announced in 2017, is a vector processor (vector engine, VE) belonging to
the SX architecture line which has been developed by NEC Corporation since mid-1980s. Unlike its
stand-alone predecessors, Tsubasa has been designed as a PCIe card working within and being operated
by an x86 64 host server (vector host, VH) running a distribution of the GNU/Linux operating system.
The latter provides a complete software development environment for the connected VEs and runs
Vector Engine Operating System ([VEOS][2]) which, in turn, serves as operating system to the VE programs.

ICM UW provides its users with a NEC SX-Aurora Tsubasa installation as part of the Rysy cluster (the **ve** partition) with the following specification:

|           | Vector Host (VH)     | Vector Engine (VE)           |
|-----------|----------------------|------------------------------|
| CPU model | Intel Xeon Gold 6126 | NEC SX-Aurora Tsubasa A300-8 |
| CPU Cores | 2 x 12               | 8 x 8                        |
| RAM       | 192 GB               | 8 x 48 GB                    |

[1]: https://www.nec.com/en/global/solutions/hpc/sx/index.html
[2]: https://github.com/veos-sxarr-NEC/veos
