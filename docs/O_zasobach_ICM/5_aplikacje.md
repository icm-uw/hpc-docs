---
title: "Aplikacje"
date: 2020-04-09
draft: false
---

<!-- <Last revision: 2020-04-15 by M. Hermanowicz <m.hermanowicz@icm.edu.pl> -->

## Informacje ogólne

Zbiór aplikacji dostępnych na komputerach ICM ulega częstym zmianom –
w szczególności pod względem zainstalowanych wersji. Poniższa lista
zawiera najważniejsze z nich, jednak należy mieć na uwadze, że może
nie uwzględniać niedawnych zmian.

**Czy możemy zainstalować aplikację X**? W większości przypadków tak –
  pod warunkiem, że jej licencja na to pozwala. Preferowane jest tym
  samym oprogramowanie objęte jedną z [wolnych
  licencji][gpl-compatible], również tych, które nie są kompatybilne z
  GNU GPL, ale spełniają [definicję wolnego
  oprogramowania][free_software].

[gpl-compatible]: https://www.gnu.org/licenses/license-list.en.html#GPLCompatibleLicenses
[free_software]: https://www.gnu.org/philosophy/free-sw.en.html

Użytkownicy ICM mają ponadto dostęp do aplikacji objętych licencjami
krajowymi. W przypadku programów, które nie należą do tej kategorii, a
nie są objęte wolną licencją, obowiązek pozyskania licencji i
dopełnienia jej warunków spoczywa na Użytkowniku.

Prośby o instalację aplikacji należy zgłaszać na adres
<pomoc@icm.edu.pl>.

Użytkownicy mają także możliwość samodzielnej kompilacji i instalacji
oprogramowania z wykorzystaniem dostępnych w systemach narzędzi. W tym
przypadku również mają zastosowanie powyższe uwagi dotyczące licencji.

## Python: Instalacja bibliotek

Jeżeli wymagane jest użycie niedostępnych w systemie bibliotek języka
Python, należy je zainstalować samodzielnie z wykorzystaniem
środowiska wirtualnego. Można to zrobić według poniższej instrukcji.

