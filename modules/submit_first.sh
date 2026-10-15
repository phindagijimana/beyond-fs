#!/usr/bin/env bash
# FSL FIRST (Patenaude 2011) on one BIDS T1w.
# Usage: submit_first.sh sub-152
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"

SUB="${1:?usage: submit_first.sh sub-XXX}"
T1="${BIDS_DIR}/${SUB}/anat/${SUB}_T1w.nii.gz"
OUTDIR="${OUT_ROOT}/${SUB}/first"
PREFIX="${OUTDIR}/${SUB}_first"

if [[ ! -f "${T1}" ]]; then
  echo "ERROR: T1w not found: ${T1}" >&2
  exit 1
fi
if [[ ! -f "${FSL_SIF}" ]]; then
  echo "ERROR: FSL SIF missing: ${FSL_SIF}" >&2
  exit 1
fi

mkdir -p "${OUTDIR}" "${BEYONDFS_DIR}/logs"
T1_LOCAL="${OUTDIR}/${SUB}_T1w.nii.gz"

sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=first-${SUB}
#SBATCH --partition=interactive
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --output=${BEYONDFS_DIR}/logs/first-${SUB}-%j.out
#SBATCH --error=${BEYONDFS_DIR}/logs/first-${SUB}-%j.err

set -euo pipefail
echo "start=\$(date -Iseconds) ${SUB}"
cp -f "${T1}" "${T1_LOCAL}"
apptainer exec --bind "${OUT_ROOT}" "${FSL_SIF}" \\
  bash -lc 'source /usr/local/fsl/etc/fslconf/fsl.sh; run_first_all -i "${T1_LOCAL}" -o "${PREFIX}"'
echo "end=\$(date -Iseconds)"
ls -la "${OUTDIR}"
EOF
