include ../../../common/cuda.config


MAXRREGCOUNT  :=  -po maxrregcount=16

all: build
build: BlackScholes

NVCC_FLAGS += -I../common/inc
CCFLAGS += -I../common/inc

BlackScholes.cu.cpp: BlackScholes.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) $(MAXRREGCOUNT) -c $< -o $@  $(CUDA_FLAG)

BlackScholes: BlackScholes.cu.cpp BlackScholes_gold.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

run: build
	./BlackScholes

clean:
	rm -f BlackScholes BlackScholes.o BlackScholes_gold.o *.cu.cpp