#ifndef ZEDBOARDREGDRIVER_H
#define ZEDBOARDREGDRIVER_H

#include "axiregdriver.hpp"
#include <string.h>
#include <stdlib.h>
#include "xil_cache.h"

class ZedBoardRegDriver :  public AXIRegDriver {
public:
  ZedBoardRegDriver(void *baseAddr) : AXIRegDriver(baseAddr) {}

  virtual std::string platformID() {
		return "ZedBoardDriver";
	}

  // functions for host-accelerator buffer management
  virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {
    memcpy(accelBuffer, hostBuffer, numBytes);
    Xil_DCacheFlushRange((unsigned int) accelBuffer, numBytes);
  }

  virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {
    Xil_DCacheInvalidateRange((unsigned int) accelBuffer, numBytes);
    memcpy(hostBuffer,accelBuffer, numBytes);
  }

  virtual void * allocAccelBuffer(unsigned int numBytes) { return malloc_aligned(64, numBytes);}
  virtual void deallocAccelBuffer(void * buffer) { free_aligned(buffer);}

protected:
  // custom aligned malloc-free from http://stackoverflow.com/questions/6563120/what-does-posix-memalign-memalign-do
  void *malloc_aligned(size_t alignment, size_t bytes)
  {
    // we need to allocate enough storage for the requested bytes, some
    // book-keeping (to store the location returned by malloc) and some extra
    // padding to allow us to find an aligned byte.  im not entirely sure if
    // 2 * alignment is enough here, its just a guess.
    const size_t total_size = bytes + (2 * alignment) + sizeof(size_t);

    // use malloc to allocate the memory.
    char *data = (char *) malloc(sizeof(char) * total_size);

    if (data)
    {
      // store the original start of the malloc'd data.
      const void * const data_start = data;

      // dedicate enough space to the book-keeping.
      data += sizeof(size_t);

      // find a memory location with correct alignment.  the alignment minus
      // the remainder of this mod operation is how many bytes forward we need
      // to move to find an aligned byte.
      const size_t offset = alignment - (((size_t)data) % alignment);

      // set data to the aligned memory.
      data += offset;

      // write the book-keeping.
      size_t *book_keeping = (size_t*)(data - sizeof(size_t));
      *book_keeping = (size_t)data_start;
    } else throw "Failure in malloc_aligned"; // freak out

    return data;
  }

  void free_aligned(void *raw_data)
  {
    if (raw_data)
    {
      char *data = (char *) raw_data;

      // we have to assume this memory was allocated with malloc_aligned.
      // this means the sizeof(size_t) bytes before data are the book-keeping
      // which points to the location we need to pass to free.
      data -= sizeof(size_t);

      // set data to the location stored in book-keeping.
      data = (char*)(*((size_t*)data));

      // free the memory.
      free(data);
    }
  }
};

#endif
