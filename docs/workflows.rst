Processing pipeline details
===========================

Each flag is one published engine. beyond-fs does not fuse them. Cite the
papers below (full records: :doc:`citing`), not this wrapper.

Piriform — MAPER (default)
--------------------------

**Flag:** ``--piriform maper``

**Cite:** Heckemann et al., *NeuroImage* 2010;51:221–227
(doi:10.1016/j.neuroimage.2010.01.072). PC definition and labels 125/126:
Steinbart et al., *Hum Brain Mapp* 2023;44:3196–3209
(doi:10.1002/hbm.26274).

Multi-atlas PC on a skull-stripped T1. MAPER registers on tissue class
first so large ventricles (AD, TLE) do not break the warp. Steinbart’s
automatic method. This is the IDEAS default.

1. Tissue-class maps (CSF / GM / WM) on the target and each of 30 Hammers
   atlases (NiftySeg ``seg_EM``).
2. Non-linear MIRTK FFD: tissue maps, then T1, atlas → target.
3. Warp each atlas PC (125 left, 126 right) onto the target.
4. Vote-rule fusion (``seg_LabFusion -MV``) → one label image.

Input: ``subjects/<sub>/<sub>_BrainExtractionBrain.nii.gz``.
Output: ``malf/<sub>-MAPER/``.

Piriform — ANTs JLF
-------------------

**Flags:** ``--piriform jlf`` or ``--piriform ants-jlf``

**Cite:** Wang et al., *IEEE Trans Pattern Anal Mach Intell*
2013;35:611–623 (doi:10.1109/TPAMI.2012.143). Brain extraction:
Avants et al., *NeuroImage* 2011;54:2033–2044. Same Steinbart 30 atlases;
**not** the Steinbart methods claim (that is MAPER).

1. ``ants-jlf`` only: ``antsBrainExtraction`` with OASIS30ANTs on the raw
   BIDS T1.
2. Register each atlas T1 to the target (ANTs SyN).
3. Warp atlas PC labels.
4. Joint label fusion: intensity-weighted vote that down-weights atlases
   whose errors are correlated.

Input: stripped brain (``jlf``) or raw T1 (``ants-jlf``).
Output: ``malf/<sub>/`` or ``malf/<sub>-ants/<sub>-ants_Labels.nii.gz``.

Claustrum — Mauri
-----------------

**Flag:** ``--claustrum``

**Cite:** Mauri C, Fritz R, Mora J, Billot B, Iglesias JE, Van Leemput K,
Augustinack J, Greve DN. A contrast-agnostic method for ultra-high
resolution claustrum segmentation. *Hum Brain Mapp*. 2025;46(12):e70303
(doi:10.1002/hbm.70303). Uses the SynthSeg training idea (Billot 2023).

1. Take the raw T1 (no ``recon-all``).
2. Align / crop each hemisphere; run the trained 3D U-Net at 0.35 mm
   (trained on 18 mostly ex-vivo claustrum labels with on-the-fly
   synthetic contrast).
3. Topology correction.
4. Write left and right claustrum (FS lookup id 139) in native space.

Output: ``clau_seg/outputs/IDEAS/<sub>/claustrum.{lh,rh}.topo.corrected.nii.gz``.

FSL FIRST
---------

**Flag:** ``--first``

**Cite:** Patenaude B, Smith SM, Kennedy DN, Jenkinson M. A Bayesian
model of shape and appearance for subcortical brain segmentation.
*NeuroImage*. 2011;56:907–922 (doi:10.1016/j.neuroimage.2011.02.046).

Volume subcortex, not FreeSurfer ``aseg``.

1. Copy T1 into the output directory; affine to MNI.
2. For each structure, fit a vertex-wise Bayesian shape-and-appearance
   model (``run_first_all``).
3. Boundary correction.
4. Meshes + voxel labels: L/R caudate, putamen, pallidum, thalamus,
   hippocampus, amygdala, accumbens (and brainstem).

Output: ``beyondfs/outputs/<sub>/first/``.

SynthSeg
--------

**Flag:** ``--synthseg``

**Cite:** Billot B, Greve DN, Puonti O, et al. SynthSeg: Segmentation of
brain MRI scans of any contrast and resolution without retraining.
*Med Image Anal*. 2023;86:102789 (doi:10.1016/j.media.2023.102789).

