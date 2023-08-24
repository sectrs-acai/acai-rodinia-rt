#!/bin/zsh

set -euo pipefail
SCRIPTS_DIR=/home/b/2.5bay/mthesis-unsync/projects/trusted-periph/scripts/
BENCH_OUT_DIR=/mnt/host/mnt/host/benchmark-rodinia-runtime
DEVMEM_UNDELEGATE_SCRIPT=../../scripts/fvp/reset_devmem.sh

ITERS=1


# weird stall in encryption mode:   "b+tree"
b_fvp=(
"lavaMD"
 "lud/cuda"
 "particlefilter"
 "streamcluster"
 "heartwall"
 "hotspot3D"
 "samples/BlackScholes"
)

# "myocyte" \

function print_init {
  local DIR=$1
  cp -f $SCRIPT_DIR/setup.sh $DIR
}

function do_run {
  local BENCH=$1
  local DO_TASKSET=$2
  local DIR=$3

  NAME=$(basename $BENCH)
  LOG=$DIR/$NAME

  echo "--------------" | tee -a $LOG
  echo "executing $BENCH" | tee -a $LOG

  cd $SCRIPT_DIR/$BENCH
  cat ./run | tee -a $LOG
  if [[ $DO_TASKSET -eq 1 ]]; then
    set -x
    # 2>&1 | tee -a $LOG
    nice -20 taskset 0x4 ./run 2>&1
    set +x
  else
    set -x
    # 2>&1 | tee -a $LOG
    nice -20 ./run
    set +x
  fi
  echo "--------------" | tee -a $LOG
}

function do_run_ns {
  SCRIPT_DIR=${0:a:h}
  TS=$(date +"%Y-%m-%d_%H-%M-%S")
  DIR=$BENCH_OUT_DIR/$TS
  mkdir -p $DIR
  print_init $DIR

  for b in ${b_fvp[@]}; do
    for i in {1..$ITERS}; do
      # NS requires pinning
      local taskset=1
      do_run $b $taskset $DIR
    done
  done
}

function do_run_realm {
  SCRIPT_DIR=${0:a:h}
  TS=$(date +"%Y-%m-%d_%H-%M-%S")
  DIR=$BENCH_OUT_DIR/$TS
  mkdir -p $DIR
  print_init $DIR

  for b in ${b_fvp[@]}; do
    for i in {1..$ITERS}; do
      local taskset=0
      do_run $b $taskset $DIR
    done
  done
}

function do_run_devmem {
  SCRIPT_DIR=${0:a:h}
  TS=$(date +"%Y-%m-%d_%H-%M-%S")
  DIR=$BENCH_OUT_DIR/$TS
  mkdir -p $DIR
  print_init $DIR
  set +x
  cd $SCRIPT_DIR

  for b in ${b_fvp[@]}; do
    for i in {1..$ITERS}; do
      local taskset=0
      do_run $b $taskset $DIR
      cd $SCRIPT_DIR
      sh $DEVMEM_UNDELEGATE_SCRIPT
    done
  done
}

function do_nvcc {
  SCRIPT_DIR=${0:a:h}
  set +x
  for b in ${b_fvp[@]}; do
    cd $SCRIPT_DIR/$b && make nvcc && cd $SCRIPT_DIR
  done

  for b in ${b_x86[@]}; do
    cd $SCRIPT_DIR/$b && make nvcc && cd $SCRIPT_DIR
  done
}

function do_compile_project {
  local path=$1
  local name=$2

  echo "================================="
  echo "================================="
  echo "==== building $name"
  echo "================================="
  echo "================================="
  cd $path
  make clean

  make
  local ret=$?

  if [[ ret -ne 0 ]]; then
    echo "$b failed with code $ret"
    exit 1
  fi

  cd $HERE_DIR
  echo "==== building $b done"
}

function do_compile_aarch64 {
  # must be executed with bash
  HERE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
  source $SCRIPTS_DIR/env-aarch64.sh
  set +x
  export CC=aarch64-none-linux-gnu-gcc
  export CXX=aarch64-none-linux-gnu-g++
  export CROSS_COMPILE=aarch64-none-linux-gnu-
  export AR=aarch64-none-linux-gnu-ar
  set -euo pipefail

  for b in ${b_fvp[@]}; do
    cd $HERE_DIR/$b
    do_compile_project $HERE_DIR/$b $b
    cd $HERE_DIR
  done
}

function do_compile_aarch64_encrypted {
  # must be executed with bash
  HERE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
  source $SCRIPTS_DIR/env-aarch64.sh
  set +x
  export CC=aarch64-none-linux-gnu-gcc
  export CXX=aarch64-none-linux-gnu-g++
  export CROSS_COMPILE=aarch64-none-linux-gnu-
  export AR=aarch64-none-linux-gnu-ar
  set -euo pipefail
  export ENC_CUDA=1

  for b in ${b_fvp[@]}; do
    cd $HERE_DIR/$b
    do_compile_project $HERE_DIR/$b $b
    cd $HERE_DIR
  done
}

function do_compile_x86 {
  # must be executed with bash
  HERE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
  set +x
  set -euo pipefail
  unset ENC_CUDA

  for b in ${b_fvp[@]}; do
    cd $HERE_DIR/$b
    do_compile_project $HERE_DIR/$b $b
    cd $HERE_DIR
  done
}

function do_compile_x86_encrypted {
  # must be executed with bash
  HERE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
  set +x
  set -euo pipefail
  export ENC_CUDA=1

  for b in ${b_fvp[@]}; do
    cd $HERE_DIR/$b
    do_compile_project $HERE_DIR/$b $b
    cd $HERE_DIR
  done
}

function do_clean {
  # must be executed with bash
  HERE_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
  source $SCRIPTS_DIR/env-aarch64.sh
  set +x
  set -euo pipefail

  for b in ${b_fvp[@]}; do
    echo "==== cleaning $b"
    cd $HERE_DIR/$b
    make clean
    cd $HERE_DIR
    echo "==== cleaning $b done"
  done
}

# XXX: limitations due to lack of bash in target runtime
case "$1" in
build)
  # run in bash session
  do_compile_aarch64
  ;;
encrypted)
  # run in bash session
  do_compile_aarch64_encrypted
  ;;
encrypted_x86)
  # run in bash session
  do_compile_x86_encrypted
  ;;
clean)
  # run in bash session
  do_clean
  ;;
run_realm)
  # run in zsh
  do_run_realm
  ;;
run_devmem)
  # run in zsh
  do_run_devmem
  ;;
run_ns)
  # run in zsh
  do_run_ns
  ;;
*)
  echo "unknown"
  exit 1
  ;;
esac
