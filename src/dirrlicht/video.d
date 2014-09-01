module dirrlicht.video;

extern(C++) {
	extern(C++, irr) {
		
		extern(C++, video) {
			interface IVideoDriver {
				bool beginScene();
				bool endScene();
			}

			interface IVideoModeList {
			}
			
			enum E_DRIVER_TYPE {
				EDT_NULL,
				EDT_SOFTWARE,
				EDT_BURNINGSVIDEO,
				EDT_DIRECT3D8,
				EDT_DIRECT3D9,
				EDT_OPENGL,
				EDT_COUNT
			}
		}
	}
}
