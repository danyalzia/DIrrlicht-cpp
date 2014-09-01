import std.stdio;

import dirrlicht.all;

class MyEventReceiver : IEventReceiver {
	extern(C++)bool OnEvent(const ref SEvent event) {
		"Hello, World!".writeln;
		return false;
	}
}

void main() {
	
	auto device = createDev();

	auto receiver = new MyEventReceiver;
	device.setEventReceiver(receiver);
	
	auto driver = device.getVideoDriver();
	assert(driver !is null);
	
	while(device.run()) {
		driver.beginScene();
		driver.endScene();
	}
}


