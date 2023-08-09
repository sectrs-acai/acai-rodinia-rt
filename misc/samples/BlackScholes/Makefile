include ../../../common/cuda.config

# Additional parameters
MAXRREGCOUNT  :=  -po maxrregcount=16

# Target rules
all: build
build: BlackScholes

NVCC_FLAGS += -I../common/inc
CCFLAGS += -I../common/inc

# $(NVCC) $(NVCCFLAGS) $(EXTRA_NVCCFLAGS) $(GENCODE_FLAGS) $(MAXRREGCOUNT) $(INCLUDES) -o $@ -c $<
BlackScholes.cu.cpp: BlackScholes.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) $(MAXRREGCOUNT) -c $< -o $@  $(CUDA_FLAG)

# $(GCC) $(CCFLAGS) $(INCLUDES) -o $@ -c $<
#BlackScholes_gold.o: BlackScholes_gold.cpp
#	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

# $(GCC) $(CCFLAGS) -o $@ $+ $(LDFLAGS) $(EXTRA_LDFLAGS)
BlackScholes: BlackScholes.cu.cpp BlackScholes_gold.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

run: build
	./BlackScholes

clean:
	rm -f BlackScholes BlackScholes.o BlackScholes_gold.o *.cu.cpp