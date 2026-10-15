# beyondfs modules

Keep the identity as **published structure segmentation that FreeSurfer / FastSurfer do not already give you**. Add a method only if you would cite that paper in a methods section, not because it is “another MRI tool.”

```bash
beyondfs run --participant_label sub-152 --piriform maper --claustrum --submit
beyondfs list
beyondfs doctor
```

## Wired / installable flags

| Flag | Method | Paper | CLI |
|---|---|---|---|
| `--piriform maper` | MAPER (default PC) | Heckemann et al., *NeuroImage* 2010;51:221–227. PC protocol: Steinbart et al., *Hum Brain Mapp* 2023;44:3196–3209 (labels 125/126). | wired |
| `--piriform jlf` | ANTs joint label fusion | Wang et al., *IEEE TPAMI* 2013;35:611–623. Same 30 Hammers PC atlases; not the Steinbart methods claim. | wired |
| `--piriform ants-jlf` | ANTs strip + JLF | Wang 2013; Avants et al., *NeuroImage* 2011;54:2033–2044. | wired |
| `--claustrum` | `mri_claustrum_seg` | Mauri et al., *Hum Brain Mapp* 2025;46:e70303. | wired |
| `--first` | FSL FIRST | Patenaude et al., *NeuroImage* 2011;56:907–922. | wired |
| `--synthseg` | SynthSeg | Billot et al., *Med Image Anal* 2023;86:102789. | wired |
| `--ashs` | ASHS | Yushkevich et al., *NeuroImage* 2010;53:1208–1224 and 2015;105:425–437. | `ASHS_ROOT` |
| `--hippunfold` | HippUnfold | DeKraker et al., *eLife* 2022;11:e77945. | `HIPPUNFOLD_SIF` |
| `--suit` | SUIT | Diedrichsen, *NeuroImage* 2006;33:127–138; atlas 2009;46:39–46. | SPM12 + SUIT |
| `--maget` | MAGeT | Pipitone et al., *NeuroImage* 2014;101:494–512. Multi-atlas subcortex; sibling to FIRST, not `aseg`. | `MAGET_ROOT` |
| `--ceres` | CERES (volBrain) | Romero et al., *NeuroImage* 2017;152:648–658. Cerebellum parcellation; SUIT is atlas/template, CERES is a second engine. | `CERES_SIF` |
| `--thomas` | THOMAS | Su et al., *NeuroImage* 2019;194:272–282. Thalamic nuclei **without** FS `ThalamicNuclei`. Only for cohorts that are **not** official IDEAS FS. | `THOMAS_SIF` |
| `--gif` | GIF | Cardoso et al., *IEEE TMI* 2015;34:1976–1988. Multi-atlas anatomical labels (NiftySeg). Not Leon-Rojas PC. | `GIF_ROOT` |
| `--malp-em` | MALP-EM | Ledig et al., *Med Image Anal* 2015;21:40–58. 138 whole-brain labels (MAPER + fusion + EM). | `MALPEM_ROOT` |
| `--slant` | SLANT | Huo et al., *NeuroImage* 2019;194:105–119. 132 structure labels (tiled 3D CNNs). | `SLANT_SIF` |
| `--assemblynet` | AssemblyNet | Coupé et al., *NeuroImage* 2020;219:117026. 133 structure labels (U-Net ensemble). | `ASSEMBLYNET_SIF` |
| `--hips` | HIPS | Romero, Coupé, Manjón, *NeuroImage* 2017;163:286–295. Hippocampus / subfields (volBrain). | `HIPS_SIF` |
| `--hippodeep` | Hippodeep | Thyreau et al., *Med Image Anal* 2018;43:214–228. Hippocampus CNN. | `HIPPODEEP` |
| `--acapulco` | ACAPULCO | Han et al., *NeuroImage* 2020;218:116819. Cerebellar lobule labels. | `ACAPULCO_SIF` |
| `--pbrain` | pBrain | Manjón et al., *NeuroImage Clin* 2020;25:102184. SN, STN, red nucleus. | `PBRAIN_SIF` |

**Defaults for this project.** Piriform: MAPER. Claustrum: Mauri 2025. JLF is a sibling, not the PC paper method.

Step-by-step for each engine (docs `workflows`; cite those papers):

**MAPER** (Heckemann 2010; Steinbart 2023). Tissue maps → MIRTK FFD atlas→target → warp PC 125/126 → vote fusion.

**JLF** (Wang 2013). Optional ANTs strip → SyN each atlas → warp labels → joint fusion (correlated-error weights).

**Claustrum** (Mauri 2025). Raw T1 → hemisphere crop → SynthSeg-style U-Net at 0.35 mm → topology correction → L/R claustrum.

**FIRST** (Patenaude 2011). Affine to MNI → Bayesian shape+appearance per structure → boundary correction → 15 subcortical labels.

**SynthSeg** (Billot 2023). Native T1 → CNN trained on synthetic contrast/resolution → whole-brain (optional parc) labels.

**ASHS** (Yushkevich 2010/2015). MTL ROI → multi-atlas register → JLF subfields.

**HippUnfold** (DeKraker 2022). Segment hippocampus → unfold grey matter → subfields + morphometry on the sheet.

**SUIT** (Diedrichsen 2006/2009). Isolate cerebellum → SUIT template → inverse-warp lobule atlas.

**MAGeT** (Pipitone 2014). Few manuals through many templates → bootstrap → vote subcortex/hippocampus.

**CERES** (Romero 2017). Cerebellar crop → patch-based fusion → lobules.

**THOMAS** (Su 2019). WMn T1 → thalamic-nuclei atlases → 12 nuclei/side. Not official IDEAS FS.

**GIF** (Cardoso 2015). Geodesic neighbourhood graph of atlases → propagate labels → fusion. Custom label set; not Leon-Rojas PC.

**MALP-EM** (Ledig 2015). Pincram extract → MAPER propagate → label fusion → EM intensity refine → 138 labels.

**SLANT** (Huo 2019). Register to MNI → tiled 3D U-Nets → fuse tiles → 132 labels.

**AssemblyNet** (Coupé 2020). Two assemblies of U-Nets on overlapping patches → majority vote → 133 labels.

**HIPS** (Romero 2017). Multi-atlas / patch-match on T1 (T2 if present) → hippocampus/subfields → error correction.

**Hippodeep** (Thyreau 2018). Transfer a hippocampal CNN to the T1 → hippocampus mask.

**ACAPULCO** (Han 2020). Locate cerebellum → U-Net parcellation with local constraints → lobules.

**pBrain** (Manjón 2020). T2 (or super-resolved T2) → patch fusion → SN / STN / red nucleus → NN error correction.

Tests: `./tests/test_cli.sh` and `--dry-run`. See docs (`testing`).

## Not in this tool

nnU-Net (no published PC model; `modules/submit_nnunet_*.sh` are training helpers, not flags), sclimbic / FS `ThalamicNuclei` as downloads, `recon-all`, FastSurfer, fMRIPrep.

Not structure segmentation (rejected flags): `--ants-ct` (thickness), `--cat12` (morphometry), `--pincram` (ICV), LST / BIANCA (WMH), SCT (spinal).
