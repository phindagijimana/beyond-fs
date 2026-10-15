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
  cat12       Gaser GigaScience 2024. SPM12 + CAT12; set SPM_DIR.
  suit        Diedrichsen NeuroImage 2006/2009. SPM12 + SUIT; set SUIT_DIR.
  maget       Pipitone NeuroImage 2014. Set MAGET_ROOT.
  ceres       Romero NeuroImage 2017. Set CERES_SIF.
  pincram     Heckemann NeuroImage 2015. Set PINCRAM to the pincram executable.
  thomas      Su NeuroImage 2019. Set THOMAS_SIF (HIPS-THOMAS). Not for official IDEAS FS.

See: $(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/MODULES.md
EOF
exit 2
