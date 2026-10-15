Preparing your data
===================

BIDS requirements
-----------------

beyond-fs looks for a raw T1w per subject:

.. code-block:: text

   bids_dir/
     sub-<label>/
       anat/
         sub-<label>_T1w.nii.gz

Pass the root with ``--bids-dir`` or ``BEYONDFS_BIDS``.

Piriform MAPER / JLF extra
--------------------------

``--piriform maper`` and ``--piriform jlf`` need a skull-stripped brain
named like the Hammers atlases:

.. code-block:: text

   Piriform_Segmentation/subjects/sub-<label>/
     sub-<label>_BrainExtractionBrain.nii.gz

``--piriform ants-jlf`` takes the raw BIDS T1 and runs ANTs
``antsBrainExtraction`` (OASIS30ANTs) first. Use that path when you want
the strip to match the atlases (and later nnU-Net inference, which is
**not** a beyond-fs module).

Do not mix FastSurfer ``brain.mgz`` and ANTs brains in the same PC
comparison unless you treat them as two different methods.

Optional atlases
----------------

* Hammers n=30 PC labels 125/126: ``Piriform_Segmentation/atlas/``
* OASIS30ANTs: TemplateFlow. Empty git-annex stubs will break ANTs
  (ITK “not a supported image format”). ``doctor`` and the ANTs submit
  scripts reject 0-byte files.

What not to prepare
-------------------

* Do not rerun FreeSurfer sclimbic or ``ThalamicNuclei`` inside this
  tool. On official IDEAS, those are downloads from the FS zip.
* ``--thomas`` is only for cohorts **without** official FS thalamic nuclei.
