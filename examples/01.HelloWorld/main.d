import std.stdio, std.conv, std.utf;

import dirrlicht.all;

class MyEventReceiver : IEventReceiver {
	extern(C++)void _destructorDoNotUse() {}
	extern(C++)bool OnEvent(const ref SEvent event) {
		"Hello, World!".writeln;
		return false;
	}
}

void main() {
	
	auto device = createDev(E_DRIVER_TYPE.EDT_BURNINGSVIDEO);
	
	auto receiver = new MyEventReceiver;
	//device.setEventReceiver(receiver);
	
	auto driver = device.getVideoDriver();
	auto smgr = device.getSceneManager();

	device.setWindowCaption("Hello World!".toUTFz!(const dchar*));
	device.getVersion.to!string.writeln;
	device.setResizable(true);

	auto d = dimension2du(640, 480);
	device.setWindowSize(d);

	auto r = device.getRandomizer();
	r.reset();
	r.rand.writeln;
	r.frand.writeln;
	r.randMax.writeln;

	auto t = device.getTimer();
	t.getRealTime.writeln;
	auto time = t.getRealTimeAndDate;
	"Time: ".writeln;
	time.Hour.writeln;
	time.Minute.writeln;
	time.Second.writeln;
	time.Year.writeln;
	
	t.getTime.writeln;

	auto logger = device.getLogger();
	
	while(device.run()) {
		//driver.beginScene();
		driver.endScene();
	}
}


