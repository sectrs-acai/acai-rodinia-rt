include ../../common/cuda.config
#Configure
#CUDA_INSTALL_PATH ?= /usr/local/cuda

EXECUTABLE := dwt2d

# Debug options
dbg=0
cudagdb=0 #compile for use with cuda-gdb, note that 'dbg' must be 1 as well
performancetest=1

# NVCC Options
# NVCCFLAGS += -arch sm_20

# Files
CFILES := 
CXXFILES := main.cpp common.cpp
CUFILES :=  components.cu dwt_cuda/fdwt53.cu dwt_cuda/fdwt97.cu dwt_cuda/common.cu dwt_cuda/rdwt97.cu dwt_cuda/rdwt53.cu dwt.cu
CU_CPP_FILES = components.cu.cpp dwt_cuda/fdwt53.cu.cpp dwt_cuda/fdwt97.cu.cpp dwt_cuda/common.cu.cpp dwt_cuda/rdwt97.cu.cpp dwt_cuda/rdwt53.cu.cpp dwt.cu.cpp

# Includes
#INCLUDES := -I. -I$(CUDA_DIR)/include




# Common flags
#COMMONFLAGS += $(INCLUDES)
#NVCCFLAGS += $(COMMONFLAGS)
#CXXFLAGS += $(COMMONFLAGS)
#CFLAGS += $(COMMONFLAGS) -std=c99
#LDFLAGS += -L$(CUDA_INSTALL_PATH)/lib64 -lcudart

# Warning flags (from cuda common.mk)


#CFLAGS += $(CWARN_FLAGS)
#CXXFLAGS += $(CXXWARN_FLAGS)

# Debug/release flags
#ifeq ($(dbg),1)
#    COMMONFLAGS += -g
#    NVCCFLAGS   += -D_DEBUG
#    CXXFLAGS    += -D_DEBUG
#    CFLAGS      += -D_DEBUG
#
#    ifeq ($(cudagdb),1)
#        NVCCFLAGS += -G
#    endif
#else
#    COMMONFLAGS += -O2
#    NVCCFLAGS   += --compiler-options -fno-strict-aliasing $(NVCC_FLAGS)
#    CXXFLAGS    += -fno-strict-aliasing $(CXX_FLAGS)
#    CFLAGS      += -fno-strict-aliasing
#endif

#CFLAGS +=  $(INCLUDES)
#CXX_FLAGS +=  $(INCLUDES)

#ifeq ($(performancetest),1)
#    COMMONFLAGS += -DGPU_DWT_TESTING
#endif

#ifdef OUTPUT
#	override OUTPUT = -DOUTPUT
#endif



# Compilers



# Generate object files list
COBJS=$(CFILES:.c=.c.o)
CXXOBJS=$(CXXFILES:.cpp=.cpp.o)
# CUOBJS=$(CUFILES:.cu=.cu.o)

.SUFFIXES: .c.o .cpp.o .cu.o .cu 

%.c.o: %.c
	$(CC) $(CCFLAGS) -c $< -o $@



%.cu.cpp: %.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

%.cpp.o: %.cpp
	$(CC) $(CCFLAGS) -c $< -o $@

$(EXECUTABLE): $(COBJS) $(CXXOBJS) $(CUOBJS) $(CU_CPP_FILES)
	$(CC) $(CCFLAGS) -o $(EXECUTABLE) $? $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)

clean:
	rm -f $(COBJS) $(CXXOBJS) $(CUOBJS) $(EXECUTABLE)
	rm -f *.bmp.dwt.* *.cu.cpp dwt_cuda/*.cu.cpp dwt_cuda/*.o *.o *.cu.cpp
