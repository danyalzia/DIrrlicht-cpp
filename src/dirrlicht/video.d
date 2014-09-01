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

			//! An enum for the color format of textures used by the Irrlicht Engine.
			/** A color format specifies how color information is stored. */
			enum ECOLOR_FORMAT
			{
				//! 16 bit color format used by the software driver.
				/** It is thus preferred by all other irrlicht engine video drivers.
				There are 5 bits for every color component, and a single bit is left
				for alpha information. */
				ECF_A1R5G5B5 = 0,

				//! Standard 16 bit color format.
				ECF_R5G6B5,

				//! 24 bit color, no alpha channel, but 8 bit for red, green and blue.
				ECF_R8G8B8,

				//! Default 32 bit color format. 8 bits are used for every component: red, green, blue and alpha.
				ECF_A8R8G8B8,

				/** Compressed image formats. **/

				//! DXT1 color format.
				ECF_DXT1,

				//! DXT2 color format.
				ECF_DXT2,

				//! DXT3 color format.
				ECF_DXT3,

				//! DXT4 color format.
				ECF_DXT4,

				//! DXT5 color format.
				ECF_DXT5,

				/** Floating Point formats. The following formats may only be used for render target textures. */

				//! 16 bit floating point format using 16 bits for the red channel.
				ECF_R16F,

				//! 32 bit floating point format using 16 bits for the red channel and 16 bits for the green channel.
				ECF_G16R16F,

				//! 64 bit floating point format 16 bits are used for the red, green, blue and alpha channels.
				ECF_A16B16G16R16F,

				//! 32 bit floating point format using 32 bits for the red channel.
				ECF_R32F,

				//! 64 bit floating point format using 32 bits for the red channel and 32 bits for the green channel.
				ECF_G32R32F,

				//! 128 bit floating point format. 32 bits are used for the red, green, blue and alpha channels.
				ECF_A32B32G32R32F,

				//! Unknown color format:
				ECF_UNKNOWN
			}
		}
	}
}
