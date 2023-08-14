#!/bin/zsh
#
set -euo pipefail
SCRIPTS_DIR=/home/b/2.5bay/mthesis-unsync/projects/trusted-periph/scripts/
BENCH_OUT_DIR=/mnt/host/mnt/host/benchmark-rodinia-runtime
ITERS=1

b_fvp=(
"hotspot3D" \
"lavaMD" \
"lud/cuda" \
"particlefilter"
"streamcluster" \
"b+tree" \
"heartwall" \
"../misc/samples/BlackScholes" \
"myocyte" \
 )


function do_run {
    SCRIPT_DIR=${0:a:h}
    TS=$(date +"%Y-%m-%d_%H-%M-%S")
    DIR=$BENCH_OUT_DIR/$TS
    mkdir -p $DIR
    set +x

    for b in ${b_fvp[@]}; do
        for i in {1..$ITERS}; do
            NAME=$(basename $b)
            LOG=$DIR/$NAME
            echo "executing $b"

            cd $SCRIPT_DIR/$b
            cat ./run | tee -a $LOG
            exec time ./run 2>&1 | tee -a $LOG
            echo "--------------" >> $LOG
        done
    done
}

function do_run_devmem {
    SCRIPT_DIR=${0:a:h}
    TS=$(date +"%Y-%m-%d_%H-%M-%S")
    DIR=$BENCH_OUT_DIR/$TS
    mkdir -p $DIR
    set +x
    DEVMEM_UNDELGATE=$SCRIPT_DIR/../../../../scripts/fvp/reset_devmem.sh

    for b in ${b_fvp[@]}; do
        for i in {1..$ITERS}; do
            NAME=$(basename $b)
            LOG=$DIR/$NAME
            echo "executing $b"

            cd $SCRIPT_DIR/$b
            cat ./run | tee -a $LOG
            exec time ./run 2>&1 | tee -a $LOG
            echo "--------------" >> $LOG
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

function do_compile {
    # must be executed with bash
    HERE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    source $SCRIPTS_DIR/env-aarch64.sh
    set +x
    export CC=aarch64-none-linux-gnu-gcc
    export CXX=aarch64-none-linux-gnu-g++
    export CROSS_COMPILE=aarch64-none-linux-gnu-
    export AR=aarch64-none-linux-gnu-ar
    set -euo pipefail

    for b in ${b_fvp[@]}; do
        echo "================================="
        echo "==== building $b"
        cd $HERE_DIR/$b && make clean; make && cd $HERE_DIR
        echo "==== building $b done"
    done
}


function do_compile_encrypted {
    # must be executed with bash
    HERE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    source $SCRIPTS_DIR/env-aarch64.sh
    set +x
    export CC=aarch64-none-linux-gnu-gcc
    export CXX=aarch64-none-linux-gnu-g++
    export CROSS_COMPILE=aarch64-none-linux-gnu-
    export AR=aarch64-none-linux-gnu-ar
    set -euo pipefail
    export ENC_CUDA=1

    for b in ${b_fvp[@]}; do
        echo "================================="
        echo "==== building $b"
        cd $HERE_DIR/$b && make clean && make && cd $HERE_DIR
        echo "==== building $b done"
    done
}


function do_compile_encrypted_x86 {
    # must be executed with bash
    HERE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    set +x
    set -euo pipefail
    export ENC_CUDA=1

    for b in ${b_fvp[@]}; do
        echo "================================="
        echo "==== building $b"
        cd $HERE_DIR/$b && make clean && make && cd $HERE_DIR
        echo "==== building $b done"
    done
}


function do_clean {
    # must be executed with bash
    HERE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    source $SCRIPTS_DIR/env-aarch64.sh
    set +x
    set -euo pipefail

    for b in ${b_fvp[@]}; do
        echo "================================="
        echo "==== cleaning $b"
        cd $HERE_DIR/$b && make clean && cd $HERE_DIR
        echo "==== cleaning $b done"
    done
}

case "$1" in
    build)
        do_compile
        ;;
    encrypted)
        do_compile_encrypted
    ;;
  encrypted_x86)
          do_compile_encrypted_x86
      ;;
    clean)
        do_clean
    ;;
    run)
        do_run
        ;;
    *)
        echo "unknown"
        exit 1
esac
