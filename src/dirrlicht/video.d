module dirrlicht.video;

import dirrlicht.io;
import dirrlicht.core;
import dirrlicht.scene;

extern(C++) {
	extern(C++, irr) {
		
		extern(C++, video) {
			struct SMaterial {
			}
			
			struct SColor {
				uint a, r, g, b;
			}

			struct SColorf {
			}

			// forward declarations for internal pointers
			interface IDirect3D9 {}
			interface IDirect3DDevice9 {}
			interface IDirect3D8 {}
			interface IDirect3DDevice8 {}

			//! structure for holding data describing a driver and operating system specific data.
			/** This data can be retrived by IVideoDriver.getExposedVideoData(). Use this with caution.
			This only should be used to make it possible to extend the engine easily without
			modification of its source. Note that this structure does not contain any valid data, if
			you are using the software or the null device.
			*/
			struct SExposedVideoData
			{
				this(void* Window) 
				{
					OpenGLWin32.HDc  = null; 
					OpenGLWin32.HRc  = null; 
					OpenGLWin32.HWnd = Window;
				}

				union
				{
					struct HolderD3D9
					{
						//! Pointer to the IDirect3D9 interface
						IDirect3D9 D3D9 = null;

						//! Pointer to the IDirect3DDevice9 interface
						IDirect3DDevice9 D3DDev9 = null;

						//! Window handle.
						/** Get with for example HWND h = reinterpret_cast<HWND>(exposedData.D3D9.HWnd) */
						void* HWnd = null;

					}
					HolderD3D9 D3D9;

					struct HolderD3D8
					{
						//! Pointer to the IDirect3D8 interface
						IDirect3D8 D3D8 = null;

						//! Pointer to the IDirect3DDevice8 interface
						IDirect3DDevice8 D3DDev8 = null;

						//! Window handle.
						/** Get with for example with: HWND h = reinterpret_cast<HWND>(exposedData.D3D8.HWnd) */
						void* HWnd = null;

					} 
					HolderD3D8 D3D8;

					struct HolderOpenGLWin32
					{
						//! Private GDI Device Context.
						/** Get if for example with: HDC h = reinterpret_cast<HDC>(exposedData.OpenGLWin32.HDc) */
						void* HDc = null;

						//! Permanent Rendering Context.
						/** Get if for example with: HGLRC h = reinterpret_cast<HGLRC>(exposedData.OpenGLWin32.HRc) */
						void* HRc = null;

						//! Window handle.
						/** Get with for example with: HWND h = reinterpret_cast<HWND>(exposedData.OpenGLWin32.HWnd) */
						void* HWnd = null;
					} 
					HolderOpenGLWin32 OpenGLWin32;

					struct HolderOpenGLLinux
					{
						// XWindow handles
						void* X11Display = null;
						void* X11Context = null;
						ulong X11Window;
					} 
					HolderOpenGLLinux OpenGLLinux;
				}
			}

			//! enumeration for geometry transformation states
			enum E_TRANSFORMATION_STATE
			{
				ETS_VIEW = 0,
				ETS_WORLD,
				ETS_PROJECTION,
				ETS_TEXTURE_0,
				ETS_TEXTURE_1,
				ETS_TEXTURE_2,
				ETS_TEXTURE_3,
				ETS_TEXTURE_4,
				ETS_TEXTURE_5,
				ETS_TEXTURE_6,
				ETS_TEXTURE_7,
				ETS_COUNT
			}

			
			//! Enumeration flags telling the video driver in which format textures should be created.
			enum E_TEXTURE_CREATION_FLAG
			{
				/** Forces the driver to create 16 bit textures always, independent of
				which format the file on disk has. When choosing this you may lose
				some color detail, but gain much speed and memory. 16 bit textures can
				be transferred twice as fast as 32 bit textures and only use half of
				the space in memory.
				When using this flag, it does not make sense to use the flags
				ETCF_ALWAYS_32_BIT, ETCF_OPTIMIZED_FOR_QUALITY, or
				ETCF_OPTIMIZED_FOR_SPEED at the same time. */
				ETCF_ALWAYS_16_BIT = 0x00000001,

				/** Forces the driver to create 32 bit textures always, independent of
				which format the file on disk has. Please note that some drivers (like
				the software device) will ignore this, because they are only able to
				create and use 16 bit textures.
				When using this flag, it does not make sense to use the flags
				ETCF_ALWAYS_16_BIT, ETCF_OPTIMIZED_FOR_QUALITY, or
				ETCF_OPTIMIZED_FOR_SPEED at the same time. */
				ETCF_ALWAYS_32_BIT = 0x00000002,

				/** Lets the driver decide in which format the textures are created and
				tries to make the textures look as good as possible. Usually it simply
				chooses the format in which the texture was stored on disk.
				When using this flag, it does not make sense to use the flags
				ETCF_ALWAYS_16_BIT, ETCF_ALWAYS_32_BIT, or ETCF_OPTIMIZED_FOR_SPEED at
				the same time. */
				ETCF_OPTIMIZED_FOR_QUALITY = 0x00000004,

				/** Lets the driver decide in which format the textures are created and
				tries to create them maximizing render speed.
				When using this flag, it does not make sense to use the flags
				ETCF_ALWAYS_16_BIT, ETCF_ALWAYS_32_BIT, or ETCF_OPTIMIZED_FOR_QUALITY,
				at the same time. */
				ETCF_OPTIMIZED_FOR_SPEED = 0x00000008,

				/** Automatically creates mip map levels for the textures. */
				ETCF_CREATE_MIP_MAPS = 0x00000010,

				/** Discard any alpha layer and use non-alpha color format. */
				ETCF_NO_ALPHA_CHANNEL = 0x00000020,

				//! Allow the Driver to use Non-Power-2-Textures
				/** BurningVideo can handle Non-Power-2 Textures in 2D (GUI), but not in 3D. */
				ETCF_ALLOW_NON_POWER_2 = 0x00000040,

				/** This flag is never used, it only forces the compiler to compile
				these enumeration values to 32 bit. */
				ETCF_FORCE_32_BIT_DO_NOT_USE = 0x7fffffff
			}

			//! Enum for the mode for texture locking. Read-Only, write-only or read/write.
			enum E_TEXTURE_LOCK_MODE
			{
				//! The default mode. Texture can be read and written to.
				ETLM_READ_WRITE = 0,

				//! Read only. The texture is downloaded, but not uploaded again.
				/** Often used to read back shader generated textures. */
				ETLM_READ_ONLY,

				//! Write only. The texture is not downloaded and might be uninitialised.
				/** The updated texture is uploaded to the GPU.
				Used for initialising the shader from the CPU. */
				ETLM_WRITE_ONLY
			}

			//! Where did the last IVideoDriver::getTexture call find this texture
			enum E_TEXTURE_SOURCE
			{
				//! IVideoDriver::getTexture was never called (texture created otherwise)
				ETS_UNKNOWN,

				//! Texture has been found in cache
				ETS_FROM_CACHE,

				//! Texture had to be loaded
				ETS_FROM_FILE
			}

			interface ITexture {
			}

			interface IImage {
			}

			interface IImageLoader {
			}

			interface IImageWriter {
			}

			interface IRenderTarget {
			}
			
			//! enumeration for querying features of the video driver.
			enum E_VIDEO_DRIVER_FEATURE
			{
				//! Is driver able to render to a surface?
				EVDF_RENDER_TO_TARGET = 0,

				//! Is hardeware transform and lighting supported?
				EVDF_HARDWARE_TL,

				//! Are multiple textures per material possible?
				EVDF_MULTITEXTURE,

				//! Is driver able to render with a bilinear filter applied?
				EVDF_BILINEAR_FILTER,

				//! Can the driver handle mip maps?
				EVDF_MIP_MAP,

				//! Can the driver update mip maps automatically?
				EVDF_MIP_MAP_AUTO_UPDATE,

				//! Are stencilbuffers switched on and does the device support stencil buffers?
				EVDF_STENCIL_BUFFER,

				//! Is Vertex Shader 1.1 supported?
				EVDF_VERTEX_SHADER_1_1,

				//! Is Vertex Shader 2.0 supported?
				EVDF_VERTEX_SHADER_2_0,

				//! Is Vertex Shader 3.0 supported?
				EVDF_VERTEX_SHADER_3_0,

				//! Is Pixel Shader 1.1 supported?
				EVDF_PIXEL_SHADER_1_1,

				//! Is Pixel Shader 1.2 supported?
				EVDF_PIXEL_SHADER_1_2,

				//! Is Pixel Shader 1.3 supported?
				EVDF_PIXEL_SHADER_1_3,

				//! Is Pixel Shader 1.4 supported?
				EVDF_PIXEL_SHADER_1_4,

				//! Is Pixel Shader 2.0 supported?
				EVDF_PIXEL_SHADER_2_0,

				//! Is Pixel Shader 3.0 supported?
				EVDF_PIXEL_SHADER_3_0,

				//! Are ARB vertex programs v1.0 supported?
				EVDF_ARB_VERTEX_PROGRAM_1,

				//! Are ARB fragment programs v1.0 supported?
				EVDF_ARB_FRAGMENT_PROGRAM_1,

				//! Is GLSL supported?
				EVDF_ARB_GLSL,

				//! Is HLSL supported?
				EVDF_HLSL,

				//! Are non-square textures supported?
				EVDF_TEXTURE_NSQUARE,

				//! Are non-power-of-two textures supported?
				EVDF_TEXTURE_NPOT,

				//! Are framebuffer objects supported?
				EVDF_FRAMEBUFFER_OBJECT,

				//! Are vertex buffer objects supported?
				EVDF_VERTEX_BUFFER_OBJECT,

				//! Supports Alpha To Coverage
				EVDF_ALPHA_TO_COVERAGE,

				//! Supports Color masks (disabling color planes in output)
				EVDF_COLOR_MASK,

				//! Supports multiple render targets at once
				EVDF_MULTIPLE_RENDER_TARGETS,

				//! Supports separate blend settings for multiple render targets
				EVDF_MRT_BLEND,

				//! Supports separate color masks for multiple render targets
				EVDF_MRT_COLOR_MASK,

				//! Supports separate blend functions for multiple render targets
				EVDF_MRT_BLEND_FUNC,

				//! Supports geometry shaders
				EVDF_GEOMETRY_SHADER,

				//! Supports occlusion queries
				EVDF_OCCLUSION_QUERY,

				//! Supports polygon offset/depth bias for avoiding z-fighting
				EVDF_POLYGON_OFFSET,

				//! Support for different blend functions. Without, only ADD is available
				EVDF_BLEND_OPERATIONS,

				//! Support for separate blending for RGB and Alpha.
				EVDF_BLEND_SEPARATE,

				//! Support for texture coord transformation via texture matrix
				EVDF_TEXTURE_MATRIX,

				//! Support for DXTn compressed textures.
				EVDF_TEXTURE_COMPRESSED_DXT,

				//! Only used for counting the elements of this enum
				EVDF_COUNT
			}

			enum E_INDEX_TYPE
			{
				EIT_16BIT = 0,
				EIT_32BIT
			}

			//! Enumeration for all vertex types there are.
			enum E_VERTEX_TYPE
			{
				//! Standard vertex type used by the Irrlicht engine, video::S3DVertex.
				EVT_STANDARD = 0,

				//! Vertex with two texture coordinates, video::S3DVertex2TCoords.
				/** Usually used for geometry with lightmaps or other special materials. */
				EVT_2TCOORDS,

				//! Vertex with a tangent and binormal vector, video::S3DVertexTangents.
				/** Usually used for tangent space normal mapping. */
				EVT_TANGENTS
			}
			
			struct S3DVertex {
			}

			struct S3DVertexTangents {
			}

			struct S3DVertex2TCoords {
			}

			//! Special render targets, which usually map to dedicated hardware
			/** These render targets (besides 0 and 1) need not be supported by gfx cards */
			enum E_RENDER_TARGET
			{
				//! Render target is the main color frame buffer
				ERT_FRAME_BUFFER=0,
				//! Render target is a render texture
				ERT_RENDER_TEXTURE,
				//! Multi-Render target textures
				ERT_MULTI_RENDER_TEXTURES,
				//! Render target is the main color frame buffer
				ERT_STEREO_LEFT_BUFFER,
				//! Render target is the right color buffer (left is the main buffer)
				ERT_STEREO_RIGHT_BUFFER,
				//! Render to both stereo buffers at once
				ERT_STEREO_BOTH_BUFFERS,
				//! Auxiliary buffer 0
				ERT_AUX_BUFFER0,
				//! Auxiliary buffer 1
				ERT_AUX_BUFFER1,
				//! Auxiliary buffer 2
				ERT_AUX_BUFFER2,
				//! Auxiliary buffer 3
				ERT_AUX_BUFFER3,
				//! Auxiliary buffer 4
				ERT_AUX_BUFFER4
			}

			//! Enum for the types of fog distributions to choose from
			enum E_FOG_TYPE
			{
				EFT_FOG_EXP=0,
				EFT_FOG_LINEAR,
				EFT_FOG_EXP2
			}
	
			interface IMaterialRenderer {
			}

			struct SLight {
			}

			interface IGPUProgrammingServices {
			}

			struct SOverrideMaterial {
			}
			
			interface IVideoDriver {
				bool beginScene(bool backBuffer=true, bool zBuffer=true,
						SColor color=SColor(255,0,0,0),
						const SExposedVideoData videoData=SExposedVideoData(),
						recti* sourceRect=null);
				
				  bool endScene();
				  bool queryFeature(E_VIDEO_DRIVER_FEATURE feature) const;
				  void disableFeature(E_VIDEO_DRIVER_FEATURE feature, bool flag=true);
				  const ref IAttributes getDriverAttributes() const;
				  bool checkDriverReset();
				  void setTransform(E_TRANSFORMATION_STATE state, const ref matrix4 mat);
				  const ref matrix4 getTransform(E_TRANSFORMATION_STATE state) const;
				  uint getImageLoaderCount() const;
				  IImageLoader getImageLoader(uint n);
				  uint getImageWriterCount() const;
				  IImageWriter getImageWriter(uint n);
				  void setMaterial(const ref SMaterial material);
				  ITexture getTexture(const ref path filename);
				  ITexture getTexture(IReadFile file);
				  ITexture getTextureByIndex(uint index);
				  uint getTextureCount() const;
				
				  void renameTexture(ITexture texture, const ref path newName);

				  ITexture addTexture(const ref dimension2du size,
					const ref path name, ECOLOR_FORMAT format = ECOLOR_FORMAT.ECF_A8R8G8B8);
				
				  ITexture addTexture(const ref path name, IImage image, void* mipmapData=null);
				
				  ITexture addRenderTargetTexture(const ref dimension2du size,
						const path name = "rt", const ECOLOR_FORMAT format = ECOLOR_FORMAT.ECF_UNKNOWN);
				
				  void removeTexture(ITexture texture);
				
				  void removeAllTextures();
				  void removeHardwareBuffer(const IMeshBuffer* mb);
				  void removeAllHardwareBuffers();
				  void addOcclusionQuery(ISceneNode* node,
						const IMesh* mesh=null);
				
				  void removeOcclusionQuery(ISceneNode* node);
			
				  void removeAllOcclusionQueries();
				
				  void runOcclusionQuery(ISceneNode* node, bool visible=false);
				
				  void runAllOcclusionQueries(bool visible=false);
				
				  void updateOcclusionQuery(ISceneNode* node, bool block=true);
				  void updateAllOcclusionQueries(bool block=true);
			
				  uint getOcclusionQueryResult(ISceneNode* node) const;
				  void makeColorKeyTexture(ITexture texture,
								SColor color,
								bool zeroTexels = false) const;
			
				  void makeColorKeyTexture(ITexture texture,
						position2di colorKeyPixelPos,
						bool zeroTexels = false) const;

				  void makeNormalMapTexture(ITexture texture, float amplitude=1.0f) const;
				  bool setRenderTarget(ITexture texture,
					bool clearBackBuffer=true, bool clearZBuffer=true,
					SColor color=SColor(0,0,0,0));
				
				  bool setRenderTarget(E_RENDER_TARGET target, bool clearTarget=true,
							bool clearZBuffer=true,
							SColor color=SColor(0,0,0,0));
				  bool setRenderTarget(const ref array!IRenderTarget texture,
					bool clearBackBuffer=true, bool clearZBuffer=true,
					SColor color=SColor(0,0,0,0));
				
				  void setViewPort(const ref recti area);

				  const ref recti getViewPort() const;
				
				  void drawVertexPrimitiveList(const void* vertices, uint vertexCount,
						const void* indexList, uint primCount,
						E_VERTEX_TYPE vType=E_VERTEX_TYPE.EVT_STANDARD,
						E_PRIMITIVE_TYPE pType=E_PRIMITIVE_TYPE.EPT_TRIANGLES,
						E_INDEX_TYPE iType=E_INDEX_TYPE.EIT_16BIT);

				  void draw2DVertexPrimitiveList(const void* vertices, uint vertexCount,
						const void* indexList, uint primCount,
						E_VERTEX_TYPE vType=E_VERTEX_TYPE.EVT_STANDARD,
						E_PRIMITIVE_TYPE pType=E_PRIMITIVE_TYPE.EPT_TRIANGLES,
						E_INDEX_TYPE iType=E_INDEX_TYPE.EIT_16BIT);

				final void drawIndexedTriangleList(const S3DVertex* vertices,
					uint vertexCount, const ushort* indexList, uint triangleCount)
				{
					drawVertexPrimitiveList(vertices, vertexCount, indexList, triangleCount, E_VERTEX_TYPE.EVT_STANDARD, E_PRIMITIVE_TYPE.EPT_TRIANGLES, E_INDEX_TYPE.EIT_16BIT);
				}

				
				final void drawIndexedTriangleList(const S3DVertex2TCoords* vertices,
					uint vertexCount, const ushort* indexList, uint triangleCount)
				{
					drawVertexPrimitiveList(vertices, vertexCount, indexList, triangleCount, E_VERTEX_TYPE.EVT_2TCOORDS, E_PRIMITIVE_TYPE.EPT_TRIANGLES, E_INDEX_TYPE.EIT_16BIT);
				}
			
				final void drawIndexedTriangleList(const S3DVertexTangents* vertices,
					uint vertexCount, const ushort* indexList, uint triangleCount)
				{
					drawVertexPrimitiveList(vertices, vertexCount, indexList, triangleCount, E_VERTEX_TYPE.EVT_TANGENTS, E_PRIMITIVE_TYPE.EPT_TRIANGLES, E_INDEX_TYPE.EIT_16BIT);
				}
			
				final void drawIndexedTriangleFan(const S3DVertex* vertices,
					uint vertexCount, const ushort* indexList, uint triangleCount)
				{
					drawVertexPrimitiveList(vertices, vertexCount, indexList, triangleCount, E_VERTEX_TYPE.EVT_STANDARD, E_PRIMITIVE_TYPE.EPT_TRIANGLE_FAN, E_INDEX_TYPE.EIT_16BIT);
				}
				
				final void drawIndexedTriangleFan(const S3DVertex2TCoords* vertices,
					uint vertexCount, const ushort* indexList, uint triangleCount)
				{
					drawVertexPrimitiveList(vertices, vertexCount, indexList, triangleCount, E_VERTEX_TYPE.EVT_2TCOORDS, E_PRIMITIVE_TYPE.EPT_TRIANGLE_FAN, E_INDEX_TYPE.EIT_16BIT);
				}

				final void drawIndexedTriangleFan(const S3DVertexTangents* vertices,
					uint vertexCount, const ushort* indexList, uint triangleCount)
				{
					drawVertexPrimitiveList(vertices, vertexCount, indexList, triangleCount, E_VERTEX_TYPE.EVT_TANGENTS, E_PRIMITIVE_TYPE.EPT_TRIANGLE_FAN, E_INDEX_TYPE.EIT_16BIT);
				}
				  void draw3DLine(const ref vector3df start,
					const ref vector3df end, SColor color = SColor(255,255,255,255));

				  void draw3DTriangle(const ref triangle3df triangle,
					SColor color = SColor(255,255,255,255));

				  void draw3DBox(const ref aabbox3df box,
					SColor color = SColor(255,255,255,255));
				  void draw2DImage(const ITexture texture,
					const ref position2di destPos);

				  void draw2DImage(const ITexture texture, const ref position2di destPos,
					const ref recti sourceRect, const recti* clipRect =null,
					SColor color=SColor(255,255,255,255), bool useAlphaChannelOfTexture=false);

				  void draw2DImageBatch(const ITexture texture,
						const ref position2di pos,
						const ref array!recti sourceRects,
						const ref array!int indices,
						int kerningWidth=0,
						const recti* clipRect=null,
						SColor color=SColor(255,255,255,255),
						bool useAlphaChannelOfTexture=false);

				  void draw2DImageBatch(const ITexture texture,
						const ref array!position2di positions,
						const ref array!recti sourceRects,
						const recti* clipRect=null,
						SColor color=SColor(255,255,255,255),
						bool useAlphaChannelOfTexture=false);
				  void draw2DImage(const ITexture texture, const ref recti destRect,
					const ref recti sourceRect, const recti* clipRect =null,
					const SColor* colors=new SColor(0,0,0,0), bool useAlphaChannelOfTexture=false);
				  void draw2DRectangle(SColor color, const ref recti pos,
					const recti* clip =null);
				  void draw2DRectangle(const ref recti pos,
						SColor colorLeftUp, SColor colorRightUp,
						SColor colorLeftDown, SColor colorRightDown,
						const recti* clip =null);
				  void draw2DRectangleOutline(const ref recti pos,
						SColor color=SColor(255,255,255,255));
				  void draw2DLine(const ref position2di start,
							const ref position2di end,
							SColor color=SColor(255,255,255,255));
				  void drawPixel(uint x, uint y, const ref SColor color);
				  void draw2DPolygon(position2di center,
						float radius,
						SColor color=SColor(100,255,255,255),
						int vertexCount=10);
				  void drawStencilShadowVolume(const ref array!vector3df triangles, bool zfail=true, uint debugDataVisible=0);
				  void drawStencilShadow(bool clearStencilBuffer=false,
					SColor leftUpEdge = SColor(255,0,0,0),
					SColor rightUpEdge = SColor(255,0,0,0),
					SColor leftDownEdge = SColor(255,0,0,0),
					SColor rightDownEdge = SColor(255,0,0,0));
				  void drawMeshBuffer(const IMeshBuffer* mb);
				  void drawMeshBufferNormals(const IMeshBuffer* mb, float length=10.0f, SColor color=SColor(0xffffffff));
				  void setFog(SColor color=SColor(0,255,255,255),
						E_FOG_TYPE fogType=E_FOG_TYPE.EFT_FOG_LINEAR,
						float start=50.0f, float end=100.0f, float density=0.01f,
						bool pixelFog=false, bool rangeFog=false);
				  void getFog(ref SColor color, ref E_FOG_TYPE fogType,
						ref float start, ref float end, ref float density,
						ref bool pixelFog, ref bool rangeFog);
				  ECOLOR_FORMAT getColorFormat() const;
				  const ref dimension2du getScreenSize() const;
				  const ref dimension2du getCurrentRenderTargetSize() const;
				  int getFPS() const;
				  uint getPrimitiveCountDrawn( uint mode =0 ) const;
				  int addDynamicLight(const ref SLight light);
				  uint getMaximalDynamicLightAmount() const;
				  uint getDynamicLightCount() const;
				  const ref SLight getDynamicLight(uint idx) const;
				  void turnLightOn(int lightIndex, bool turnOn);
				  const wchar* getName() const;
				  void addExternalImageLoader(IImageLoader* loader);
				  void addExternalImageWriter(IImageWriter* writer);
				  uint getMaximalPrimitiveCount() const;
				  void setTextureCreationFlag(E_TEXTURE_CREATION_FLAG flag, bool enabled=true);
				  bool getTextureCreationFlag(E_TEXTURE_CREATION_FLAG flag) const;
				  IImage createImageFromFile(const ref path filename);
				  IImage createImageFromFile(IReadFile file);
				  bool writeImageToFile(IImage image, const ref path filename, uint param = 0);
				  bool writeImageToFile(IImage image, IWriteFile* file, uint param =0);
				  IImage createImageFromData(ECOLOR_FORMAT format,
					const ref dimension2du size, void *data,
					bool ownForeignMemory=false,
					bool deleteMemory = true);
				  IImage createImage(ECOLOR_FORMAT format, const ref dimension2du size);

				IImage createImage(ECOLOR_FORMAT format, IImage *imageToCopy);
				   IImage createImage(IImage imageToCopy,
						const ref position2di pos,
						const ref dimension2du size);
				  IImage createImage(ITexture texture,
						const ref position2di pos,
						const ref dimension2du size);
				  void OnResize(const ref dimension2du size);
				  int addMaterialRenderer(IMaterialRenderer renderer, const char* name =null);
				  IMaterialRenderer getMaterialRenderer(uint idx);
				  uint getMaterialRendererCount() const;
				  const char* getMaterialRendererName(uint idx) const;
				  void setMaterialRendererName(int idx, const char* name);
				  IAttributes* createAttributesFromMaterial(const ref SMaterial material,
					SAttributeReadWriteOptions* options=null);
				  void fillMaterialStructureFromAttributes(ref SMaterial outMaterial, IAttributes* attributes);
				  const ref SExposedVideoData getExposedVideoData();
				  E_DRIVER_TYPE getDriverType() const;
				  IGPUProgrammingServices* getGPUProgrammingServices();
				  IMeshManipulator* getMeshManipulator();
				  void clearZBuffer();
				  IImage createScreenShot(ECOLOR_FORMAT format=ECOLOR_FORMAT.ECF_UNKNOWN, E_RENDER_TARGET target=E_RENDER_TARGET.ERT_FRAME_BUFFER);
				  ITexture findTexture(const ref path filename);
				bool setClipPlane(uint index, const ref plane3df plane, bool enable=false);
				void enableClipPlane(uint index, bool enable);
				void setMinHardwareBufferVertexCount(uint count);
				ref SOverrideMaterial getOverrideMaterial();
				ref SMaterial getMaterial2D();
				void enableMaterial2D(bool enable=true);
				stringc getVendorInfo();
				void setAmbientLight(const ref SColorf color);
				void setAllowZWriteOnTransparent(bool flag);
				dimension2du getMaxTextureSize() const;
				void convertColor(const void* sP, ECOLOR_FORMAT sF, int sN,
						void* dP, ECOLOR_FORMAT dF) const;
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
