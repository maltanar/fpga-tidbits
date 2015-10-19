#ifndef WRAPPERREGDRIVER_H
#define WRAPPERREGDRIVER_H


/* Base class for deriving PlatformWrapper register drivers from
 *
 * inspired by the singleton design in
 * http://stackoverflow.com/questions/1008019/c-singleton-design-pattern
*/

template <class T>
class WrapperRegDriver
{
public:
    static WrapperRegDriver getInstance() {
        static WrapperRegDriver instance;
        return instance;
    }

protected:
    // (mandatory) register access methods for the platform wrapper
    virtual void writeReg(unsigned int regInd, T regValue) = 0;
    virtual T readReg(unsigned int regInd) = 0;

    // (optional) functions to ensure coherency across host-accelerator
    virtual void copyBufferHostToAccel(void * hostBuffer, void * accelBuffer, unsigned int numBytes) {}
    virtual void copyBufferAccelToHost(void * accelBuffer, void * hostBuffer, unsigned int numBytes) {}

    // (optional) functions to initialize and deinitialize the wrapper
    virtual bool initialize() {}
    virtual bool deinitialize() {}

private:
    // private constructor and destructor for singleton
    WrapperRegDriver() {
        initialize();
    }

    ~WrapperRegDriver() {
        deinitialize();
    }

    // do not implement, singleton
    WrapperRegDriver(WrapperRegDriver const &);
    void operator=(WrapperRegDriver const&);

};

#endif // WRAPPERREGDRIVER_H
