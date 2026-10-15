#!/usr/bin/env bash
# ANTs skull-strip (same OASIS template as the Hammers atlases) then 5-fold ensemble predict.
# Usage: submit_nnunet_predict.sh sub-152
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"
CONFIG="${CONFIG:-3d_fullres}"
TRAINER="${TRAINER:-nnUNetTrainerNoMirroring}"
# shellcheck source=nnunet_exec.sh
source "${SCRIPT_DIR}/nnunet_exec.sh"
nnunet_env_setup

SUB="${1:?usage: submit_nnunet_predict.sh sub-XXX}"
for f in 0 1 2 3 4; do
  if ! fold_done "${f}"; then
    echo "ERROR: fold ${f} not trained. Do not predict until 5-fold + ensemble finish." >&2
    exit 1
  fi
done

T1="${BIDS_DIR}/${SUB}/anat/${SUB}_T1w.nii.gz"
[[ -f "${T1}" ]] || { echo "ERROR: no T1 ${T1}" >&2; exit 1; }

sbatch --export=ALL,CONFIG="${CONFIG}",TRAINER="${TRAINER}",BEYONDFS_MODULES="${SCRIPT_DIR}",PRED_SUB="${SUB}" \
  --job-name="nnunet-pred-${SUB}" \
  --partition="${PARTITION:-interactive}" \
  --gres="${GRES:-gpu:l40s.24g:1}" \
  --time="${TIME:-06:00:00}" \
  --cpus-per-task=8 \
  --mem=32G \
  --output="${NNUNET_ROOT}/logs/nnunet-pred-${SUB}-%j.out" \
  --error="${NNUNET_ROOT}/logs/nnunet-pred-${SUB}-%j.err" \
  "${SCRIPT_DIR}/predict_nnunet_job.sh"
