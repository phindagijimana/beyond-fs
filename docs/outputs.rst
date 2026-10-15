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
     - ANTs brain under ``subjects/<sub>-ants/``; labels ``malf/<sub>-ants/``
   * - ``--claustrum``
     - ``clau_seg/outputs/IDEAS/<sub>/``
   * - ``--first``
     - ``beyondfs/outputs/<sub>/first/``
   * - ``--synthseg``
     - ``beyondfs/outputs/<sub>/synthseg/``
   * - ``--ants-ct``
     - ``beyondfs/outputs/<sub>/ants-ct/``

Logs
----

Slurm stdout/stderr:

* Piriform: ``Piriform_Segmentation/malf/logs/``
* Claustrum: ``clau_seg/logs/``
* FIRST / SynthSeg / ANTs CT: ``beyondfs/logs/``

Citation boilerplate
--------------------

Copy the papers for the flags you actually ran (see :doc:`citing`). Do not
cite beyond-fs as the segmentation method.
