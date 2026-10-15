Outputs
=======

Layout and naming
-----------------

beyond-fs does not overwrite FreeSurfer or FastSurfer trees. Each engine
writes to its own folder.

.. list-table::
   :header-rows: 1
   :widths: 28 72

   * - Flag
     - Output
   * - ``--piriform maper``
     - ``Piriform_Segmentation/malf/<sub>-MAPER/``
   * - ``--piriform jlf``
     - ``Piriform_Segmentation/malf/<sub>/``
   * - ``--piriform ants-jlf``
     - ANTs brain under ``subjects/<sub>-ants/``; labels ``malf/<sub>-ants/<sub>-ants_Labels.nii.gz``
   * - ``--claustrum``
     - ``clau_seg/outputs/IDEAS/<sub>/``
   * - ``--first``
     - ``beyondfs/outputs/<sub>/first/``
   * - ``--synthseg``
     - ``beyondfs/outputs/<sub>/synthseg/``
   * - stubs (GIF … pBrain)
     - no output until the engine is installed; CLI exits 2

Logs
----

Slurm stdout/stderr:

* Piriform: ``Piriform_Segmentation/malf/logs/``
* Claustrum: ``clau_seg/logs/``
* FIRST / SynthSeg: ``beyondfs/logs/``

Citation boilerplate
--------------------

Copy the papers for the flags you actually ran (see :doc:`citing`).
What each engine does, step by step: :doc:`workflows`. Do not cite
beyond-fs as the segmentation method.
