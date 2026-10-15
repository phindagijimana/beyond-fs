#!/usr/bin/env python3
"""Convert Hammers 30 PC atlas pairs to nnU-Net v2 Dataset001_Piriform.

Labels 125/126 (L/R Steinbart PC) become 1/2. Background stays 0.
Do not left-right flip these data; train with nnUNetTrainerNoMirroring.
"""
from __future__ import annotations

import json
import shutil
from pathlib import Path

import nibabel as nib
import numpy as np

ATLAS = Path(
    "/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/Documents/piriform/"
    "Piriform_Segmentation/atlas"
)
OUT = Path(
    "/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/Documents/piriform/"
    "nnunet/nnUNet_raw/Dataset001_Piriform"
)


def remap_labels(src: Path, dst: Path) -> None:
    img = nib.load(str(src))
    data = np.rint(np.asanyarray(img.dataobj)).astype(np.int16)
    out = np.zeros(data.shape, dtype=np.int16)
    out[data == 125] = 1
    out[data == 126] = 2
    extra = np.setdiff1d(np.unique(data), np.array([0, 125, 126]))
    if extra.size:
        raise SystemExit(f"{src.name}: unexpected labels {extra.tolist()}")
    hdr = img.header.copy()
    hdr.set_data_dtype(np.int16)
    nib.Nifti1Image(out, img.affine, hdr).to_filename(str(dst))


def main() -> None:
    images = OUT / "imagesTr"
    labels = OUT / "labelsTr"
    images.mkdir(parents=True, exist_ok=True)
    labels.mkdir(parents=True, exist_ok=True)

    cases = []
    for i in range(1, 31):
        aid = f"a{i:02d}"
        case = f"Hammers_{i:03d}"
        brain = ATLAS / f"{aid}_BrainExtractionBrain.nii.gz"
        lab = ATLAS / f"{aid}_PC_labels.nii.gz"
        if not brain.is_file() or not lab.is_file():
            raise SystemExit(f"missing atlas pair {aid}")
        shutil.copy2(brain, images / f"{case}_0000.nii.gz")
        remap_labels(lab, labels / f"{case}.nii.gz")
        cases.append(case)

    dataset = {
        "channel_names": {"0": "T1"},
        "labels": {"background": 0, "PC_left": 1, "PC_right": 2},
        "numTraining": len(cases),
        "file_ending": ".nii.gz",
        "licence": "Hammers n30 + Steinbart 2023 PC labels; research use",
        "dataset_name": "Dataset001_Piriform",
        "reference": "Steinbart 2023 HBM; Heckemann MAPER / Hammers atlas",
        "description": (
            "Steinbart piriform cortex on Hammers n=30. "
            "Class 1=left PC (125), class 2=right PC (126). "
            "Stage A gold only; no IDEAS, no Leon-Rojas, no MAPER autos."
        ),
    }
    (OUT / "dataset.json").write_text(json.dumps(dataset, indent=2) + "\n")
    print(f"wrote {len(cases)} cases -> {OUT}")


if __name__ == "__main__":
    main()
