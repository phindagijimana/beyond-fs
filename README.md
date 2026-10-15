# beyondfs

CLI for **published structure segmentation that FreeSurfer / FastSurfer do not already give you**. Add a method only if you would cite that paper in a methods section. Catalog: [MODULES.md](MODULES.md).

```bash
beyondfs/beyondfs run --participant_label sub-152 --piriform maper --claustrum --submit
beyondfs/beyondfs list
beyondfs/beyondfs doctor
```

| Flag | Paper method | Cluster |
|---|---|---|
| `--piriform maper` | Heckemann 2010 MAPER; Steinbart 2023 PC | wired (default) |
| `--piriform jlf` / `ants-jlf` | Wang 2013 JLF | wired |
| `--claustrum` | Mauri 2025 | wired |
| `--first` | Patenaude 2011 FIRST | wired |
| `--synthseg` | Billot 2023 SynthSeg | wired |
| `--ants-ct` | Tustison 2014 ANTs thickness | wired |
| `--ashs` | Yushkevich 2010/2015 ASHS | not installed |
| `--hippunfold` | DeKraker 2022 HippUnfold | not installed |
| `--cat12` | Gaser 2024 CAT12 | not installed |
| `--suit` | Diedrichsen 2006/2009 SUIT | not installed |
| `--maget` | Pipitone 2014 MAGeT | not installed |
| `--ceres` | Romero 2017 CERES | not installed |
| `--pincram` | Heckemann 2015 Pincram | not installed |
| `--thomas` | Su 2019 THOMAS (non-IDEAS FS only) | not installed |
