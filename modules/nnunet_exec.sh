# shellcheck shell=bash
# Common apptainer invocation for nnU-Net v2 (source from job scripts).

nnunet_exec() {
  apptainer exec --nv \
    --bind "${ROOT}" \
    --bind "${NNUNET_ROOT}" \
    --env PYTHONUSERBASE="${PYTHONUSERBASE}" \
    --env PATH="${PYTHONUSERBASE}/bin:/usr/local/bin:/usr/bin:/bin" \
    --env PYTHONPATH="${PYTHONPATH}" \
    --env nnUNet_raw="${nnUNet_raw}" \
    --env nnUNet_preprocessed="${nnUNet_preprocessed}" \
    --env nnUNet_results="${nnUNet_results}" \
    --env nnUNet_compile=false \
    --env HOME="${NNUNET_ROOT}" \
    --env OMP_NUM_THREADS="${OMP_NUM_THREADS}" \
    --env nnUNet_n_proc_DA="${nnUNet_n_proc_DA}" \
    "${VLLM_SIF}" \
    "$@"
}

nnunet_env_setup() {
  export nnUNet_raw nnUNet_preprocessed nnUNet_results
  export PYTHONUSERBASE="${NNUNET_ROOT}/python-user"
  export PATH="${PYTHONUSERBASE}/bin:${PATH}"
  export PYTHONPATH="${PYTHONUSERBASE}/lib/python3.12/site-packages${PYTHONPATH:+:${PYTHONPATH}}"
  export nnUNet_compile=false
  export OMP_NUM_THREADS="${SLURM_CPUS_PER_TASK:-8}"
  export nnUNet_n_proc_DA="${NNUNET_N_PROC_DA:-4}"
  mkdir -p "${PYTHONUSERBASE}" "${nnUNet_raw}" "${nnUNet_preprocessed}" "${nnUNet_results}" "${NNUNET_ROOT}/logs"
}

fold_dir() {
  local fold="${1}"
  echo "${nnUNet_results}/${NNUNET_DATASET}/${TRAINER}__nnUNetPlans__${CONFIG}/fold_${fold}"
}

fold_done() {
  [[ -f "$(fold_dir "$1")/checkpoint_final.pth" ]]
}
