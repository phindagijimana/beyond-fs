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
| `--piriform ants-jlf` | ANTs strip + JLF | Wang 2013 + Avants `antsBrainExtraction`. | wired |
| `--claustrum` | `mri_claustrum_seg` | Mauri et al., *Hum Brain Mapp* 2025;46:e70303. | wired |
| `--first` | FSL FIRST | Patenaude et al., *NeuroImage* 2011;56:907–922. | wired |
| `--synthseg` | SynthSeg | Billot et al., *Med Image Anal* 2023;86:102789. | wired |
| `--ants-ct` | ANTs cortical thickness | Tustison et al., *NeuroImage* 2014;99:37–45 (ANTs vs FS thickness). Thickness engine, not Desikan. | wired |
| `--ashs` | ASHS | Yushkevich et al., *NeuroImage* 2010;53:1208–1224 and 2015;105:425–437. | `ASHS_ROOT` |
| `--hippunfold` | HippUnfold | DeKraker et al., *eLife* 2022;11:e77945. | `HIPPUNFOLD_SIF` |
| `--cat12` | CAT12 | Gaser et al., *GigaScience* 2024;13:giae049. | SPM12 + CAT12 |
| `--suit` | SUIT | Diedrichsen, *NeuroImage* 2006;33:127–138; atlas 2009;46:39–46. | SPM12 + SUIT |
| `--maget` | MAGeT | Pipitone et al., *NeuroImage* 2014;101:494–512. Multi-atlas subcortex; sibling to FIRST, not `aseg`. | `MAGET_ROOT` |
| `--ceres` | CERES (volBrain) | Romero et al., *NeuroImage* 2017;152:648–658. Cerebellum parcellation; SUIT is atlas/template, CERES is a second engine. | `CERES_SIF` |
| `--pincram` | Pincram | Heckemann et al., *NeuroImage* 2015;107:107–122. Brain mask / ICV; Steinbart used it to normalise PC volume. | `PINCRAM` |
| `--thomas` | THOMAS | Su et al., *NeuroImage* 2019;194:272–282. Thalamic nuclei **without** FS `ThalamicNuclei`. Only for cohorts that are **not** official IDEAS FS. | `THOMAS_SIF` |

**Defaults for this project.** Piriform: MAPER. Claustrum: Mauri 2025. JLF is a sibling, not the PC paper method.

## Would still fit (now in the CLI)

| Candidate | Paper | Why it matches |
|---|---|---|
| ANTs cortical thickness | Tustison et al., *NeuroImage* 2014;99:37–45 | Thickness engine, not Desikan / not FastSurfer |
| MAGeT | Pipitone et al., *NeuroImage* 2014;101:494–512 | Multi-atlas subcortex; sibling to FIRST, not `aseg` |
| CERES (volBrain) | Romero et al., *NeuroImage* 2017;152:648–658 | Cerebellum parcellation; SUIT is atlas/template, CERES is a second published engine |
| Pincram | Heckemann et al., *NeuroImage* 2015;107:107–122 | Brain mask / ICV; Steinbart used it to normalise PC volume |
| THOMAS | Su et al., *NeuroImage* 2019;194:272–282 | Thalamic nuclei without running FS `ThalamicNuclei` — only for cohorts that are not official IDEAS FS |

## Not in this tool

nnU-Net (no published PC model yet), sclimbic / FS `ThalamicNuclei` as downloads, `recon-all`, FastSurfer, fMRIPrep.
