#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="${BEYONDFS_MODULES:-/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/Documents/piriform/beyondfs/modules}"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"
CONFIG="${CONFIG:-3d_fullres}"
TRAINER="${TRAINER:-nnUNetTrainerNoMirroring}"
# shellcheck source=nnunet_exec.sh
source "${SCRIPT_DIR}/nnunet_exec.sh"
nnunet_env_setup

echo "start=$(date -Iseconds) find_best_configuration 3d_fullres folds 0-4"
nnunet_exec nnUNetv2_find_best_configuration "${NNUNET_ID}" \
  -c "${CONFIG}" \
  -tr "${TRAINER}" \
  -f 0 1 2 3 4
echo "end=$(date -Iseconds)"
