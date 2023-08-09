include ../../../common/cuda.config

# Additional parameters
MAXRREGCOUNT  :=  -po maxrregcount=16

NVCC_FLAGS += -I../common/inc
CCFLAGS += -I../common/inc

# Target rules
all: build

build: MonteCarloMultiGPU

# $(NVCC) $(NVCCFLAGS) $(EXTRA_NVCCFLAGS) $(GENCODE_FLAGS) $(INCLUDES) -o $@ -c $<
MonteCarlo_kernel.cu.cpp: MonteCarlo_kernel.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) $(MAXRREGCOUNT) -c $< -o $@  $(CUDA_FLAG)

MonteCarloMultiGPU: MonteCarloMultiGPU.cpp multithreading.cpp MonteCarlo_gold.cpp MonteCarlo_kernel.cu.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS) -lpthread

run: build
	./MonteCarloMultiGPU

clean:
	rm -f MonteCarloMultiGPU MonteCarloMultiGPU.o multithreading.o MonteCarlo_gold.o MonteCarlo_kernel.o *.cu.cpp