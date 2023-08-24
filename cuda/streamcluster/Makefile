include ../../common/cuda.config

TARGET_G = sc_gpu

#
$(TARGET_G): streamcluster_cuda.cu.cpp streamcluster_cuda_cpu.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)
	

streamcluster_cuda.cu.cpp: streamcluster_cuda.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

clean:
	rm -f *.o *~ *.txt $(TARGET_G) *.linkinfo *.cu.cpp
	
