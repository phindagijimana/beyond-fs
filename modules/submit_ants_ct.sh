#!/usr/bin/env bash
# ANTs cortical thickness (Tustison 2014). Not FreeSurfer/FastSurfer Desikan thickness.
# Usage: submit_ants_ct.sh sub-152
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"

SUB="${1:?usage: submit_ants_ct.sh sub-XXX}"
T1="${BIDS_DIR}/${SUB}/anat/${SUB}_T1w.nii.gz"
OUTDIR="${OUT_ROOT}/${SUB}/ants-ct"
PREFIX="${OUTDIR}/${SUB}_"
OASIS="${OASIS:-/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/.cache/templateflow/tpl-OASIS30ANTs}"
OASIS_T1="${OASIS}/tpl-OASIS30ANTs_res-01_T1w.nii.gz"
OASIS_EXT="${OASIS}/tpl-OASIS30ANTs_res-01_desc-BrainCerebellumExtraction_mask.nii.gz"
OASIS_REG="${OASIS}/tpl-OASIS30ANTs_res-01_desc-BrainCerebellumRegistration_mask.nii.gz"
PRIOR_DIR="${BEYONDFS_DIR}/templates/oasis30ct"
CORES="${CORES:-8}"

[[ -f "${T1}" ]] || { echo "ERROR: T1w not found: ${T1}" >&2; exit 1; }
[[ -f "${FMRIPREP_SIF}" ]] || { echo "ERROR: no ${FMRIPREP_SIF}" >&2; exit 1; }
for f in "${OASIS_T1}" "${OASIS_EXT}" "${OASIS_REG}" "${PRIOR_DIR}/prior1.nii.gz"; do
  if [[ ! -s "${f}" ]] || [[ "$(stat -c%s "$(readlink -f "${f}")")" -lt 1000 ]]; then
    echo "ERROR: OASIS/CT prior missing or empty: ${f}" >&2
    exit 1
  fi
done

mkdir -p "${OUTDIR}" "${BEYONDFS_DIR}/logs"

sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=antsct-${SUB}
#SBATCH --partition=interactive
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=${CORES}
#SBATCH --mem=32G
#SBATCH --output=${BEYONDFS_DIR}/logs/antsct-${SUB}-%j.out
#SBATCH --error=${BEYONDFS_DIR}/logs/antsct-${SUB}-%j.err

set -euo pipefail
export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=${CORES}
ANTS_BIN=/app/.pixi/envs/fmriprep/bin
echo "start=\$(date -Iseconds) antsCorticalThickness ${SUB}"
apptainer exec \\
  --bind "${BIDS_DIR}" \\
  --bind "${OUT_ROOT}" \\
  --bind "${OASIS}" \\
  --bind "${PRIOR_DIR}" \\
  "${FMRIPREP_SIF}" \\
  env ANTSPATH="\${ANTS_BIN}/" PATH="\${ANTS_BIN}:\${PATH}" \\
  antsCorticalThickness.sh \\
    -d 3 \\
    -a "${T1}" \\
    -e "${OASIS_T1}" \\
    -m "${OASIS_EXT}" \\
    -f "${OASIS_REG}" \\
    -p "${PRIOR_DIR}/prior%d.nii.gz" \\
    -o "${PREFIX}"
echo "end=\$(date -Iseconds)"
ls -la "${OUTDIR}"
EOF
