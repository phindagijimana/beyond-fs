Installation
============

beyond-fs is a bash CLI plus Slurm submit scripts. Clone the repository
and make the dispatcher executable.

.. code-block:: bash

   git clone https://github.com/phindagijimana/beyond-fs.git
   cd beyond-fs
   chmod +x beyondfs
   ./beyondfs --help
   ./beyondfs doctor

External dependencies
---------------------

Wired modules expect containers or binaries on the host (or a cluster
module system). Override paths with environment variables if yours differ.

.. list-table::
   :header-rows: 1
   :widths: 22 38 40

   * - Module
     - Needs
     - Environment
   * - ``--piriform maper``
     - MAPER scripts, MIRTK, NiftySeg, 30 Hammers PC atlases
     - ``BEYONDFS_PIRIFORM``
   * - ``--piriform jlf`` / ``ants-jlf``
     - ANTs via fMRIPrep SIF; OASIS30ANTs template
     - ``FMRIPREP_SIF``
   * - ``--claustrum``
     - Mauri ``mri_claustrum_seg``, FreeSurfer 7.4 SIF, license, ``lta_wrap``
     - ``BEYONDFS_CLAU``, ``FS_SIF``, ``FS_LICENSE``
   * - ``--first``
     - FSL SIF (``run_first_all``)
     - ``FSL_SIF``
   * - ``--synthseg``
     - ``mri_synthseg`` in the FreeSurfer SIF
     - ``FS_SIF``, ``FS_LICENSE``
   * - ``--ashs``
     - ASHS install + atlas
     - ``ASHS_ROOT``
   * - ``--hippunfold``
     - HippUnfold container
     - ``HIPPUNFOLD_SIF``
   * - ``--suit``
     - MATLAB + SPM12 + SUIT
     - ``SUIT_DIR``, ``MATLAB_SIF``
   * - ``--maget``
     - MAGeT Brain
     - ``MAGET_ROOT``
   * - ``--ceres``
     - CERES / volBrain container
     - ``CERES_SIF``
   * - ``--thomas``
     - HIPS-THOMAS container (not official IDEAS FS)
     - ``THOMAS_SIF``
   * - ``--gif``
     - NiftySeg GIF
     - ``GIF_ROOT``
   * - ``--malp-em``
     - MALPEM package
     - ``MALPEM_ROOT``
   * - ``--slant``
     - SLANT container
     - ``SLANT_SIF``
   * - ``--assemblynet``
     - AssemblyNet container
     - ``ASSEMBLYNET_SIF``
   * - ``--hips``
     - volBrain HIPS
     - ``HIPS_SIF``
   * - ``--hippodeep``
     - Hippodeep executable
     - ``HIPPODEEP``
   * - ``--acapulco``
     - ACAPULCO Singularity image
     - ``ACAPULCO_SIF``
   * - ``--pbrain``
     - pBrain / volBrain PD
     - ``PBRAIN_SIF``

BIDS input is set with ``--bids-dir`` or ``BEYONDFS_BIDS``.

Check the environment
---------------------

.. code-block:: bash

   ./beyondfs doctor

``doctor`` reports missing SIFs and optional toolboxes as warnings. It
fails only when the core piriform/claustrum scripts or atlases are absent.