0. Uruchamiamy [sesję interaktywną][slurm-interactive].
1. Ładujemy interpreter Pythona z [dostępnego modułu][modules].
2. Tworzymy środowisko wirtualne (Python 3.x): `python3.6 -m venv python_venv` (gdzie `python_venv` jest nazwą nowego folderu, w którym zostanie utworzone środowisko wirtualne.
3. Aktywujemy środowisko: `source ./python_venv/bin/activate`
4. Aktualizujemy narzędzie: `pip install --upgrade pip`
5. Instalujemy potrzebne biblioteki, np. `pip install numpy`
6. Środowisko wirtualne jest gotowe. Po zakończeniu pracy wystarczy wydać polecenie "deactivate", a wracając do pracy z Pythonem należy pamiętać, żeby je wcześniej aktywować (punkt 3) - dopiero wówczas zainstalowane lokalnie biblioteki będą dostępne.

[slurm-interactive]: http://127.0.0.1:8000/HPC-intro/4_SlurmIntro/#tryb-interaktywny
[modules]: http://127.0.0.1:8000/HPC-intro/4_SlurmIntro/#polecenia-module

## Lista aplikacji

###**ABINIT**
* *A software suite to calculate the optical, mechanical,
  vibrational, and other observable properties of materials. Starting
  from the quantum equations of density functional theory, you can
  build up to advanced applications with perturbation theories based
  on DFT, and many-body Green's functions (GW and DMFT). ABINIT can
  calculate molecules, nanostructures and solids with any chemical
  composition, and comes with several complete and robust tables of
  atomic potentials* (za [stroną internetową][abinit] projektu).

*  [https://www.abinit.org][abinit]
[abinit]: https://www.abinit.org/
* Licencja: GNU General Public License
* Dostępność: Topola, Okeanos

***

###**AMBER**
* A suite of biomolecular simulation programs.
[amber]: https://ambermd.org/
* [https://ambermd.org/][amber]
* Licencja krajowa
* Dostępność: Okeanos

***

###**ANSYS Fluent**
* Offers *physical modeling capabilities needed to
  model flow, turbulence, heat transfer and reactions for industrial
  applications* (za [stroną internetową][ansys] programu).

[ansys]: https://www.ansys.com/products/fluids/ansys-fluent
* [https://www.ansys.com/products/fluids/ansys-fluent][ansys]
* Licencja krajowa
* Dostępność: Topola, Okeanos

***

###**CP2K**
* *A quantum chemistry and solid state physics software
  package that can pe
  rform atomistic simulations of solid state,
  liquid, molecular, periodic, material, crystal, and biological
  systems. CP2K provides a general framework for different modeling
  methods such as DFT using the mixed Gaussian and plane waves
  approaches GPW and GAPW. Supported theory levels include DFTB, LDA,
  GGA, MP2, RPA, semi-empirical methods (AM1, PM3, PM6, RM1, MNDO, ...),
  and classical force fields (AMBER, CHARMM, ...). CP2K can do
  simulations of molecular dynamics, metadynamics, Monte Carlo,
  Ehrenfest dynamics, vibrational analysis, core level spectroscopy,
  energy minimization, and transition state optimization using NEB or
  dimer method.* (za [stroną internetową][cp2k] projektu).

[cp2k]: https://www.cp2k.org/
* [https://www.cp2k.org/][cp2k]
* Licencja: GNU General Public License
* Dostępność: Topola, Okeanos

***

###**CPMD**
* *A parallelized plane wave / pseudopotential implementation
  of Density Functional Theory, particularly designed for ab-initio
  molecular dynamics* (za [stroną internetową][cpmd] projektu).

[cpmd]: https://www.cpmd.org
* [https://www.cpmd.org][cpmd]
* Licencja: własnościowa, gratis dla organizacji non-profit
* Dostępność: Topola

***

###**DALTON**
* A molecular electronic structure program.
[dalton]: https://daltonprogram.org
* [https://daltonprogram.org][dalton]

* Licencja: własnościowa
* Dostępność: Topola

***

### **ELK**
* *An all-electron full-potential linearised augmented-plane wave (LAPW) code.*

[elk]: http://elk.sourceforge.net/
* [http://elk.sourceforge.net/][elk]

* Licencja: GNU General Public License
* Dostępność: Topola, Okeanos

***

###**EXCITING**
*A full-potential all-electron density-functional-theory package implementing the families of linearized augmented planewave methods. It can be applied to all kinds of materials, irrespective of the atomic species involved, and also allows for exploring the physics of core electrons. A particular focus are excited states within many-body perturbation theory* (za [stroną internetową][exciting] projektu).

[exciting]: http://exciting-code.org
* [http://exciting-code.org][exciting]
* Licencja: GNU General Public License
* Dostępność: Topola

***

###**ESYS-PARTICLE**
* *Open Source software for particle-based numerical modelling. The software implements the Discrete Element Method (DEM), a widely used technique for modelling processes involving large deformations, granular flow and/or fragmentation* (za [stroną internetową][esys] projektu).

[esys]: https://launchpad.net/esys-particle
* [https://launchpad.net/esys-particle][esys]
* Licencja: Apache License 2.0
* Dostępność: Okeanos

***

###**FHI-AIMS**
* Full-Potential, All-Electron Electronic Structure Theory with Numeric Atom-Centered Basis Functions.

[fhi]: https://aimsclub.fhi-berlin.mpg.de/
* [https://aimsclub.fhi-berlin.mpg.de/][fhi]
* Licencja: [własnościowa][fhi-license]
[fhi-license]: https://aimsclub.fhi-berlin.mpg.de/aims_obtaining_simple.php
* Dostępność: Topola

***

###**GAMESS**
* *The General Atomic and Molecular Electronic Structure System (GAMESS)
is a general ab initio quantum chemistry package.*

[gamess]: https://www.msg.chem.iastate.edu/gamess/
* [https://www.msg.chem.iastate.edu/gamess/][gamess]
* Licencja: [własnościowa][gamess-license]
[gamess-license]: https://www.msg.chem.iastate.edu/gamess/download.html
* Dostępność: Topola

***

###**GAUSSIAN**
* Electronic structure modelling software.

* [https://gaussian.com/][gaussian]
[gaussian]: https://gaussian.com/
* Licencja: własnościowa
* Dostępność: Topola

***

###**GROMACS**
* *GROMACS is a versatile package to perform molecular dynamics, i.e. simulate the Newtonian equations of motion for systems with hundreds to millions of particles* (za [stroną internetową projektu][gromacs]).

[gromacs]: http://www.gromacs.org

* [http://www.gromacs.org][gromacs]
* Licencja: GNU Lesser General Public License
* Dostępność: Topola, Okeanos

***

###**JULIA**
* The Julia Programming Language designed for high performance.
* [https://julialang.org][julia]
[julia]: https://julialang.org
* Licencja: MIT License
* Dostępność: Topola

***

###**LAMMPS**
* *A classical molecular dynamics code with a focus on materials modeling. It's an acronym for Large-scale Atomic/Molecular Massively Parallel Simulator.*
* [https://lammps.sandia.gov][lammps]
[lammps]: https://lammps.sandia.gov
* Licencja: GNU General Public License
* Dostępność: Topola, Okeanos

***

###**LD-DYNA**
* A general-purpose finite element program.
* [http://www.lstc.com/products/ls-dyna](http://www.lstc.com/products/ls-dyna)
* Licencja: własnościowa
* Dostępność: Okeanos

***

###**NAMD**
* *A parallel molecular dynamics code designed for high-performance simulation of large biomolecular systems.*
* [https://www.ks.uiuc.edu/Research/namd/][namd]
[namd]: https://www.ks.uiuc.edu/Research/namd/
* Licencja: [własnościowa](https://www.ks.uiuc.edu/Research/namd/license.html)
* Dostępność: Topola, Okeanos

***

###**NWChem**
* Computational chemistry tools.
* [http://www.nwchem-sw.org/index.php/Main_Page](http://www.nwchem-sw.org/index.php/Main_Page)
* Licencja: [Educational Community License](https://opensource.org/licenses/ecl2.php)
* Dostępność: Topola, Okeanos

***

###**OpenFOAM**
*  Free and open source CFD software.
* [https://www.openfoam.com/](https://www.openfoam.com/)
* Licencja: GNU General Public License
* Dostępność: Topola, Okeanos

***

###**OpenMX**
* *OpenMX (Open source package for Material eXplorer) is a software package for nano-scale material simulations based on density functional theories (DFT), norm-conserving pseudopotentials, and pseudo-atomic localized basis functions. The methods and algorithms used in OpenMX and their implementation are carefully designed for the realization of large-scale ab initio electronic structure calculations on parallel computers based on the MPI or MPI/OpenMP hybrid parallelism* (za [stroną internetową][openmx] projektu).
* [http://www.openmx-square.org/][openmx]
[openmx]: http://www.openmx-square.org
* Licencja: GNU General Public License
* Dostępność: Topola

***

###**ORCA**
* A quantum-chemical software package.
* [https://www.faccts.de/orca/](https://www.faccts.de/orca/)
* Licencja: własnościowa
* Dostępność: Topola

***

###**QUANTUM ESPRESSO**
* *An integrated suite of Open-Source computer codes for electronic-structure calculations and materials modeling at the nanoscale. It is based on density-functional theory, plane waves, and pseudopotentials* (za [stroną internetową][qe] projektu).
[qe]: https://www.quantum-espresso.org/
* [https://www.quantum-espresso.org/][qe]
* Licencja: GNU General Public License
* Dostępność: Topola, Okeanos

***

###**R**
* *R is a free software environment for statistical computing and graphics.*
* [https://www.r-project.org](https://www.r-project.org)
* Licencja: GNU General Public License
* Dostępność: Topola, Okeanos

***

###**SIESTA**
* *SIESTA is both a method and its computer program implementation, to perform efficient electronic structure calculations and ab initio molecular dynamics simulations of molecules and solids. SIESTA's efficiency stems from the use of a basis set of strictly-localized atomic orbitals* (za [stroną internetową][siesta] projektu).
[siesta]: https://departments.icmab.es/leem/siesta/
* [https://departments.icmab.es/leem/siesta/][siesta]
* Licencja: GNU General Public License (od wersji 4.0)
* Dostępność: Topola, Okeanos

***

###**VASP**
* *The Vienna Ab initio Simulation Package: atomic scale materials modelling from first principles.*
* [https://www.vasp.at](https://www.vasp.at)
* Licencja: własnościowa
* Dostępność: Topola, Okeanos
