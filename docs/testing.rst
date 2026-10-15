Testing
=======

CLI tests (no Slurm)
--------------------

.. code-block:: bash

   ./tests/test_cli.sh
   ./beyondfs doctor
   ./beyondfs run --participant_label sub-152 --first --dry-run

``tests/test_cli.sh`` checks help, list, doctor, rejected flags
(``--sclimbic``, ``--thalamic``, ``--train-nnunet``, ``--piriform nnunet``),
``--dry-run`` dispatch for every wired engine, and install stubs.

One-subject smoke (``sub-152``)
-------------------------------

.. list-table::
   :header-rows: 1
   :widths: 28 22 50

   * - Flag
     - Through CLI
     - Proof
   * - ``--piriform maper``
     - dry-run (already complete)
     - ``malf/sub-152-MAPER/sub-152_MAPER_Labels.nii.gz``
   * - ``--piriform jlf``
     - dry-run (already complete)
     - ``malf/sub-152/sub-152_Labels.nii.gz``
   * - ``--piriform ants-jlf``
     - dry-run (already complete)
     - ``malf/sub-152-ants/sub-152-ants_Labels.nii.gz``
   * - ``--claustrum``
     - dry-run (already complete)
     - ``clau_seg/outputs/IDEAS/sub-152/claustrum.{lh,rh}.topo.corrected.nii.gz``
   * - ``--first``
     - ``beyondfs run … --first --submit``
     - ``beyondfs/outputs/sub-152/first/``
   * - ``--synthseg``
     - ``beyondfs run … --synthseg --submit``
     - ``beyondfs/outputs/sub-152/synthseg/``
   * - stubs
     - CLI exits 2
     - install message, no job

Do not use ``--all-subjects`` for tests. Do not re-run MAPER/JLF/claustrum
on ``sub-152`` unless the label files are missing.

Not tested as jobs
------------------

ASHS, HippUnfold, SUIT, MAGeT, CERES, THOMAS, GIF, MALP-EM, SLANT,
AssemblyNet, HIPS, Hippodeep, ACAPULCO, and pBrain are not installed
here. The CLI must refuse them until the env var is set.
``--ants-ct``, ``--cat12``, ``--pincram``, ``--lst``, ``--bianca``, and
``--sct`` are rejected (not structure segmentation).
