beyond-fs: specialty segmentations beyond FreeSurfer
====================================================

**beyond-fs** dispatches published structure-segmentation methods that
FreeSurfer and FastSurfer do not already produce. It is a thin CLI over
separate engines. Cite the method papers, not this wrapper.

Full documentation: https://beyond-fs.readthedocs.io
(GitHub Pages: https://phindagijimana.github.io/beyond-fs/)

Source: https://github.com/phindagijimana/beyond-fs

About
-----

Keep the identity as **published structure segmentation that FreeSurfer /
FastSurfer do not already give you**. Add a method only if you would cite
that paper in a methods section, not because it is “another MRI tool.”

The main features of this software are:

1. A single command (``beyondfs run``) with flags for piriform, claustrum,
   FIRST, SynthSeg, ANTs cortical thickness, and related published tools.
2. Engines stay separate (MAPER, Mauri ``mri_claustrum_seg``, FSL FIRST,
   ``mri_synthseg``, ``antsCorticalThickness.sh``). The wrapper only
   chooses which script to submit.
3. A ``doctor`` command that checks containers, atlases, licenses, and
   which optional packages are installed.

Project defaults
^^^^^^^^^^^^^^^^

* Piriform: **MAPER** (Heckemann 2010; Steinbart 2023 PC protocol).
* Claustrum: **Mauri 2025** ``mri_claustrum_seg``.
* ANTs JLF is a credible sibling for PC, not the Steinbart methods claim.

Note
----

beyond-fs is **not** fMRIPrep, QSIPrep, or ``recon-all``. Similarities in
the documentation layout do not imply that those projects endorse this
tool. Downstream papers should cite Steinbart/MAPER, Mauri, FIRST, etc.

.. toctree::
   :maxdepth: 2
   :caption: Documentation

   installation
   preparing
   usage
   cli
   workflows
   outputs
   citing
   troubleshooting
   changes
   license
