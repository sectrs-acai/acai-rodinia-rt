include ../../common/cuda.config

OBJ = main_test_cu.cu.cpp stats_logger.cpp vlc_kernel_sm64huff.cu.cpp scan.cu.cpp pack_kernels.cu.cpp cpuencode.cpp
EXE = pavle

pavle: $(OBJ)
	$(CXX) $(CXX_FLAGS) $? -o $@ $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)
	# $(NVCC) $(TESTING) $(CACHECWLUT) $(NVCC_OPTS) $(OBJ) -o $(EXE)

#vlc_kernel_sm64huff.o: vlc_kernel_sm64huff.cu
#	$(NVCC) $(TESTING) -c vlc_kernel_sm64huff.cu $(NVCC_OPTS)

vlc_kernel_sm64huff.cu.cpp: vlc_kernel_sm64huff.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

#scan.o: scan.cu
#	$(NVCC) -c scan.cu $(NVCC_OPTS)

scan.cu.cpp: scan.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)


#cpuencodec.cu.cpp: cpuencode.cu
#	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)
#	# $(NVCC) -c $(NVCC_OPTS) cpuencode.cu

pack_kernels.cu.cpp: pack_kernels.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

#pack_kernels.o: pack_kernels.cu
#	$(NVCC) -c pack_kernels.cu $(NVCC_OPTS)

main_test_cu.cu.cpp: main_test_cu.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

# this?
#main_test_cu.o: main_test_cu.cu.cpp cutil.h
#	$(CXX) $(CXX_FLAGS) $? -o $@ $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)
	# $(CCX) $(TESTING) -c main_test_cu.cu $(NVCC_OPTS) -I $(CUDA_INCLUDEPATH)

#%.o:%.cpp
	# $(CXX) $(CXX_FLAGS) $? -o $@ $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)
#	$(CCX) $(CXX_FLAGS) ++ $(GCC_OPTS) -c $@ -o $< $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)

clean:
	rm -f *.o $(EXE) *.cu.cpp
