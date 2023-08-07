include common/make.config

RODINIA_BASE_DIR := $(shell pwd)

CUDA_BIN_DIR := $(RODINIA_BASE_DIR)/bin/linux/cuda
OMP_BIN_DIR := $(RODINIA_BASE_DIR)/bin/linux/omp
OPENCL_BIN_DIR := $(RODINIA_BASE_DIR)/bin/linux/opencl

CUDA_DIRS :=  b+tree dwt2d heartwall lavaMD hotspot3D lud streamcluster particlefilter streamcluster

all: CUDA_make

CUDA_clean:
	for dir in $(CUDA_DIRS) ; do cd cuda/$$dir ; make clean ; cd ../.. ; done

CUDA_make:
	for dir in $(OMP_DIRS) ; do cd cuda/$$dir ; make clean ; make ; cd ../.. ; done
