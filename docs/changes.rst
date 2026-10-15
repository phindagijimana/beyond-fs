What's New
==========

0.5.2 (October 2026)
--------------------

* Drop ``--ants-ct``, ``--cat12``, ``--pincram`` (thickness / morphometry
  / ICV). CLI rejects them.

0.5.1 (October 2026)
--------------------

* Drop ``--lst``, ``--bianca``, ``--sct`` (lesion / spinal, not structure
  segmentation). CLI rejects them.

0.5.0 (October 2026)
--------------------

* Structure-seg flags: ``--gif``, ``--malp-em``, ``--slant``,
  ``--assemblynet``, ``--hips``, ``--hippodeep``, ``--acapulco``,
  ``--pbrain``.
* Lesion/spinal flags (not named brain structures): ``--lst``,
  ``--bianca``, ``--sct``.

0.4.1 (October 2026)
--------------------

* Each pipeline page cites the method paper and lists steps.
* Pincram citation corrected to Heckemann et al., *PLoS One* 2015
  (not *NeuroImage* 107).
* ``--dry-run`` and ``tests/test_cli.sh``.
* Docs: testing, developers; trimmed duplicate module table.
* FIRST copies T1 into the output dir; ANTs CT binds both home paths.
* Fix: ``run`` exited 1 after a successful submit when the last flag was off.

0.4.0 (October 2026)
--------------------

* CLI: ``beyondfs run | list | doctor``.
* Wired: MAPER, JLF, ants-jlf, claustrum, FIRST, SynthSeg, ANTs CT.
* Documented flags: ASHS, HippUnfold, CAT12, SUIT, MAGeT, CERES, Pincram,
  THOMAS.
* Identity rule: published structure segs beyond FreeSurfer/FastSurfer.
* Sphinx / Read the Docs site (this documentation).

0.3.0
-----

* Dropped sclimbic/thalamic download and nnU-Net from the CLI.

0.1.0
-----

* First dispatcher over MAPER, JLF, and Mauri claustrum.
