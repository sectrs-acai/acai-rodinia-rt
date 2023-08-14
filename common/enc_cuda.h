#pragma once

#ifdef __cplusplus
extern "C" {
#endif

/// @brief Setup CUDA for encrypted memcpys.
///        Must be called AFTER cuCtxCreate and BEFORE any cuMemAlloc.
///
/// @param key the 16 bytes symmetric key to use, transfered to the device. 
/// @param iv the initial counter value.
///
/// @return  CUDA_SUCCESS on success, or a CUDA error.
extern CUresult cuda_enc_setup(char *key, char *iv);
extern CUresult cuda_enc_release();
// CUresult cuMemcpyHtoD(CUdeviceptr dstDevice, const void *srcHost, unsigned int ByteCount);


}
#endif
