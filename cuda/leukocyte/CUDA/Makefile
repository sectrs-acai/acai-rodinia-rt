include ../../../common/cuda.config


MATRIX_DIR = ../meschach_lib
CCFLAGS += -I../meschach_lib
CC_FLAGS += $(CCFLAGS)
NVCC_FLAGS += -I../meschach_lib

leukocyte: detect_main.c avilib.c find_ellipse.c find_ellipse_kernel.cu.cpp track_ellipse.c track_ellipse_kernel.cu.cpp misc_math.c $(MATRIX_DIR)/meschach.a
	$(CC) $(CCFLAGS) $? $(MATRIX_DIR)/meschach.a -o $@ $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)
	# $(CC) $(CC_FLAGS) -lm avilib.o find_ellipse.o find_ellipse_kernel.o track_ellipse.o track_ellipse_kernel.o misc_math.o detect_main.o -o leukocyte $(MATRIX_DIR)/meschach.a -L$(CUDA_LIB_DIR) -lm -lcuda -lcudart
#
#%.o: %.[ch]
#	$(CC) $(CC_FLAGS) $< -c
#
#detect_main.o: detect_main.c find_ellipse.h track_ellipse.h avilib.h
#	$(CC) $(CC_FLAGS) detect_main.c -c

find_ellipse_kernel.cu.cpp: find_ellipse_kernel.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

track_ellipse_kernel.cu.cpp: track_ellipse_kernel.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

#find_ellipse.o: avilib.h
#
#track_ellipse.o: find_ellipse.h avilib.h

$(MATRIX_DIR)/meschach.a:
	cd $(MATRIX_DIR); ./configure --with-all; make all; make clean

clean:
	rm -f *.o *~ leukocyte *.linkinfo *.cu.cpp