Whole-brain CNN. Own run, not FastSurfer.

1. ``mri_synthseg`` on the native T1 (``--parc --cpu``).
2. The network was trained on synthetic intensities generated from label
   maps (random contrast and resolution), so it is not tied to one
   scanner.
3. Writes a whole-brain label image (optional cortical parcellation).

Output: ``beyondfs/outputs/<sub>/synthseg/<sub>_synthseg.nii.gz``.

ASHS
----

**Flag:** ``--ashs`` (not installed)

**Cite:** Yushkevich et al., *NeuroImage* 2010;53:1208–1224
(doi:10.1016/j.neuroimage.2010.06.040) and 2015;105:425–437
(doi:10.1016/j.neuroimage.2014.10.052). MTL / hippocampal subfields, not
FS ``hippocampal-subfields-T1``.

1. Find the MTL / hippocampal ROI (T1, T2 if present).
2. Register the ASHS atlas set to the subject.
3. Joint label fusion of subfields.
4. Optional thickness / volume tables.

HippUnfold
----------

**Flag:** ``--hippunfold`` (not installed)

**Cite:** DeKraker J, et al. HippUnfold: automated hippocampal unfolding,
morphometry, and subfield segmentation. *eLife*. 2022;11:e77945
(doi:10.7554/eLife.77945).

1. Segment hippocampal grey matter (CNN).
2. Unfold it to a 2-D surface (Laplace / equivolume).
3. Subfield labels on the unfolded sheet.
4. Thickness and area in native and unfolded space.

SUIT
----

**Flag:** ``--suit`` (not installed)

**Cite:** Diedrichsen J. A spatially unbiased atlas template of the human
cerebellum. *NeuroImage*. 2006;33:127–138
(doi:10.1016/j.neuroimage.2006.05.056). Atlas: Diedrichsen et al.,
*NeuroImage* 2009;46:39–46 (doi:10.1016/j.neuroimage.2009.01.045).

1. Isolate the cerebellum from the T1.
2. Normalize it to the SUIT template.
3. Inverse-warp the probabilistic lobule atlas to native space.
4. Lobule volumes (or overlay fMRI).

MAGeT
-----

**Flag:** ``--maget`` (not installed)

**Cite:** Pipitone J, Park MTM, Winterburn J, et al. Multi-atlas
segmentation of the whole hippocampus and subfields using multiple
automatically generated templates. *NeuroImage*. 2014;101:494–512
(doi:10.1016/j.neuroimage.2014.06.042). Sibling to FIRST, not ``aseg``.

1. Register a small manual atlas set through many cohort templates.
2. Each subject becomes a candidate template (bootstrap).
3. Fuse the candidate labels (majority / weighted vote).
4. Subcortical / hippocampal labels on the target.

CERES
-----

**Flag:** ``--ceres`` (not installed)

**Cite:** Romero JE, Coupé P, Giraud R, et al. CERES: a new cerebellum
lobule segmentation method. *NeuroImage*. 2017;152:648–658
(doi:10.1016/j.neuroimage.2016.11.018). Second cerebellar engine; SUIT
is the template, CERES is patch-based parcellation.

1. Crop / register cerebellar atlases to the T1.
2. Non-local (patch-based) label fusion.
3. Lobule parcellation and volumes (volBrain CERES).

THOMAS
------

**Flag:** ``--thomas`` (not installed; **not** official IDEAS FS)

**Cite:** Su JH, Thomas FT, Kasoff WS, Tourdias T, Choi EY, Rutt BK,
Saranathan M. Thalamus Optimized Multi Atlas Segmentation (THOMAS):
fast, fully automated segmentation of thalamic nuclei from structural
MRI. *NeuroImage*. 2019;194:272–282
(doi:10.1016/j.neuroimage.2019.03.021).

1. White-matter-nulled T1 (or a synthesized WMn from MPRAGE).
2. Register thalamic-nuclei atlases (Morel-guided).
3. Label fusion → 12 nuclei per side.
4. Native-space volumes. On official IDEAS, download FS
   ``ThalamicNuclei`` instead.

GIF
---

**Flag:** ``--gif`` (not installed)

