include ../../../common/cuda.config


# Additional parameters
MAXRREGCOUNT  :=  -po maxrregcount=16



NVCC_FLAGS += -I../common/inc
CCFLAGS += -I../common/inc


# Target rules
all: build

build: HSOpticalFlow

flowCUDA.cu.cpp: flowCUDA.cu addKernel.cuh derivativesKernel.cuh downscaleKernel.cuh solverKernel.cuh upscaleKernel.cuh warpingKernel.cuh
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) $(MAXRREGCOUNT) -c flowCUDA.cu -o $@  $(CUDA_FLAG)

# 	$(GCC) $(CCFLAGS) -o $@ $+ $(LDFLAGS) $(EXTRA_LDFLAGS)
HSOpticalFlow: flowCUDA.cu.cpp main.cpp flowGold.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

run: build
	./HSOpticalFlow

clean:
	rm -f flowCUDA.o main.o flowGold.o HSOpticalFlow *.cu.cpp


