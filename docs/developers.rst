Developers
==========

Identity
--------

Add a flag only if it is **published structure segmentation that
FreeSurfer / FastSurfer do not already give you**, and you would cite
that paper in Methods.

Layout
------

* ``beyondfs`` — dispatcher (``list``, ``doctor``, ``run``).
* ``modules/submit_*.sh`` — Slurm wrappers for wired engines.
* ``modules/stub_not_installed.sh`` — documented-but-absent engines.
* ``modules/submit_nnunet_*.sh`` — training helpers; **not** CLI flags.
* ``MODULES.md`` — catalog + papers (also ``beyondfs list``).
* ``docs/`` — this Sphinx site.

Checklist for a new engine
--------------------------

1. Paper + citation in ``MODULES.md`` and :doc:`citing`.
2. Flag in ``beyondfs``; ``doctor`` check; submit script or stub.
3. Output path in :doc:`outputs`.
4. Row in :doc:`testing`.
5. ``./tests/test_cli.sh`` still passes.

Build docs
----------

.. code-block:: bash

   pip install -r docs/requirements.txt
   make -C docs html