**Cite:** Cardoso MJ, Modat M, Wolz R, et al. Geodesic information flows:
spatially-variant graphs and their application to segmentation and
fusion. *IEEE Trans Med Imaging*. 2015;34:1976–1988
(doi:10.1109/TMI.2015.2418298).

1. Build a geodesic neighbourhood graph among atlases and the target.
2. Propagate anatomical labels along that graph (NiftySeg).
3. Fuse into one label image.

Not the Leon-Rojas piriform protocol.

MALP-EM
-------

**Flag:** ``--malp-em`` (not installed)

**Cite:** Ledig C, Heckemann RA, Hammers A, et al. Robust whole-brain
segmentation: application to traumatic brain injury. *Med Image Anal*.
2015;21:40–58 (doi:10.1016/j.media.2014.12.003).

1. N4 + Pincram brain mask.
2. MAPER-style label propagation.
3. Local label fusion.
4. EM intensity refinement → 138 structure labels.

SLANT
-----

**Flag:** ``--slant`` (not installed)

**Cite:** Huo Y, Xu Z, Xiong Y, et al. 3D whole brain segmentation using
spatially localized atlas network tiles. *NeuroImage*. 2019;194:105–119
(doi:10.1016/j.neuroimage.2019.03.041).

1. Register T1 to MNI.
2. Run spatially tiled 3D U-Nets.
3. Fuse overlapping tiles → 132 structure labels.

AssemblyNet
-----------

**Flag:** ``--assemblynet`` (not installed)

**Cite:** Coupé P, Mansencal B, Clément M, et al. AssemblyNet: a large
ensemble of CNNs for 3D whole brain MRI segmentation. *NeuroImage*.
2020;219:117026 (doi:10.1016/j.neuroimage.2020.117026).

1. Split the brain into overlapping patches.
2. Two “assemblies” of U-Nets (coarse then refine).
3. Majority vote → 133 structure labels.

HIPS
----

**Flag:** ``--hips`` (not installed)

**Cite:** Romero JE, Coupé P, Manjón JV. HIPS: a new hippocampus subfield
segmentation method. *NeuroImage*. 2017;163:286–295
(doi:10.1016/j.neuroimage.2017.09.049).

1. Multi-atlas / patch-match on T1 (T2 if present).
2. Hippocampus and subfield labels.
3. Neural-net error correction. Not FS ``hippoAmyg``.

Hippodeep
---------

**Flag:** ``--hippodeep`` (not installed)

**Cite:** Thyreau B, Sato K, Fukuda H, Taki Y. Segmentation of the
hippocampus by transferring algorithmic knowledge for very large cohort
processing. *Med Image Anal*. 2018;43:214–228
(doi:10.1016/j.media.2017.11.004).

1. Run the transferred hippocampal CNN on the T1.
2. Left/right hippocampus mask.

ACAPULCO
--------

**Flag:** ``--acapulco`` (not installed)

**Cite:** Han S, Carass A, He Y, Prince JL. Automatic cerebellum
anatomical parcellation using U-Net with locally constrained
optimization. *NeuroImage*. 2020;218:116819
(doi:10.1016/j.neuroimage.2020.116819).

1. Locate the cerebellum.
2. U-Net parcellation with local constraints.
3. Lobule labels (third engine after SUIT / CERES).

pBrain
------

**Flag:** ``--pbrain`` (not installed)

**Cite:** Manjón JV, Bertó A, Romero JE, et al. pBrain: a novel pipeline
for Parkinson related brain structure segmentation. *NeuroImage Clin*.
2020;25:102184 (doi:10.1016/j.nicl.2020.102184).

1. T2 (super-resolve if needed).
2. Patch-based fusion of SN, STN, red nucleus.
3. Neural-net error correction.

Not in this tool
----------------

nnU-Net (no published PC model; ``modules/submit_nnunet_*.sh`` are not
flags), sclimbic / FS thalamic **downloads**, ``recon-all``, FastSurfer,
fMRIPrep.

Rejected (not structure segmentation): ``--ants-ct`` (thickness),
``--cat12`` (morphometry), ``--pincram`` (ICV), ``--lst`` / ``--bianca``
(WMH), ``--sct`` (spinal cord).
