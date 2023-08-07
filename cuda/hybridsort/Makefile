include ../../common/cuda.config
# CC := $(CUDA_DIR)/bin/nvcc

# CC_FLAGS = -arch=sm_20

ifdef VERIFY
override VERIFY = -DVERIFY
endif

ifdef OUTPUT
override OUTPUT = -DOUTPUT
endif

ifdef TIMER
override TIMER = -DTIMER
endif

hybridsort: bucketsort.cu.cpp mergesort.cu.cpp main.cu.cpp
# hybridsort: main.cu.cpp  bucketsort.cu.cpp bucketsort.h bucketsort_kernel.cu.cpp histogram1024_kernel.cu.cpp  mergesort.cu.cpp mergesort_kernel.cu.cpp
	# $(CC) $(CC_FLAGS) $(VERIFY) $(OUTPUT) $(TIMER) $(HISTO_WG_SIZE_0) $(BUCKET_WG_SIZE_0) $(BUCKET_WG_SIZE_1) $(MERGE_WG_SIZE_0) $(MERGE_WG_SIZE_1) bucketsort.cu.cpp mergesort.cu.cpp main.cu.cpp -o hybridsort
	$(CXX) $(CXX_FLAGS) $? -o $@ $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)

%.cu.cpp: %.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS)  -c $<  -o $@  $(CUDA_FLAG)

clean:
	rm	*.o hybridsort *.cu.cpp
