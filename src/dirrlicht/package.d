module dirrlicht;

import dirrlicht.core;
import dirrlicht.gui;
import dirrlicht.video;
import dirrlicht.io;
import dirrlicht.scene;

extern(C++) {
	extern(C++, irr) {
		//! An enum for the different device types supported by the Irrlicht Engine.
		enum E_DEVICE_TYPE
		{
			//! A device native to Microsoft Windows
			/** This device uses the Win32 API and works in all versions of Windows. */
			EIDT_WIN32,

			//! A device native to Windows CE devices
			/** This device works on Windows Mobile, Pocket PC and Microsoft SmartPhone devices */
			EIDT_WINCE,

			//! A device native to Unix style operating systems.
			/** This device uses the X11 windowing system and works in Linux, Solaris, FreeBSD, OSX and
			other operating systems which support X11. */
			EIDT_X11,

			//! A device native to Mac OSX
			/** This device uses Apple's Cocoa API and works in Mac OSX 10.2 and above. */
			EIDT_OSX,

			//! A device which uses Simple DirectMedia Layer
			/** The SDL device works under all platforms supported by SDL but first must be compiled
			in by defining the IRR_USE_SDL_DEVICE macro in IrrCompileConfig.h */
			EIDT_SDL,

			//! A device for raw framebuffer access
			/** Best used with embedded devices and mobile systems.
			Does not need X11 or other graphical subsystems.
			May support hw-acceleration via OpenGL-ES for FBDirect */
			EIDT_FRAMEBUFFER,

			//! A simple text only device supported by all platforms.
			/** This device allows applications to run from the command line without opening a window.
			It can render the output of the software drivers to the console as ASCII. It only supports
			mouse and keyboard in Windows operating systems. */
			EIDT_CONSOLE,

			//! This selection allows Irrlicht to choose the best device from the ones available.
			/** If this selection is chosen then Irrlicht will try to use the IrrlichtDevice native
			to your operating system. If this is unavailable then the X11, SDL and then console device
			will be tried. This ensures that Irrlicht will run even if your platform is unsupported,
			although it may not be able to render anything. */
			EIDT_BEST
		}
	
		enum ELOG_LEVEL
		{
			ELL_DEBUG,
			ELL_INFORMATION,
			ELL_WARNING,
			ELL_ERROR,
			ELL_NONE
		}

		enum EKEY_CODE
		{
			KEY_LBUTTON          = 0x01,  // Left mouse button
			KEY_RBUTTON          = 0x02,  // Right mouse button
			KEY_CANCEL           = 0x03,  // Control-break processing
			KEY_MBUTTON          = 0x04,  // Middle mouse button (three-button mouse)
			KEY_XBUTTON1         = 0x05,  // Windows 2000/XP: X1 mouse button
			KEY_XBUTTON2         = 0x06,  // Windows 2000/XP: X2 mouse button
			KEY_BACK             = 0x08,  // BACKSPACE key
			KEY_TAB              = 0x09,  // TAB key
			KEY_CLEAR            = 0x0C,  // CLEAR key
			KEY_RETURN           = 0x0D,  // ENTER key
			KEY_SHIFT            = 0x10,  // SHIFT key
			KEY_CONTROL          = 0x11,  // CTRL key
			KEY_MENU             = 0x12,  // ALT key
			KEY_PAUSE            = 0x13,  // PAUSE key
			KEY_CAPITAL          = 0x14,  // CAPS LOCK key
			KEY_KANA             = 0x15,  // IME Kana mode
			KEY_HANGUEL          = 0x15,  // IME Hanguel mode (maintained for compatibility use KEY_HANGUL)
			KEY_HANGUL           = 0x15,  // IME Hangul mode
			KEY_JUNJA            = 0x17,  // IME Junja mode
			KEY_FINAL            = 0x18,  // IME final mode
			KEY_HANJA            = 0x19,  // IME Hanja mode
			KEY_KANJI            = 0x19,  // IME Kanji mode
			KEY_ESCAPE           = 0x1B,  // ESC key
			KEY_CONVERT          = 0x1C,  // IME convert
			KEY_NONCONVERT       = 0x1D,  // IME nonconvert
			KEY_ACCEPT           = 0x1E,  // IME accept
			KEY_MODECHANGE       = 0x1F,  // IME mode change request
			KEY_SPACE            = 0x20,  // SPACEBAR
			KEY_PRIOR            = 0x21,  // PAGE UP key
			KEY_NEXT             = 0x22,  // PAGE DOWN key
			KEY_END              = 0x23,  // END key
			KEY_HOME             = 0x24,  // HOME key
			KEY_LEFT             = 0x25,  // LEFT ARROW key
			KEY_UP               = 0x26,  // UP ARROW key
			KEY_RIGHT            = 0x27,  // RIGHT ARROW key
			KEY_DOWN             = 0x28,  // DOWN ARROW key
			KEY_SELECT           = 0x29,  // SELECT key
			KEY_PRINT            = 0x2A,  // PRINT key
			KEY_EXECUT           = 0x2B,  // EXECUTE key
			KEY_SNAPSHOT         = 0x2C,  // PRINT SCREEN key
			KEY_INSERT           = 0x2D,  // INS key
			KEY_DELETE           = 0x2E,  // DEL key
			KEY_HELP             = 0x2F,  // HELP key
			KEY_KEY_0            = 0x30,  // 0 key
			KEY_KEY_1            = 0x31,  // 1 key
			KEY_KEY_2            = 0x32,  // 2 key
			KEY_KEY_3            = 0x33,  // 3 key
			KEY_KEY_4            = 0x34,  // 4 key
			KEY_KEY_5            = 0x35,  // 5 key
			KEY_KEY_6            = 0x36,  // 6 key
			KEY_KEY_7            = 0x37,  // 7 key
			KEY_KEY_8            = 0x38,  // 8 key
			KEY_KEY_9            = 0x39,  // 9 key
			KEY_KEY_A            = 0x41,  // A key
			KEY_KEY_B            = 0x42,  // B key
			KEY_KEY_C            = 0x43,  // C key
			KEY_KEY_D            = 0x44,  // D key
			KEY_KEY_E            = 0x45,  // E key
			KEY_KEY_F            = 0x46,  // F key
			KEY_KEY_G            = 0x47,  // G key
			KEY_KEY_H            = 0x48,  // H key
			KEY_KEY_I            = 0x49,  // I key
			KEY_KEY_J            = 0x4A,  // J key
			KEY_KEY_K            = 0x4B,  // K key
			KEY_KEY_L            = 0x4C,  // L key
			KEY_KEY_M            = 0x4D,  // M key
			KEY_KEY_N            = 0x4E,  // N key
			KEY_KEY_O            = 0x4F,  // O key
			KEY_KEY_P            = 0x50,  // P key
			KEY_KEY_Q            = 0x51,  // Q key
			KEY_KEY_R            = 0x52,  // R key
			KEY_KEY_S            = 0x53,  // S key
			KEY_KEY_T            = 0x54,  // T key
			KEY_KEY_U            = 0x55,  // U key
			KEY_KEY_V            = 0x56,  // V key
			KEY_KEY_W            = 0x57,  // W key
			KEY_KEY_X            = 0x58,  // X key
			KEY_KEY_Y            = 0x59,  // Y key
			KEY_KEY_Z            = 0x5A,  // Z key
			KEY_LWIN             = 0x5B,  // Left Windows key (Microsoft® Natural® keyboard)
			KEY_RWIN             = 0x5C,  // Right Windows key (Natural keyboard)
			KEY_APPS             = 0x5D,  // Applications key (Natural keyboard)
			KEY_SLEEP            = 0x5F,  // Computer Sleep key
			KEY_NUMPAD0          = 0x60,  // Numeric keypad 0 key
			KEY_NUMPAD1          = 0x61,  // Numeric keypad 1 key
			KEY_NUMPAD2          = 0x62,  // Numeric keypad 2 key
			KEY_NUMPAD3          = 0x63,  // Numeric keypad 3 key
			KEY_NUMPAD4          = 0x64,  // Numeric keypad 4 key
			KEY_NUMPAD5          = 0x65,  // Numeric keypad 5 key
			KEY_NUMPAD6          = 0x66,  // Numeric keypad 6 key
			KEY_NUMPAD7          = 0x67,  // Numeric keypad 7 key
			KEY_NUMPAD8          = 0x68,  // Numeric keypad 8 key
			KEY_NUMPAD9          = 0x69,  // Numeric keypad 9 key
			KEY_MULTIPLY         = 0x6A,  // Multiply key
			KEY_ADD              = 0x6B,  // Add key
			KEY_SEPARATOR        = 0x6C,  // Separator key
			KEY_SUBTRACT         = 0x6D,  // Subtract key
			KEY_DECIMAL          = 0x6E,  // Decimal key
			KEY_DIVIDE           = 0x6F,  // Divide key
			KEY_F1               = 0x70,  // F1 key
			KEY_F2               = 0x71,  // F2 key
			KEY_F3               = 0x72,  // F3 key
			KEY_F4               = 0x73,  // F4 key
			KEY_F5               = 0x74,  // F5 key
			KEY_F6               = 0x75,  // F6 key
			KEY_F7               = 0x76,  // F7 key
			KEY_F8               = 0x77,  // F8 key
			KEY_F9               = 0x78,  // F9 key
			KEY_F10              = 0x79,  // F10 key
			KEY_F11              = 0x7A,  // F11 key
			KEY_F12              = 0x7B,  // F12 key
			KEY_F13              = 0x7C,  // F13 key
			KEY_F14              = 0x7D,  // F14 key
			KEY_F15              = 0x7E,  // F15 key
			KEY_F16              = 0x7F,  // F16 key
			KEY_F17              = 0x80,  // F17 key
			KEY_F18              = 0x81,  // F18 key
			KEY_F19              = 0x82,  // F19 key
			KEY_F20              = 0x83,  // F20 key
			KEY_F21              = 0x84,  // F21 key
			KEY_F22              = 0x85,  // F22 key
			KEY_F23              = 0x86,  // F23 key
			KEY_F24              = 0x87,  // F24 key
			KEY_NUMLOCK          = 0x90,  // NUM LOCK key
			KEY_SCROLL           = 0x91,  // SCROLL LOCK key
			KEY_LSHIFT           = 0xA0,  // Left SHIFT key
			KEY_RSHIFT           = 0xA1,  // Right SHIFT key
			KEY_LCONTROL         = 0xA2,  // Left CONTROL key
			KEY_RCONTROL         = 0xA3,  // Right CONTROL key
			KEY_LMENU            = 0xA4,  // Left MENU key
			KEY_RMENU            = 0xA5,  // Right MENU key
			KEY_OEM_1            = 0xBA,  // for US    ";:"
			KEY_PLUS             = 0xBB,  // Plus Key   "+"
			KEY_COMMA            = 0xBC,  // Comma Key  ","
			KEY_MINUS            = 0xBD,  // Minus Key  "-"
			KEY_PERIOD           = 0xBE,  // Period Key "."
			KEY_OEM_2            = 0xBF,  // for US    "/?"
			KEY_OEM_3            = 0xC0,  // for US    "`~"
			KEY_OEM_4            = 0xDB,  // for US    "[{"
			KEY_OEM_5            = 0xDC,  // for US    "\|"
			KEY_OEM_6            = 0xDD,  // for US    "]}"
			KEY_OEM_7            = 0xDE,  // for US    "'""
			KEY_OEM_8            = 0xDF,  // None
			KEY_OEM_AX           = 0xE1,  // for Japan "AX"
			KEY_OEM_102          = 0xE2,  // "<>" or "\|"
			KEY_ATTN             = 0xF6,  // Attn key
			KEY_CRSEL            = 0xF7,  // CrSel key
			KEY_EXSEL            = 0xF8,  // ExSel key
			KEY_EREOF            = 0xF9,  // Erase EOF key
			KEY_PLAY             = 0xFA,  // Play key
			KEY_ZOOM             = 0xFB,  // Zoom key
			KEY_PA1              = 0xFD,  // PA1 key
			KEY_OEM_CLEAR        = 0xFE,   // Clear key

			KEY_KEY_CODES_COUNT  = 0xFF // this is not a key, but the amount of keycodes there are.
		}
		
		enum EEVENT_TYPE
		{
			EET_GUI_EVENT = 0,
			EET_MOUSE_INPUT_EVENT,
			EET_KEY_INPUT_EVENT,
			EET_JOYSTICK_INPUT_EVENT,
			EET_LOG_TEXT_EVENT,
			EET_USER_EVENT

		}

		enum EMOUSE_INPUT_EVENT
		{
			EMIE_LMOUSE_PRESSED_DOWN = 0,
			EMIE_RMOUSE_PRESSED_DOWN,
			EMIE_MMOUSE_PRESSED_DOWN,
			EMIE_LMOUSE_LEFT_UP,
			EMIE_RMOUSE_LEFT_UP,
			EMIE_MMOUSE_LEFT_UP,
			EMIE_MOUSE_MOVED,
			EMIE_MOUSE_WHEEL,
			EMIE_LMOUSE_DOUBLE_CLICK,
			EMIE_RMOUSE_DOUBLE_CLICK,
			EMIE_MMOUSE_DOUBLE_CLICK,
			EMIE_LMOUSE_TRIPLE_CLICK,
			EMIE_RMOUSE_TRIPLE_CLICK,
			EMIE_MMOUSE_TRIPLE_CLICK,
			EMIE_COUNT
		}

		enum E_MOUSE_BUTTON_STATE_MASK
		{
			EMBSM_LEFT    = 0x01,
			EMBSM_RIGHT   = 0x02,
			EMBSM_MIDDLE  = 0x04,
			EMBSM_EXTRA1  = 0x08,
			EMBSM_EXTRA2  = 0x10,
			EMBSM_FORCE_32_BIT = 0x7fffffff
		}
		
		struct SEvent
		{
			struct SGUIEvent
			{
				IGUIElement Caller;
				IGUIElement Element;
				EGUI_EVENT_TYPE EventType;
			}
		
			struct SMouseInput
			{
				int X;
				int Y;
				float Wheel;
				bool Shift;
				bool Control;
				uint ButtonStates;
				bool isLeftPressed() const { return 0 != ( ButtonStates & E_MOUSE_BUTTON_STATE_MASK.EMBSM_LEFT ); }
				bool isRightPressed() const { return 0 != ( ButtonStates & E_MOUSE_BUTTON_STATE_MASK.EMBSM_RIGHT ); }
				bool isMiddlePressed() const { return 0 != ( ButtonStates & E_MOUSE_BUTTON_STATE_MASK.EMBSM_MIDDLE ); }
				EMOUSE_INPUT_EVENT Event;
			}
			
			struct SKeyInput
			{
				wchar Char;
				EKEY_CODE Key;
				bool PressedDown;
				bool Shift;
				bool Control;
			}
			
			struct SJoystickEvent
			{
				enum
				{
					NUMBER_OF_BUTTONS = 32,

					AXIS_X = 0,	// e.g. analog stick 1 left to right
					AXIS_Y,		// e.g. analog stick 1 top to bottom
					AXIS_Z,		// e.g. throttle, or analog 2 stick 2 left to right
					AXIS_R,		// e.g. rudder, or analog 2 stick 2 top to bottom
					AXIS_U,
					AXIS_V,
					NUMBER_OF_AXES
				}
				
				uint ButtonStates;
				int Axis[NUMBER_OF_AXES];
				uint POV;
				char Joystick;
				bool IsButtonPressed(uint button) const
				{
					if(button >= cast(uint)NUMBER_OF_BUTTONS)
						return false;

					return (ButtonStates & (1 << button)) ? true : false;
				}
			}


			struct SLogEvent
			{
				const char* Text;
				ELOG_LEVEL Level;
			}
			
			struct SUserEvent
			{
				int UserData1;
				int UserData2;
			}

			EEVENT_TYPE EventType;
			union
			{
				SGUIEvent GUIEvent;
				SMouseInput MouseInput;
				SKeyInput KeyInput;
				SJoystickEvent JoystickEvent;
				SLogEvent LogEvent;
				SUserEvent UserEvent;
			}
		}
		
		interface IEventReceiver {
			void _destructorDoNotUse();
			bool OnEvent(const ref SEvent event);
		}
		//! Information on a joystick, returned from @ref irr::IrrlichtDevice::activateJoysticks()
		struct SJoystickInfo
		{
			//! The ID of the joystick
			/** This is an internal Irrlicht index; it does not map directly
			 * to any particular hardware joystick. It corresponds to the
			 * irr::SJoystickEvent Joystick ID. */
			ubyte Joystick;

			//! The name that the joystick uses to identify itself.
			string Name;

			//! The number of buttons that the joystick has.
			uint Buttons;

			//! The number of axes that the joystick has, i.e. X, Y, Z, R, U, V.
			/** Note: with a Linux device, the POV hat (if any) will use two axes. These
			 *  will be included in this count. */
			uint Axes;

			//! An indication of whether the joystick has a POV hat.
			/** A Windows device will identify the presence or absence or the POV hat.  A
			 *  Linux device cannot, and will always return POV_HAT_UNKNOWN. */
			enum PovHat
			{
				//! A hat is definitely present.
				POV_HAT_PRESENT,

				//! A hat is definitely not present.
				POV_HAT_ABSENT,

				//! The presence or absence of a hat cannot be determined.
				POV_HAT_UNKNOWN
			}
		}

		interface ILogger {
			//! Destructor
			void _destructorDoNotUse();

			ELOG_LEVEL getLogLevel() const;
			void setLogLevel(ELOG_LEVEL ll);
			void log(const char* text, ELOG_LEVEL ll=ELOG_LEVEL.ELL_INFORMATION);
			void log(const char* text, const char* hint, ELOG_LEVEL ll=ELOG_LEVEL.ELL_INFORMATION);
			void log(const char* text, const wchar* hint, ELOG_LEVEL ll=ELOG_LEVEL.ELL_INFORMATION);
			void log(const wchar* text, const wchar* hint, ELOG_LEVEL ll=ELOG_LEVEL.ELL_INFORMATION);
			void log(const wchar* text, ELOG_LEVEL ll=ELOG_LEVEL.ELL_INFORMATION);
		}

		interface IOSOperator {
			const string getOperatingSystemVersion() const;
			const wchar* getOperationSystemVersion() const;
			void copyToClipboard(const char* text) const;
			const char* getTextFromClipboard() const;
			bool getProcessorSpeedMHz(uint* MHz) const;
			bool getSystemMemory(uint* Total, uint* Avail) const;
		}

		interface ITimer {
			uint getRealTime() const;

			enum EWeekday
			{
				EWD_SUNDAY=0,
				EWD_MONDAY,
				EWD_TUESDAY,
				EWD_WEDNESDAY,
				EWD_THURSDAY,
				EWD_FRIDAY,
				EWD_SATURDAY
			}

			struct RealTimeDate
			{
				// Hour of the day, from 0 to 23
				uint Hour;
				// Minute of the hour, from 0 to 59
				uint Minute;
				// Second of the minute, due to extra seconds from 0 to 61
				uint Second;
				// Year of the gregorian calender
				int Year;
				// Month of the year, from 1 to 12
				uint Month;
				// Day of the month, from 1 to 31
				uint Day;
				// Weekday for the current day
				EWeekday Weekday;
				// Day of the year, from 1 to 366
				uint Yearday;
				// Whether daylight saving is on
				bool IsDST;
			}

			RealTimeDate getRealTimeAndDate() const;
			uint getTime() const;
			void setTime(uint time);
			void stop();
			void start();
			void setSpeed(float speed = 1.0f);
			float getSpeed() const;
			bool isStopped() const;
			void tick();
		}

		interface IRandomizer {
			void reset(int value=0x0f0f0f0f);
			int rand() const;
			float frand() const;
			int randMax() const;
		}
		
		interface IrrlichtDevice {
			bool run();
			void yield();
			void sleep(uint timeMs, bool pauseTimer=false);
			IVideoDriver getVideoDriver();
			IFileSystem getFileSystem();
			IGUIEnvironment getGUIEnvironment();
			ISceneManager getSceneManager();
			ICursorControl getCursorControl();
			ILogger getLogger();
			IVideoModeList getVideoModeList();
			IOSOperator getOSOperator();
			ITimer getTimer();
			IRandomizer getRandomizer() const;
			void setRandomizer(IRandomizer r);
			IRandomizer createDefaultRandomizer() const;
			void setWindowCaption(const dchar* text);
			bool isWindowActive() const;
			bool isWindowFocused() const;
			bool isWindowMinimized() const;
			bool isFullscreen() const;
			ECOLOR_FORMAT getColorFormat() const;
			void closeDevice();
			const char* getVersion() const;
			void setEventReceiver(IEventReceiver receiver);
			IEventReceiver* getEventReceiver();
			bool postEventFromUser(const ref SEvent event);
			void setInputReceivingSceneManager(ISceneManager sceneManager);
			void setResizable(bool resize=false);
			void setWindowSize(const ref dimension2du size);
			void minimizeWindow();
			void maximizeWindow();
			void restoreWindow();
			position2di getWindowPosition();
			bool activateJoysticks(ref array!SJoystickInfo joystickInfo);
			bool setGammaRamp(float red, float green, float blue,
						float relativebrightness, float relativecontrast);
			bool getGammaRamp(ref float red, ref float green, ref float blue,
						ref float brightness, ref float contrast);
			void setDoubleClickTime(uint timeMs);
			uint getDoubleClickTime() const;
			void clearSystemMessages();
			E_DEVICE_TYPE getType() const;
			static bool isDriverSupported(E_DRIVER_TYPE driver);
		}
	}
	
	IrrlichtDevice createDev(E_DRIVER_TYPE driverType);
}
