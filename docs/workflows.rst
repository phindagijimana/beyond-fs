Processing pipeline details
===========================

Each flag calls one published engine. beyond-fs does not fuse them into a
single registration.

Piriform — MAPER (default)
--------------------------

* **Flag:** ``--piriform maper``
* **Papers:** Heckemann et al., *NeuroImage* 2010;51:221–227 (MAPER).
  Steinbart et al., *Hum Brain Mapp* 2023;44:3196–3209 (PC labels 125/126).
* **Script:** ``Piriform_Segmentation/scripts/MAPER.sh``
* **Input:** skull-stripped T1 matching atlas naming.
* **Output:** ``malf/<sub>-MAPER/``

Use this for IDEAS volumetry that should be cited against Steinbart.

Piriform — ANTs JLF
-------------------

* **Flags:** ``--piriform jlf`` or ``--piriform ants-jlf``
* **Paper:** Wang et al., *IEEE TPAMI* 2013;35:611–623.
* **Scripts:** ``MALF.sh``, ``submit_ants_malf_ideas.sh``
* Same 30 Hammers PC atlases. Report as a sibling, not as MAPER.

Claustrum — Mauri
-----------------

* **Flag:** ``--claustrum``
* **Paper:** Mauri et al., *Hum Brain Mapp* 2025;46:e70303.
* Raw T1w; no ``recon-all``. Output under ``clau_seg/outputs/IDEAS/<sub>/``.

FSL FIRST
---------

* **Flag:** ``--first``
* **Paper:** Patenaude et al., *NeuroImage* 2011;56:907–922.
* Caudate, putamen, pallidum, thalamus, hippocampus, amygdala, accumbens
  (volume, not FS ``aseg``).

SynthSeg
--------

* **Flag:** ``--synthseg``
* **Paper:** Billot et al., *Med Image Anal* 2023;86:102789.
* Contrast-agnostic whole-brain labels. Own run, not FastSurfer.

ANTs cortical thickness
-----------------------

* **Flag:** ``--ants-ct``
* **Paper:** Tustison et al., *NeuroImage* 2014;99:37–45.
* Thickness engine, not Desikan / not FastSurfer.

Would still fit (CLI flags; install to enable)
----------------------------------------------

.. list-table::
   :header-rows: 1
   :widths: 18 42 40

   * - Flag
     - Paper
     - Why it matches
   * - ``--maget``
     - Pipitone et al., *NeuroImage* 2014;101:494–512
     - Multi-atlas subcortex; sibling to FIRST, not ``aseg``
   * - ``--ceres``
     - Romero et al., *NeuroImage* 2017;152:648–658
     - Cerebellum parcellation; SUIT is atlas/template, CERES is a second engine
   * - ``--pincram``
     - Heckemann et al., *NeuroImage* 2015;107:107–122
     - Brain mask / ICV; Steinbart used it to normalise PC volume
   * - ``--thomas``
     - Su et al., *NeuroImage* 2019;194:272–282
     - Thalamic nuclei without FS ``ThalamicNuclei`` — **not** official IDEAS FS
   * - ``--ashs``
     - Yushkevich et al., *NeuroImage* 2010 and 2015
     - MTL / hippocampal subfields (not FS ``hippoAmyg``)
   * - ``--hippunfold``
     - DeKraker et al., *eLife* 2022;11:e77945
     - Hippocampal surface / subfields
   * - ``--cat12``
     - Gaser et al., *GigaScience* 2024;13:giae049
     - SPM morphometry
   * - ``--suit``
     - Diedrichsen, *NeuroImage* 2006;33:127–138; atlas 2009
     - Cerebellum template / lobules

Not in this tool
----------------

nnU-Net (no published PC model yet), sclimbic / FS thalamic **downloads**,
``recon-all``, FastSurfer, fMRIPrep.
