#include <irrlicht.h>

using namespace irr;

IrrlichtDevice* createDev(video::E_DRIVER_TYPE driverType) {
    return createDevice(driverType, core::dimension2du(800,600));
}
