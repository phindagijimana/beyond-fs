#!/usr/bin/env bash
# Stubs for engines that are documented but not installed on this cluster.
set -euo pipefail
MODULE="${1:-}"
SUB="${2:-}"
cat <<EOF >&2
beyondfs: --${MODULE} is documented but not installed here.

Subject: ${SUB:-<none>}

  ashs        Yushkevich NeuroImage 2010/2015. Set ASHS_ROOT + atlas.
  hippunfold  DeKraker eLife 2022. HIPPUNFOLD_SIF= docker://khanlab/hippunfold
  suit        Diedrichsen NeuroImage 2006/2009. SPM12 + SUIT; set SUIT_DIR.
  maget       Pipitone NeuroImage 2014. Set MAGET_ROOT.
  ceres       Romero NeuroImage 2017. Set CERES_SIF.
  thomas      Su NeuroImage 2019. Set THOMAS_SIF (HIPS-THOMAS). Not for official IDEAS FS.
  gif         Cardoso IEEE TMI 2015. Set GIF_ROOT (NiftySeg GIF).
  malp-em     Ledig Med Image Anal 2015. Set MALPEM_ROOT.
  slant       Huo NeuroImage 2019. Set SLANT_SIF.
  assemblynet Coupé NeuroImage 2020. Set ASSEMBLYNET_SIF.
  hips        Romero NeuroImage 2017. Set HIPS_SIF (volBrain HIPS).
  hippodeep   Thyreau Med Image Anal 2018. Set HIPPODEEP.
  acapulco    Han NeuroImage 2020. Set ACAPULCO_SIF.
  pbrain      Manjón NeuroImage Clin 2020. Set PBRAIN_SIF.

See: $(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/MODULES.md
EOF
exit 2
