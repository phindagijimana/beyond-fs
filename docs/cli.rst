Command-line reference
======================

Invocation::

   beyondfs [list | doctor | run] [options]

``run`` may be omitted: flags after the subject id are still accepted.

Required for ``run``
--------------------

.. option:: --participant_label LABEL, --subject LABEL, -s LABEL

   Repeatable BIDS participant id (``sub-152``).

.. option:: --participants_file FILE

   One subject id per line (``#`` comments allowed).

.. option:: --all-subjects

   Discover every ``*_T1w.nii.gz`` under ``--bids-dir``. Opt-in.

Input
-----

.. option:: --bids-dir PATH

   BIDS root. Default: ``BEYONDFS_BIDS``.

.. option:: --submit / --local

   Slurm vs local worker (MAPER/JLF only).

Module flags
------------

.. option:: --piriform {maper,jlf,ants-jlf}

   Piriform cortex. ``maper`` is the paper method. ``jlf`` is ANTs joint
   label fusion. ``ants-jlf`` strips the raw T1 with ANTs then JLF.

.. option:: --claustrum

   Mauri 2025 ``mri_claustrum_seg``.

.. option:: --first

   FSL FIRST (Patenaude 2011).

.. option:: --synthseg

   SynthSeg via ``mri_synthseg`` (Billot 2023).

.. option:: --ants-ct

   ANTs cortical thickness (Tustison 2014).

.. option:: --ashs, --hippunfold, --cat12, --suit, --maget, --ceres, --pincram, --thomas

   Documented; exit with install instructions until the matching
   environment variable is set (see :doc:`installation`).

   ``--thomas`` must not be used on official IDEAS FreeSurfer (download
   ``ThalamicNuclei`` instead).

Help
----

.. option:: --help, -h

   Usage.

.. option:: --version

   Print ``beyondfs`` version.

.. option:: list, --list

   Print :doc:`workflows` catalog.

.. option:: doctor, --doctor

   Environment check.

Not flags
---------

``--sclimbic``, ``--thalamic``, and ``--train-nnunet`` are rejected.
Those are not beyond-fs modules.
