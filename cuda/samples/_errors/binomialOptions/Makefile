include ../../../common/cuda.config

NVCC_FLAGS += -I../common/inc
CCFLAGS += -I../common/inc
MAXRREGCOUNT  :=  -po maxrregcount=16


# Target rules
all: build

build: binomialOptions

# $(NVCC) $(NVCCFLAGS) $(EXTRA_NVCCFLAGS) $(GENCODE_FLAGS) $(INCLUDES) -o $@ -c $<
binomialOptions_SM10.cu.cpp: binomialOptions_SM10.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) $(MAXRREGCOUNT) -c $< -o $@  $(CUDA_FLAG)

# $(NVCC) $(NVCCFLAGS) $(EXTRA_NVCCFLAGS) $(GENCODE_SM13) $(GENCODE_SM20) $(GENCODE_SM30) $(INCLUDES) -o $@ -c $<
binomialOptions_SM13.cu.cpp: binomialOptions_SM13.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) $(MAXRREGCOUNT) -c $< -o $@  $(CUDA_FLAG)

binomialOptions: binomialOptions.cpp binomialOptions_gold.cpp binomialOptions_SM10.cu.cpp binomialOptions_SM13.cu.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

run: build
	./binomialOptions

clean:
	rm -f binomialOptions binomialOptions.o binomialOptions_gold.o binomialOptions_SM10.o binomialOptions_SM13.o *.cu.cpp