Running beyond-fs
=================

A minimal command
-----------------

.. code-block:: bash

   ./beyondfs run --participant_label sub-152 --piriform maper --claustrum --submit

This submits MAPER (Steinbart PC) and Mauri claustrum as separate Slurm
jobs. Engines do not share a process.

Selecting subjects
------------------

.. code-block:: bash

   ./beyondfs run --participant_label sub-152 --first --synthseg
   ./beyondfs run --participants_file subjects.txt --piriform maper --claustrum
   ./beyondfs run --all-subjects --piriform maper   # explicit opt-in; discovers BIDS T1s

``--all-subjects`` walks ``sub-*/anat/*_T1w.nii.gz``. It will not run
unless you pass it.

Workflow scope
--------------

Combine any flags that apply. Each flag is an independent engine.

.. code-block:: bash

   ./beyondfs run --participant_label sub-152 \
     --piriform maper \
     --claustrum \
     --first \
     --synthseg \
     --submit

``--submit`` is the default on this cluster (``sbatch``). ``--local``
runs MAPER/JLF worker scripts without Slurm; claustrum and ANTs-strip
jobs still submit.

Resources
---------

Submit scripts request the ``interactive`` partition (12 h) unless a
module overrides. FIRST and SynthSeg use 8 CPUs; claustrum uses the
Mauri submit script (8 CPU, 24 GB, 2 h).

Preview
-------

.. code-block:: bash

   ./beyondfs list     # module catalog + papers
   ./beyondfs doctor   # environment
   ./beyondfs --help
   ./beyondfs run --participant_label sub-152 --first --dry-run
   ./tests/test_cli.sh
