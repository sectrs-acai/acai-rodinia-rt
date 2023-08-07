include ../../common/cuda.config



backprop: backprop.o facetrain.o imagenet.o backprob_cuda.cu.cpp
	$(CC) $(CC_FLAGS) $^ -o $@ $(CC_LIB_DIRS) $(CC_LIBS)

%.o: %.[ch]
	$(CC) $(CC_FLAGS) $< -c

facetrain.o: facetrain.c backprop.h
	$(CC) $(CC_FLAGS) facetrain.c -c

backprop.o: backprop.c backprop.h
	$(CC) $(CC_FLAGS) backprop.c -c

# backprop_cuda.o: backprop_cuda.cu backprop.h
# 	$(NVCC) $(NVCC_FLAGS) -c backprop_cuda.cu
#
backprob_cuda.cu.cpp: backprob_cuda.cu
	$(NVCC) $(NVCC_FLAGS) -c $^ -o $@

imagenet.o: imagenet.c backprop.h
	$(CC) $(CC_FLAGS) imagenet.c -c


clean:
	rm -f *.o *~ backprop backprop_cuda.linkinfo *.cu.cpp
