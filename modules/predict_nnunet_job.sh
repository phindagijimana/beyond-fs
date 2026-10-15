#!/usr/bin/env bash
# Match training input: OASIS30 ANTs brain extraction, then 5-fold ensemble.
set -euo pipefail
SCRIPT_DIR="${BEYONDFS_MODULES:-/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/Documents/piriform/beyondfs/modules}"
# shellcheck source=paths.sh
source "${SCRIPT_DIR}/paths.sh"
CONFIG="${CONFIG:-3d_fullres}"
TRAINER="${TRAINER:-nnUNetTrainerNoMirroring}"
# shellcheck source=nnunet_exec.sh
source "${SCRIPT_DIR}/nnunet_exec.sh"
nnunet_env_setup

SUB="${PRED_SUB:?PRED_SUB unset}"
T1="${BIDS_DIR}/${SUB}/anat/${SUB}_T1w.nii.gz"
OASIS="${OASIS:-/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/.cache/templateflow/tpl-OASIS30ANTs}"
OASIS_T1="${OASIS}/tpl-OASIS30ANTs_res-01_T1w.nii.gz"
OASIS_EXT="${OASIS}/tpl-OASIS30ANTs_res-01_desc-BrainCerebellumExtraction_mask.nii.gz"
OASIS_REG="${OASIS}/tpl-OASIS30ANTs_res-01_desc-BrainCerebellumRegistration_mask.nii.gz"
STRIP_DIR="${PIRIFORM_DIR}/subjects/${SUB}-ants"
PREFIX="${STRIP_DIR}/${SUB}-ants_"
BRAIN="${PREFIX}BrainExtractionBrain.nii.gz"
IN_DIR="${NNUNET_ROOT}/inference/${SUB}/imagesTs"
OUT_DIR="${NNUNET_ROOT}/inference/${SUB}/pred"
ANTS_BIN=/app/.pixi/envs/fmriprep/bin

mkdir -p "${STRIP_DIR}" "${IN_DIR}" "${OUT_DIR}"
echo "start=$(date -Iseconds) predict ${SUB}"

if [[ ! -f "${BRAIN}" ]]; then
  echo "=== ANTs brain extraction (same template as Hammers atlases) ==="
  export ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS="${OMP_NUM_THREADS}"
  apptainer exec \
    --bind "${PIRIFORM_DIR}" \
    --bind "${BIDS_DIR}" \
    --bind "${OASIS}" \
    "${FMRIPREP_SIF}" \
    env ANTSPATH="${ANTS_BIN}/" PATH="${ANTS_BIN}:${PATH}" \
    antsBrainExtraction.sh \
      -d 3 \
      -a "${T1}" \
      -e "${OASIS_T1}" \
      -m "${OASIS_EXT}" \
      -f "${OASIS_REG}" \
      -o "${PREFIX}"
fi
[[ -f "${BRAIN}" ]] || { echo "ERROR: missing ${BRAIN}" >&2; exit 1; }
cp -f "${BRAIN}" "${IN_DIR}/${SUB}_0000.nii.gz"

echo "=== nnU-Net 5-fold ensemble ==="
nnunet_exec nnUNetv2_predict \
  -i "${IN_DIR}" \
  -o "${OUT_DIR}" \
  -d "${NNUNET_ID}" \
  -c "${CONFIG}" \
  -f 0 1 2 3 4 \
  -tr "${TRAINER}" \
  --save_probabilities

echo "end=$(date -Iseconds)"
ls -la "${OUT_DIR}"
