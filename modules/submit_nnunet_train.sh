#!/usr/bin/env bash
# 5-fold nnU-Net (1000 epochs, no L/R mirror). Interactive 12h; resubmit to continue.
# Usage: submit_nnunet_train.sh
# Optional env: FOLDS=0-4  PARTITION=interactive  TIME=12:00:00
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"
CONFIG="${CONFIG:-3d_fullres}"
TRAINER="${TRAINER:-nnUNetTrainerNoMirroring}"
# shellcheck source=nnunet_exec.sh
source "${SCRIPT_DIR}/nnunet_exec.sh"
nnunet_env_setup

CORES="${CORES:-8}"
MEM="${MEM:-64G}"
TIME="${TIME:-12:00:00}"
PARTITION="${PARTITION:-interactive}"
GRES="${GRES:-gpu:l40s.24g:1}"
FOLDS="${FOLDS:-0-4}"

if [[ ! -f "${nnUNet_raw}/${NNUNET_DATASET}/dataset.json" ]]; then
  echo "ERROR: missing ${nnUNet_raw}/${NNUNET_DATASET}/dataset.json (run prepare_nnunet.py)" >&2
  exit 1
fi

python3 "${SCRIPT_DIR}/make_nnunet_splits.py"

sbatch --export=ALL,CONFIG="${CONFIG}",TRAINER="${TRAINER}",BEYONDFS_MODULES="${SCRIPT_DIR}" \
  --job-name="nnunet-pc" \
  --array="${FOLDS}" \
  --partition="${PARTITION}" \
  --gres="${GRES}" \
  --time="${TIME}" \
  --cpus-per-task="${CORES}" \
  --mem="${MEM}" \
  --output="${NNUNET_ROOT}/logs/nnunet-pc-f%a-%j.out" \
  --error="${NNUNET_ROOT}/logs/nnunet-pc-f%a-%j.err" \
  "${SCRIPT_DIR}/train_nnunet_job.sh"
