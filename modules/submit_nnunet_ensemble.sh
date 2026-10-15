#!/usr/bin/env bash
# After all 5 folds have checkpoint_final.pth: CV metrics, ensemble, connected-component postprocess.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"
CONFIG="${CONFIG:-3d_fullres}"
TRAINER="${TRAINER:-nnUNetTrainerNoMirroring}"
# shellcheck source=nnunet_exec.sh
source "${SCRIPT_DIR}/nnunet_exec.sh"
nnunet_env_setup

for f in 0 1 2 3 4; do
  if ! fold_done "${f}"; then
    echo "ERROR: fold ${f} has no checkpoint_final.pth at $(fold_dir "${f}")" >&2
    echo "Resubmit: ${SCRIPT_DIR}/submit_nnunet_train.sh" >&2
    exit 1
  fi
done

mkdir -p "${NNUNET_ROOT}/logs"
sbatch --export=ALL,CONFIG="${CONFIG}",TRAINER="${TRAINER}",BEYONDFS_MODULES="${SCRIPT_DIR}" \
  --job-name="nnunet-ens" \
  --partition="${PARTITION:-interactive}" \
  --gres="${GRES:-gpu:l40s.24g:1}" \
  --time="${TIME:-04:00:00}" \
  --cpus-per-task=8 \
  --mem=32G \
  --output="${NNUNET_ROOT}/logs/nnunet-ens-%j.out" \
  --error="${NNUNET_ROOT}/logs/nnunet-ens-%j.err" \
  "${SCRIPT_DIR}/ensemble_nnunet_job.sh"
