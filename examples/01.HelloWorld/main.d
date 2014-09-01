import std.stdio;

import dirrlicht.all;

class MyEventReceiver : IEventReceiver {
	extern(C++)void _destructorDoNotUse() {}
	extern(C++)bool OnEvent(const ref SEvent event) {
		"Hello, World!".writeln;
		return false;
	}
}

void main() {
	
	auto device = createDev(E_DRIVER_TYPE.EDT_SOFTWARE);
	
	auto receiver = new MyEventReceiver;
	//device.setEventReceiver(receiver);
	
	auto driver = device.getVideoDriver();
	auto smgr = device.getSceneManager();
	
	while(device.run()) {
		driver.beginScene();
		driver.endScene();
	}
}


