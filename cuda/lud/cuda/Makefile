include ../../../common/cuda.config

# Add source files here
EXECUTABLE  := lud_cuda
# Cuda source files (compiled with cudacc)
CUFILES     := lud_kernel.cu
# C/C++ source files (compiled with gcc / c++)
CCFILES     := lud.c lud_cuda.c ../common/common.c

OBJS = ../common/common.o lud.o lud_kernel.o
NVCC_FLAGS += -I./../common

.PHONY: all clean 
all : $(EXECUTABLE)

lud.cu.cpp: lud.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

lud_kernel.cu.cpp: lud_kernel.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

#clang: $(SRC)
#	clang++ lud.cu lud_kernel.cu ../common/common.c -o $(EXECUTABLE) \
#		-I../common -I../../util --cuda-gpu-arch=sm_20 \
#		-L/usr/local/cuda/lib64 -lcudart_static -ldl -lrt -pthread -DTIMING

$(EXECUTABLE) : lud.cu.cpp lud_kernel.cu.cpp ../common/common.c
	$(CXX) $(CXX_FLAGS) $? -o $@ $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS) -lrt -pthread

clean:
	rm -f $(EXECUTABLE) $(OBJS) *.linkinfo
