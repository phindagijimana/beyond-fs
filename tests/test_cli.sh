#!/usr/bin/env bash
# CLI + dispatcher smoke tests. Does not submit Slurm jobs.
set -u
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BF="${HERE}/beyondfs"
PASS=0
FAIL=0
TMP="$(mktemp -d)"
trap 'rm -rf "${TMP}"' EXIT

ok() { printf 'PASS  %s\n' "$*"; PASS=$((PASS + 1)); }
bad() { printf 'FAIL  %s\n' "$*" >&2; FAIL=$((FAIL + 1)); }

expect_exit() {
  local want="$1" desc="$2"
  shift 2
  local got=0
  "$@" >"${TMP}/out" 2>"${TMP}/err" || got=$?
  if [[ "${got}" -eq "${want}" ]]; then
    ok "${desc}"
  else
    bad "${desc} (exit ${got}, want ${want})"
    sed -n '1,20p' "${TMP}/err" >&2 || true
  fi
}

expect_grep() {
  local file="$1" pattern="$2" desc="$3"
  if grep -Eq "${pattern}" "${file}"; then
    ok "${desc}"
  else
    bad "${desc} (no match /${pattern}/)"
  fi
}

expect_exit 0 "help" "${BF}" --help
expect_grep "${TMP}/out" "beyondfs 0\\." "help prints version"

expect_exit 0 "version" "${BF}" --version
expect_grep "${TMP}/out" "beyondfs 0\\." "version string"

expect_exit 0 "list" "${BF}" list
expect_grep "${TMP}/out" "MAPER" "list shows MAPER"
expect_grep "${TMP}/out" "Mauri" "list shows Mauri"
expect_grep "${TMP}/out" "AssemblyNet" "list shows AssemblyNet"

expect_exit 0 "doctor" "${BF}" doctor
expect_grep "${TMP}/out" "doctor: OK" "doctor OK"

expect_exit 2 "missing module" "${BF}" run --participant_label sub-152
expect_exit 2 "missing subject" "${BF}" run --piriform maper
expect_exit 2 "unknown flag" "${BF}" run --nope
expect_exit 2 "sclimbic rejected" "${BF}" run --participant_label sub-152 --sclimbic
expect_exit 2 "thalamic rejected" "${BF}" run --participant_label sub-152 --thalamic
expect_exit 2 "lst rejected" "${BF}" run --participant_label sub-152 --lst
expect_exit 2 "bianca rejected" "${BF}" run --participant_label sub-152 --bianca
expect_exit 2 "sct rejected" "${BF}" run --participant_label sub-152 --sct
expect_exit 2 "ants-ct rejected" "${BF}" run --participant_label sub-152 --ants-ct
expect_exit 2 "cat12 rejected" "${BF}" run --participant_label sub-152 --cat12
expect_exit 2 "pincram rejected" "${BF}" run --participant_label sub-152 --pincram
expect_exit 2 "train-nnunet rejected" "${BF}" run --participant_label sub-152 --train-nnunet
expect_exit 2 "piriform nnunet rejected" "${BF}" run --participant_label sub-152 --piriform nnunet
expect_exit 2 "bad piriform" "${BF}" run --participant_label sub-152 --piriform gif

printf 'sub-152\n# comment\n' >"${TMP}/subs.txt"
expect_exit 0 "participants_file dry-run" \
  "${BF}" run --participants_file "${TMP}/subs.txt" --first --dry-run
expect_grep "${TMP}/out" "submit_first.sh sub-152" "dry-run first script"

for flag in maper jlf ants-jlf; do
  expect_exit 0 "dry-run --piriform ${flag}" \
    "${BF}" run --participant_label sub-152 --piriform "${flag}" --dry-run
done
expect_grep "${TMP}/out" "submit_ants_malf_ideas.sh sub-152" "dry-run ants-jlf script"

expect_exit 0 "dry-run --claustrum" \
  "${BF}" run --participant_label sub-152 --claustrum --dry-run
expect_grep "${TMP}/out" "submit_ideas_claustrum.sh sub-152" "dry-run claustrum script"

expect_exit 0 "dry-run --synthseg" \
  "${BF}" run --participant_label sub-152 --synthseg --dry-run
expect_grep "${TMP}/out" "submit_synthseg.sh sub-152" "dry-run synthseg script"

expect_exit 0 "dry-run combined wired" \
  "${BF}" run --participant_label sub-152 \
    --piriform maper --claustrum --first --synthseg --dry-run

for stub in ashs hippunfold suit maget ceres thomas \
            gif malp-em slant assemblynet hips hippodeep acapulco pbrain; do
  expect_exit 2 "stub --${stub}" \
    "${BF}" run --participant_label sub-152 --"${stub}"
  expect_grep "${TMP}/err" "not installed" "stub --${stub} message"
done

echo
echo "passed=${PASS} failed=${FAIL}"
[[ "${FAIL}" -eq 0 ]]
