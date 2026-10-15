#!/usr/bin/env bash
# SynthSeg (Billot / Iglesias) via FreeSurfer 7.4 SIF.
# Usage: submit_synthseg.sh sub-152
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"

SUB="${1:?usage: submit_synthseg.sh sub-XXX}"
T1="${BIDS_DIR}/${SUB}/anat/${SUB}_T1w.nii.gz"
OUTDIR="${OUT_ROOT}/${SUB}/synthseg"
OUT="${OUTDIR}/${SUB}_synthseg.nii.gz"
LICENSE="$(realpath "${FS_LICENSE}")"
HOME_ALIAS=/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji
HOME_CANON="$(realpath "${HOME_ALIAS}")"

if [[ ! -f "${T1}" ]]; then
  echo "ERROR: T1w not found: ${T1}" >&2
  exit 1
fi
if [[ ! -s "${LICENSE}" ]]; then
  echo "ERROR: FreeSurfer license missing: ${LICENSE}" >&2
  exit 1
fi

mkdir -p "${OUTDIR}" "${BEYONDFS_DIR}/logs"

sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=synthseg-${SUB}
#SBATCH --partition=interactive
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=24G
#SBATCH --output=${BEYONDFS_DIR}/logs/synthseg-${SUB}-%j.out
#SBATCH --error=${BEYONDFS_DIR}/logs/synthseg-${SUB}-%j.err

set -euo pipefail
THREADS="\${SLURM_CPUS_PER_TASK:-8}"
echo "start=\$(date -Iseconds) ${SUB}"
apptainer exec --cleanenv \\
  --bind "${HOME_CANON}:${HOME_CANON}" \\
  --bind "${HOME_ALIAS}:${HOME_CANON}" \\
  --bind "${BIDS_DIR}:${BIDS_DIR}:ro" \\
  --bind "${OUT_ROOT}:${OUT_ROOT}" \\
  --bind "${LICENSE}:/usr/local/freesurfer/7.4.1/license.txt:ro" \\
  --env FREESURFER_HOME=/usr/local/freesurfer/7.4.1 \\
  --env FS_LICENSE=/usr/local/freesurfer/7.4.1/license.txt \\
  --env OMP_NUM_THREADS="\${THREADS}" \\
  "${FS_SIF}" \\
  mri_synthseg --i "${T1}" --o "${OUT}" --parc --threads "\${THREADS}" --cpu
echo "end=\$(date -Iseconds)"
ls -la "${OUTDIR}"
EOF
