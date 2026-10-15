# shellcheck shell=bash
# Shared paths for beyondfs modules. Source from other scripts.

BEYONDFS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT="$(cd "${BEYONDFS_DIR}/.." && pwd)"

PIRIFORM_DIR="${BEYONDFS_PIRIFORM:-${ROOT}/Piriform_Segmentation}"
PIRIFORM_SCRIPTS="${PIRIFORM_DIR}/scripts"
CLAU_DIR="${BEYONDFS_CLAU:-$(cd "${ROOT}/../clau_seg" 2>/dev/null && pwd || true)}"
BIDS_DIR="${BEYONDFS_BIDS:-/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/Documents/IDEAS/bids_IDEAS}"
OUT_ROOT="${BEYONDFS_OUT:-${BEYONDFS_DIR}/outputs}"

FMRIPREP_SIF="${FMRIPREP_SIF:-/opt/ood_apps/images/fmriprep/fmriprep_25.2.3.sif}"
FS_SIF="${FS_SIF:-/opt/ood_apps/images/freesurfer/freesurfer_7.4.1.sif}"
FSL_SIF="${FSL_SIF:-/opt/ood_apps/images/fsl/fsl_latest.sif}"
MATLAB_SIF="${MATLAB_SIF:-/opt/ood_apps/images/matlab/matlab_R2024a.sif}"
VLLM_SIF="${VLLM_SIF:-/opt/ood_apps/images/vllm/ngc-vllm_26.02.sif}"
FS_LICENSE="${FS_LICENSE:-/mnt/nfs/home/urmc-sh.rochester.edu/pndagiji/.freesurfer/license.txt}"

NNUNET_ROOT="${NNUNET_ROOT:-${ROOT}/nnunet}"
export nnUNet_raw="${nnUNet_raw:-${NNUNET_ROOT}/nnUNet_raw}"
export nnUNet_preprocessed="${nnUNet_preprocessed:-${NNUNET_ROOT}/nnUNet_preprocessed}"
export nnUNet_results="${nnUNet_results:-${NNUNET_ROOT}/nnUNet_results}"
NNUNET_DATASET="${NNUNET_DATASET:-Dataset001_Piriform}"
NNUNET_ID="${NNUNET_ID:-1}"
