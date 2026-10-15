Troubleshooting
===============

Getting help
------------

1. ``./beyondfs doctor``
2. The Slurm ``.err`` file for that job name
3. :doc:`cli` for rejected flags

Logs and crash files
--------------------

* ``antsJointLabelFusion`` “not recognized as a supported image format”:
  OASIS T1 is a 0-byte git-annex stub. Re-download from
  ``https://templateflow.s3.amazonaws.com/tpl-OASIS30ANTs/``.
* Claustrum ``lta_wrap`` ENOENT: bind both
  ``/mnt/nfs/home/urmc-sh.rochester.edu/...`` and
  ``/mnt/nfs/home/URMC-SH/...``; ``chmod +x lta_wrap``.
* ``--piriform maper`` missing brain: convert FastSurfer ``brain.mgz`` or
  use ``--piriform ants-jlf``.
* Outlook “no suitable outbound connector” / ``MAILTO:``: URMC mail, not a
  dead academic address. Type SMTP addresses; do not paste ``mailto:``
  links.

**``beyondfs run`` printed the ``sbatch`` line then exited 1**
  Fixed in 0.4.1: a failing ``[[ flag ]] &&`` as the last line of
  ``run_subject`` made ``set -e`` abort. Re-run ``./tests/test_cli.sh``.

FAQ
---

**Is this fMRIPrep?**
  No. It is a specialty pack of structure segmentations.

**Should I cite beyond-fs?**
  Cite MAPER/Steinbart, Mauri, FIRST, etc. The wrapper is lab
  infrastructure.

**Can I add another tool?**
  Only if it is published structure segmentation FS/FastSurfer do not
  already give you, and you would cite that paper in Methods.

**nnU-Net?**
  Not a beyond-fs module. Training lives beside this repo
  (``training.md`` in the piriform project).
