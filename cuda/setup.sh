#!/bin/zsh
#
set -euo pipefail
SCRIPTS_DIR=/home/b/2.5bay/mthesis-unsync/projects/trusted-periph/scripts/
BENCH_OUT_DIR=/mnt/host/mnt/host/benchmark-rodinia-runtime
ITERS=1

b_fvp=(
"b+tree" \
"dwt2d" \
"heartwall" \
"hotspot3D" \
"lavaMD" \
"lud/cuda" \
"myocyte" \
"particlefilter"
"streamcluster"
 )


function do_run {
    SCRIPT_DIR=${0:a:h}
    TS=$(date +"%Y-%m-%d_%H-%M-%S")
    DIR=$BENCH_OUT_DIR/$TS
    mkdir -p $DIR
    set +x

    for b in ${b_fvp[@]}; do
        for i in {1..$ITERS}; do
            LOG=$DIR/$b
            echo "executing $b"

            cd $SCRIPT_DIR/$b
            cat ./run | tee -a $LOG
            exec ./run 2>&1 | tee -a $LOG
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
