#ifndef WRAPPERREGDRIVER_H
#define WRAPPERREGDRIVER_H

template <class T>
class WrapperRegDriver
{
public:
    WrapperRegDriver();

    // functions to initialize and deinitialize the wrapper
    virtual bool initialize();
    virtual bool deinitialize();

protected:
    // register access methods for the platform wrapper
    // must be implemented for all wrappers
    virtual void writeReg(unsigned int regInd, T regValue) = 0;
    virtual T readReg(unsigned int regInd) = 0;

    virtual void copyBufferHostToAccel(void * buffer, unsigned int numBytes);

};

#endif // WRAPPERREGDRIVER_H
