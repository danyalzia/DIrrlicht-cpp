#include <irrlicht.h>

using namespace irr;

IrrlichtDevice* createDev() {
    return createDevice(video::EDT_BURNINGSVIDEO, core::dimension2du(800,600), false, false);
}
