(* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
        .
     .--:         :
    ----        :---:
  .-----         .-.
 .------          .
 -------.
.--------               :
.---------             .:.
 ----------:            .
 :-----------:
  --------------:.         .:.
   :------------------------
    .---------------------.
       :---------------:.
          ..:::::::..
              ...
     _
    | |    _  _  _ _   __ _
    | |__ | || || ' \ / _` |
    |____| \_,_||_||_|\__,_|
         Game Toolkit™

Copyright © 2022-present tinyBigGAMES™ LLC
         All Rights Reserved.

Website: https://tinybiggames.com
Email  : support@tinybiggames.com

See LICENSE for license information
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *)

unit LGT.Deps;

{$I LGT.Defines.inc}

interface

uses
  WinApi.Windows;

const
  GLFW_EXPOSE_NATIVE_WIN32 = 1;
  NK_INCLUDE_FIXED_TYPES = 1;
  NK_INCLUDE_STANDARD_IO = 1;
  NK_INCLUDE_STANDARD_VARARGS = 1;
  NK_INCLUDE_DEFAULT_ALLOCATOR = 1;
  NK_INCLUDE_VERTEX_BUFFER_OUTPUT = 1;
  NK_INCLUDE_FONT_BAKING = 1;
  NK_INCLUDE_DEFAULT_FONT = 1;
  NK_KEYSTATE_BASED_INPUT = 1;
  GLFW_VERSION_MAJOR = 3;
  GLFW_VERSION_MINOR = 4;
  GLFW_VERSION_REVISION = 0;
  GLFW_TRUE = 1;
  GLFW_FALSE = 0;
  GLFW_RELEASE = 0;
  GLFW_PRESS = 1;
  GLFW_REPEAT = 2;
  GLFW_HAT_CENTERED = 0;
  GLFW_HAT_UP = 1;
  GLFW_HAT_RIGHT = 2;
  GLFW_HAT_DOWN = 4;
  GLFW_HAT_LEFT = 8;
  GLFW_HAT_RIGHT_UP = (GLFW_HAT_RIGHT or GLFW_HAT_UP);
  GLFW_HAT_RIGHT_DOWN = (GLFW_HAT_RIGHT or GLFW_HAT_DOWN);
  GLFW_HAT_LEFT_UP = (GLFW_HAT_LEFT or GLFW_HAT_UP);
  GLFW_HAT_LEFT_DOWN = (GLFW_HAT_LEFT or GLFW_HAT_DOWN);
  GLFW_KEY_UNKNOWN = -1;
  GLFW_KEY_SPACE = 32;
  GLFW_KEY_APOSTROPHE = 39;
  GLFW_KEY_COMMA = 44;
  GLFW_KEY_MINUS = 45;
  GLFW_KEY_PERIOD = 46;
  GLFW_KEY_SLASH = 47;
  GLFW_KEY_0 = 48;
  GLFW_KEY_1 = 49;
  GLFW_KEY_2 = 50;
  GLFW_KEY_3 = 51;
  GLFW_KEY_4 = 52;
  GLFW_KEY_5 = 53;
  GLFW_KEY_6 = 54;
  GLFW_KEY_7 = 55;
  GLFW_KEY_8 = 56;
  GLFW_KEY_9 = 57;
  GLFW_KEY_SEMICOLON = 59;
  GLFW_KEY_EQUAL = 61;
  GLFW_KEY_A = 65;
  GLFW_KEY_B = 66;
  GLFW_KEY_C = 67;
  GLFW_KEY_D = 68;
  GLFW_KEY_E = 69;
  GLFW_KEY_F = 70;
  GLFW_KEY_G = 71;
  GLFW_KEY_H = 72;
  GLFW_KEY_I = 73;
  GLFW_KEY_J = 74;
  GLFW_KEY_K = 75;
  GLFW_KEY_L = 76;
  GLFW_KEY_M = 77;
  GLFW_KEY_N = 78;
  GLFW_KEY_O = 79;
  GLFW_KEY_P = 80;
  GLFW_KEY_Q = 81;
  GLFW_KEY_R = 82;
  GLFW_KEY_S = 83;
  GLFW_KEY_T = 84;
  GLFW_KEY_U = 85;
  GLFW_KEY_V = 86;
  GLFW_KEY_W = 87;
  GLFW_KEY_X = 88;
  GLFW_KEY_Y = 89;
  GLFW_KEY_Z = 90;
  GLFW_KEY_LEFT_BRACKET = 91;
  GLFW_KEY_BACKSLASH = 92;
  GLFW_KEY_RIGHT_BRACKET = 93;
  GLFW_KEY_GRAVE_ACCENT = 96;
  GLFW_KEY_WORLD_1 = 161;
  GLFW_KEY_WORLD_2 = 162;
  GLFW_KEY_ESCAPE = 256;
  GLFW_KEY_ENTER = 257;
  GLFW_KEY_TAB = 258;
  GLFW_KEY_BACKSPACE = 259;
  GLFW_KEY_INSERT = 260;
  GLFW_KEY_DELETE = 261;
  GLFW_KEY_RIGHT = 262;
  GLFW_KEY_LEFT = 263;
  GLFW_KEY_DOWN = 264;
  GLFW_KEY_UP = 265;
  GLFW_KEY_PAGE_UP = 266;
  GLFW_KEY_PAGE_DOWN = 267;
  GLFW_KEY_HOME = 268;
  GLFW_KEY_END = 269;
  GLFW_KEY_CAPS_LOCK = 280;
  GLFW_KEY_SCROLL_LOCK = 281;
  GLFW_KEY_NUM_LOCK = 282;
  GLFW_KEY_PRINT_SCREEN = 283;
  GLFW_KEY_PAUSE = 284;
  GLFW_KEY_F1 = 290;
  GLFW_KEY_F2 = 291;
  GLFW_KEY_F3 = 292;
  GLFW_KEY_F4 = 293;
  GLFW_KEY_F5 = 294;
  GLFW_KEY_F6 = 295;
  GLFW_KEY_F7 = 296;
  GLFW_KEY_F8 = 297;
  GLFW_KEY_F9 = 298;
  GLFW_KEY_F10 = 299;
  GLFW_KEY_F11 = 300;
  GLFW_KEY_F12 = 301;
  GLFW_KEY_F13 = 302;
  GLFW_KEY_F14 = 303;
  GLFW_KEY_F15 = 304;
  GLFW_KEY_F16 = 305;
  GLFW_KEY_F17 = 306;
  GLFW_KEY_F18 = 307;
  GLFW_KEY_F19 = 308;
  GLFW_KEY_F20 = 309;
  GLFW_KEY_F21 = 310;
  GLFW_KEY_F22 = 311;
  GLFW_KEY_F23 = 312;
  GLFW_KEY_F24 = 313;
  GLFW_KEY_F25 = 314;
  GLFW_KEY_KP_0 = 320;
  GLFW_KEY_KP_1 = 321;
  GLFW_KEY_KP_2 = 322;
  GLFW_KEY_KP_3 = 323;
  GLFW_KEY_KP_4 = 324;
  GLFW_KEY_KP_5 = 325;
  GLFW_KEY_KP_6 = 326;
  GLFW_KEY_KP_7 = 327;
  GLFW_KEY_KP_8 = 328;
  GLFW_KEY_KP_9 = 329;
  GLFW_KEY_KP_DECIMAL = 330;
  GLFW_KEY_KP_DIVIDE = 331;
  GLFW_KEY_KP_MULTIPLY = 332;
  GLFW_KEY_KP_SUBTRACT = 333;
  GLFW_KEY_KP_ADD = 334;
  GLFW_KEY_KP_ENTER = 335;
  GLFW_KEY_KP_EQUAL = 336;
  GLFW_KEY_LEFT_SHIFT = 340;
  GLFW_KEY_LEFT_CONTROL = 341;
  GLFW_KEY_LEFT_ALT = 342;
  GLFW_KEY_LEFT_SUPER = 343;
  GLFW_KEY_RIGHT_SHIFT = 344;
  GLFW_KEY_RIGHT_CONTROL = 345;
  GLFW_KEY_RIGHT_ALT = 346;
  GLFW_KEY_RIGHT_SUPER = 347;
  GLFW_KEY_MENU = 348;
  GLFW_KEY_LAST = GLFW_KEY_MENU;
  GLFW_MOD_SHIFT = $0001;
  GLFW_MOD_CONTROL = $0002;
  GLFW_MOD_ALT = $0004;
  GLFW_MOD_SUPER = $0008;
  GLFW_MOD_CAPS_LOCK = $0010;
  GLFW_MOD_NUM_LOCK = $0020;
  GLFW_MOUSE_BUTTON_1 = 0;
  GLFW_MOUSE_BUTTON_2 = 1;
  GLFW_MOUSE_BUTTON_3 = 2;
  GLFW_MOUSE_BUTTON_4 = 3;
  GLFW_MOUSE_BUTTON_5 = 4;
  GLFW_MOUSE_BUTTON_6 = 5;
  GLFW_MOUSE_BUTTON_7 = 6;
  GLFW_MOUSE_BUTTON_8 = 7;
  GLFW_MOUSE_BUTTON_LAST = GLFW_MOUSE_BUTTON_8;
  GLFW_MOUSE_BUTTON_LEFT = GLFW_MOUSE_BUTTON_1;
  GLFW_MOUSE_BUTTON_RIGHT = GLFW_MOUSE_BUTTON_2;
  GLFW_MOUSE_BUTTON_MIDDLE = GLFW_MOUSE_BUTTON_3;
  GLFW_JOYSTICK_1 = 0;
  GLFW_JOYSTICK_2 = 1;
  GLFW_JOYSTICK_3 = 2;
  GLFW_JOYSTICK_4 = 3;
  GLFW_JOYSTICK_5 = 4;
  GLFW_JOYSTICK_6 = 5;
  GLFW_JOYSTICK_7 = 6;
  GLFW_JOYSTICK_8 = 7;
  GLFW_JOYSTICK_9 = 8;
  GLFW_JOYSTICK_10 = 9;
  GLFW_JOYSTICK_11 = 10;
  GLFW_JOYSTICK_12 = 11;
  GLFW_JOYSTICK_13 = 12;
  GLFW_JOYSTICK_14 = 13;
  GLFW_JOYSTICK_15 = 14;
  GLFW_JOYSTICK_16 = 15;
  GLFW_JOYSTICK_LAST = GLFW_JOYSTICK_16;
  GLFW_GAMEPAD_BUTTON_A = 0;
  GLFW_GAMEPAD_BUTTON_B = 1;
  GLFW_GAMEPAD_BUTTON_X = 2;
  GLFW_GAMEPAD_BUTTON_Y = 3;
  GLFW_GAMEPAD_BUTTON_LEFT_BUMPER = 4;
  GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER = 5;
  GLFW_GAMEPAD_BUTTON_BACK = 6;
  GLFW_GAMEPAD_BUTTON_START = 7;
  GLFW_GAMEPAD_BUTTON_GUIDE = 8;
  GLFW_GAMEPAD_BUTTON_LEFT_THUMB = 9;
  GLFW_GAMEPAD_BUTTON_RIGHT_THUMB = 10;
  GLFW_GAMEPAD_BUTTON_DPAD_UP = 11;
  GLFW_GAMEPAD_BUTTON_DPAD_RIGHT = 12;
  GLFW_GAMEPAD_BUTTON_DPAD_DOWN = 13;
  GLFW_GAMEPAD_BUTTON_DPAD_LEFT = 14;
  GLFW_GAMEPAD_BUTTON_LAST = GLFW_GAMEPAD_BUTTON_DPAD_LEFT;
  GLFW_GAMEPAD_BUTTON_CROSS = GLFW_GAMEPAD_BUTTON_A;
  GLFW_GAMEPAD_BUTTON_CIRCLE = GLFW_GAMEPAD_BUTTON_B;
  GLFW_GAMEPAD_BUTTON_SQUARE = GLFW_GAMEPAD_BUTTON_X;
  GLFW_GAMEPAD_BUTTON_TRIANGLE = GLFW_GAMEPAD_BUTTON_Y;
  GLFW_GAMEPAD_AXIS_LEFT_X = 0;
  GLFW_GAMEPAD_AXIS_LEFT_Y = 1;
  GLFW_GAMEPAD_AXIS_RIGHT_X = 2;
  GLFW_GAMEPAD_AXIS_RIGHT_Y = 3;
  GLFW_GAMEPAD_AXIS_LEFT_TRIGGER = 4;
  GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER = 5;
  GLFW_GAMEPAD_AXIS_LAST = GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER;
  GLFW_NO_ERROR = 0;
  GLFW_NOT_INITIALIZED = $00010001;
  GLFW_NO_CURRENT_CONTEXT = $00010002;
  GLFW_INVALID_ENUM = $00010003;
  GLFW_INVALID_VALUE = $00010004;
  GLFW_OUT_OF_MEMORY = $00010005;
  GLFW_API_UNAVAILABLE = $00010006;
  GLFW_VERSION_UNAVAILABLE = $00010007;
  GLFW_PLATFORM_ERROR = $00010008;
  GLFW_FORMAT_UNAVAILABLE = $00010009;
  GLFW_NO_WINDOW_CONTEXT = $0001000A;
  GLFW_CURSOR_UNAVAILABLE = $0001000B;
  GLFW_FEATURE_UNAVAILABLE = $0001000C;
  GLFW_FEATURE_UNIMPLEMENTED = $0001000D;
  GLFW_PLATFORM_UNAVAILABLE = $0001000E;
  GLFW_FOCUSED = $00020001;
  GLFW_ICONIFIED = $00020002;
  GLFW_RESIZABLE = $00020003;
  GLFW_VISIBLE = $00020004;
  GLFW_DECORATED = $00020005;
  GLFW_AUTO_ICONIFY = $00020006;
  GLFW_FLOATING = $00020007;
  GLFW_MAXIMIZED = $00020008;
  GLFW_CENTER_CURSOR = $00020009;
  GLFW_TRANSPARENT_FRAMEBUFFER = $0002000A;
  GLFW_HOVERED = $0002000B;
  GLFW_FOCUS_ON_SHOW = $0002000C;
  GLFW_MOUSE_PASSTHROUGH = $0002000D;
  GLFW_POSITION_X = $0002000E;
  GLFW_POSITION_Y = $0002000F;
  GLFW_RED_BITS = $00021001;
  GLFW_GREEN_BITS = $00021002;
  GLFW_BLUE_BITS = $00021003;
  GLFW_ALPHA_BITS = $00021004;
  GLFW_DEPTH_BITS = $00021005;
  GLFW_STENCIL_BITS = $00021006;
  GLFW_ACCUM_RED_BITS = $00021007;
  GLFW_ACCUM_GREEN_BITS = $00021008;
  GLFW_ACCUM_BLUE_BITS = $00021009;
  GLFW_ACCUM_ALPHA_BITS = $0002100A;
  GLFW_AUX_BUFFERS = $0002100B;
  GLFW_STEREO = $0002100C;
  GLFW_SAMPLES = $0002100D;
  GLFW_SRGB_CAPABLE = $0002100E;
  GLFW_REFRESH_RATE = $0002100F;
  GLFW_DOUBLEBUFFER = $00021010;
  GLFW_CLIENT_API = $00022001;
  GLFW_CONTEXT_VERSION_MAJOR = $00022002;
  GLFW_CONTEXT_VERSION_MINOR = $00022003;
  GLFW_CONTEXT_REVISION = $00022004;
  GLFW_CONTEXT_ROBUSTNESS = $00022005;
  GLFW_OPENGL_FORWARD_COMPAT = $00022006;
  GLFW_CONTEXT_DEBUG = $00022007;
  GLFW_OPENGL_DEBUG_CONTEXT = GLFW_CONTEXT_DEBUG;
  GLFW_OPENGL_PROFILE = $00022008;
  GLFW_CONTEXT_RELEASE_BEHAVIOR = $00022009;
  GLFW_CONTEXT_NO_ERROR = $0002200A;
  GLFW_CONTEXT_CREATION_API = $0002200B;
  GLFW_SCALE_TO_MONITOR = $0002200C;
  GLFW_COCOA_RETINA_FRAMEBUFFER = $00023001;
  GLFW_COCOA_FRAME_NAME = $00023002;
  GLFW_COCOA_GRAPHICS_SWITCHING = $00023003;
  GLFW_X11_CLASS_NAME = $00024001;
  GLFW_X11_INSTANCE_NAME = $00024002;
  GLFW_WIN32_KEYBOARD_MENU = $00025001;
  GLFW_WAYLAND_APP_ID = $00026001;
  GLFW_NO_API = 0;
  GLFW_OPENGL_API = $00030001;
  GLFW_OPENGL_ES_API = $00030002;
  GLFW_NO_ROBUSTNESS = 0;
  GLFW_NO_RESET_NOTIFICATION = $00031001;
  GLFW_LOSE_CONTEXT_ON_RESET = $00031002;
  GLFW_OPENGL_ANY_PROFILE = 0;
  GLFW_OPENGL_CORE_PROFILE = $00032001;
  GLFW_OPENGL_COMPAT_PROFILE = $00032002;
  GLFW_CURSOR = $00033001;
  GLFW_STICKY_KEYS = $00033002;
  GLFW_STICKY_MOUSE_BUTTONS = $00033003;
  GLFW_LOCK_KEY_MODS = $00033004;
  GLFW_RAW_MOUSE_MOTION = $00033005;
  GLFW_CURSOR_NORMAL = $00034001;
  GLFW_CURSOR_HIDDEN = $00034002;
  GLFW_CURSOR_DISABLED = $00034003;
  GLFW_CURSOR_CAPTURED = $00034004;
  GLFW_ANY_RELEASE_BEHAVIOR = 0;
  GLFW_RELEASE_BEHAVIOR_FLUSH = $00035001;
  GLFW_RELEASE_BEHAVIOR_NONE = $00035002;
  GLFW_NATIVE_CONTEXT_API = $00036001;
  GLFW_EGL_CONTEXT_API = $00036002;
  GLFW_OSMESA_CONTEXT_API = $00036003;
  GLFW_ANGLE_PLATFORM_TYPE_NONE = $00037001;
  GLFW_ANGLE_PLATFORM_TYPE_OPENGL = $00037002;
  GLFW_ANGLE_PLATFORM_TYPE_OPENGLES = $00037003;
  GLFW_ANGLE_PLATFORM_TYPE_D3D9 = $00037004;
  GLFW_ANGLE_PLATFORM_TYPE_D3D11 = $00037005;
  GLFW_ANGLE_PLATFORM_TYPE_VULKAN = $00037007;
  GLFW_ANGLE_PLATFORM_TYPE_METAL = $00037008;
  GLFW_WAYLAND_PREFER_LIBDECOR = $00038001;
  GLFW_WAYLAND_DISABLE_LIBDECOR = $00038002;
  GLFW_ANY_POSITION = $80000000;
  GLFW_ARROW_CURSOR = $00036001;
  GLFW_IBEAM_CURSOR = $00036002;
  GLFW_CROSSHAIR_CURSOR = $00036003;
  GLFW_POINTING_HAND_CURSOR = $00036004;
  GLFW_RESIZE_EW_CURSOR = $00036005;
  GLFW_RESIZE_NS_CURSOR = $00036006;
  GLFW_RESIZE_NWSE_CURSOR = $00036007;
  GLFW_RESIZE_NESW_CURSOR = $00036008;
  GLFW_RESIZE_ALL_CURSOR = $00036009;
  GLFW_NOT_ALLOWED_CURSOR = $0003600A;
  GLFW_HRESIZE_CURSOR = GLFW_RESIZE_EW_CURSOR;
  GLFW_VRESIZE_CURSOR = GLFW_RESIZE_NS_CURSOR;
  GLFW_HAND_CURSOR = GLFW_POINTING_HAND_CURSOR;
  GLFW_CONNECTED = $00040001;
  GLFW_DISCONNECTED = $00040002;
  GLFW_JOYSTICK_HAT_BUTTONS = $00050001;
  GLFW_ANGLE_PLATFORM_TYPE = $00050002;
  GLFW_PLATFORM = $00050003;
  GLFW_COCOA_CHDIR_RESOURCES = $00051001;
  GLFW_COCOA_MENUBAR = $00051002;
  GLFW_X11_XCB_VULKAN_SURFACE = $00052001;
  GLFW_WAYLAND_LIBDECOR = $00053001;
  GLFW_ANY_PLATFORM = $00060000;
  GLFW_PLATFORM_WIN32 = $00060001;
  GLFW_PLATFORM_COCOA = $00060002;
  GLFW_PLATFORM_WAYLAND = $00060003;
  GLFW_PLATFORM_X11 = $00060004;
  GLFW_PLATFORM_NULL = $00060005;
  GLFW_DONT_CARE = -1;
  AL_INVALID = (-1);
  AL_INVALID_ENUM = $A002;
  AL_ILLEGAL_ENUM = AL_INVALID_ENUM;
  AL_INVALID_OPERATION = $A004;
  AL_ILLEGAL_COMMAND = AL_INVALID_OPERATION;
  AL_NONE = 0;
  AL_FALSE = 0;
  AL_TRUE = 1;
  AL_SOURCE_RELATIVE = $202;
  AL_CONE_INNER_ANGLE = $1001;
  AL_CONE_OUTER_ANGLE = $1002;
  AL_PITCH = $1003;
  AL_POSITION = $1004;
  AL_DIRECTION = $1005;
  AL_VELOCITY = $1006;
  AL_LOOPING = $1007;
  AL_BUFFER = $1009;
  AL_GAIN = $100A;
  AL_MIN_GAIN = $100D;
  AL_MAX_GAIN = $100E;
  AL_ORIENTATION = $100F;
  AL_SOURCE_STATE = $1010;
  AL_INITIAL = $1011;
  AL_PLAYING = $1012;
  AL_PAUSED = $1013;
  AL_STOPPED = $1014;
  AL_BUFFERS_QUEUED = $1015;
  AL_BUFFERS_PROCESSED = $1016;
  AL_REFERENCE_DISTANCE = $1020;
  AL_ROLLOFF_FACTOR = $1021;
  AL_CONE_OUTER_GAIN = $1022;
  AL_MAX_DISTANCE = $1023;
  AL_SEC_OFFSET = $1024;
  AL_SAMPLE_OFFSET = $1025;
  AL_BYTE_OFFSET = $1026;
  AL_SOURCE_TYPE = $1027;
  AL_STATIC = $1028;
  AL_STREAMING = $1029;
  AL_UNDETERMINED = $1030;
  AL_FORMAT_MONO8 = $1100;
  AL_FORMAT_MONO16 = $1101;
  AL_FORMAT_STEREO8 = $1102;
  AL_FORMAT_STEREO16 = $1103;
  AL_FREQUENCY = $2001;
  AL_BITS = $2002;
  AL_CHANNELS = $2003;
  AL_SIZE = $2004;
  AL_UNUSED = $2010;
  AL_PENDING = $2011;
  AL_PROCESSED = $2012;
  AL_NO_ERROR = 0;
  AL_INVALID_NAME = $A001;
  AL_INVALID_VALUE = $A003;
  AL_OUT_OF_MEMORY = $A005;
  AL_VENDOR = $B001;
  AL_VERSION = $B002;
  AL_RENDERER = $B003;
  AL_EXTENSIONS = $B004;
  AL_DOPPLER_FACTOR = $C000;
  AL_DOPPLER_VELOCITY = $C001;
  AL_SPEED_OF_SOUND = $C003;
  AL_DISTANCE_MODEL = $D000;
  AL_INVERSE_DISTANCE = $D001;
  AL_INVERSE_DISTANCE_CLAMPED = $D002;
  AL_LINEAR_DISTANCE = $D003;
  AL_LINEAR_DISTANCE_CLAMPED = $D004;
  AL_EXPONENT_DISTANCE = $D005;
  AL_EXPONENT_DISTANCE_CLAMPED = $D006;
  ALC_INVALID = 0;
  ALC_VERSION_0_1 = 1;
  ALC_FALSE = 0;
  ALC_TRUE = 1;
  ALC_FREQUENCY = $1007;
  ALC_REFRESH = $1008;
  ALC_SYNC = $1009;
  ALC_MONO_SOURCES = $1010;
  ALC_STEREO_SOURCES = $1011;
  ALC_NO_ERROR = 0;
  ALC_INVALID_DEVICE = $A001;
  ALC_INVALID_CONTEXT = $A002;
  ALC_INVALID_ENUM = $A003;
  ALC_INVALID_VALUE = $A004;
  ALC_OUT_OF_MEMORY = $A005;
  ALC_MAJOR_VERSION = $1000;
  ALC_MINOR_VERSION = $1001;
  ALC_ATTRIBUTES_SIZE = $1002;
  ALC_ALL_ATTRIBUTES = $1003;
  ALC_DEFAULT_DEVICE_SPECIFIER = $1004;
  ALC_DEVICE_SPECIFIER = $1005;
  ALC_EXTENSIONS = $1006;
  ALC_EXT_CAPTURE = 1;
  ALC_CAPTURE_DEVICE_SPECIFIER = $310;
  ALC_CAPTURE_DEFAULT_DEVICE_SPECIFIER = $311;
  ALC_CAPTURE_SAMPLES = $312;
  ALC_ENUMERATE_ALL_EXT = 1;
  ALC_DEFAULT_ALL_DEVICES_SPECIFIER = $1012;
  ALC_ALL_DEVICES_SPECIFIER = $1013;
  NOTOPEN = 0;
  PARTOPEN = 1;
  OPENED = 2;
  STREAMSET = 3;
  INITSET = 4;
  Z_ERRNO = -1;
  Z_OK = 0;
  Z_DEFLATED = 8;
  Z_DEFAULT_STRATEGY = 0;
  ZIP_OK = (0);
  ZIP_EOF = (0);
  ZIP_ERRNO = (Z_ERRNO);
  ZIP_PARAMERROR = (-102);
  ZIP_BADZIPFILE = (-103);
  ZIP_INTERNALERROR = (-104);
  UNZ_OK = (0);
  UNZ_END_OF_LIST_OF_FILE = (-100);
  UNZ_ERRNO = (Z_ERRNO);
  UNZ_EOF = (0);
  UNZ_PARAMERROR = (-102);
  UNZ_BADZIPFILE = (-103);
  UNZ_INTERNALERROR = (-104);
  UNZ_CRCERROR = (-105);
  APPEND_STATUS_CREATE = (0);
  APPEND_STATUS_CREATEAFTER = (1);
  APPEND_STATUS_ADDINZIP = (2);
  C2_MAX_POLYGON_VERTS = 8;
  PLM_PACKET_INVALID_TS = -1;
  PLM_AUDIO_SAMPLES_PER_FRAME = 1152;
  PLM_BUFFER_DEFAULT_SIZE = (128*1024);
  STBI_VERSION = 1;
  STBTT_MACSTYLE_DONTCARE = 0;
  STBTT_MACSTYLE_BOLD = 1;
  STBTT_MACSTYLE_ITALIC = 2;
  STBTT_MACSTYLE_UNDERSCORE = 4;
  STBTT_MACSTYLE_NONE = 8;
  CLOG_MAX_LOGGERS = 16;
  CLOG_FORMAT_LENGTH = 256;
  CLOG_DATETIME_LENGTH = 256;
  CLOG_DEFAULT_FORMAT = '%d %t %f(%n): %l: %m'#10;
  CLOG_DEFAULT_DATE_FORMAT = '%Y-%m-%d';
  CLOG_DEFAULT_TIME_FORMAT = '%H:%M:%S';
  NK_UNDEFINED = (-1.0);
  NK_UTF_INVALID = $FFFD;
  NK_UTF_SIZE = 4;
  NK_INPUT_MAX = 16;
  NK_MAX_NUMBER_BUFFER = 64;
  NK_SCROLLBAR_HIDING_TIMEOUT = 4.0;
  NK_TEXTEDIT_UNDOSTATECOUNT = 99;
  NK_TEXTEDIT_UNDOCHARCOUNT = 999;
  NK_MAX_LAYOUT_ROW_TEMPLATE_COLUMNS = 16;
  NK_CHART_MAX_SLOT = 4;
  NK_WINDOW_MAX_NAME = 64;
  NK_BUTTON_BEHAVIOR_STACK_SIZE = 8;
  NK_FONT_STACK_SIZE = 8;
  NK_STYLE_ITEM_STACK_SIZE = 16;
  NK_FLOAT_STACK_SIZE = 32;
  NK_VECTOR_STACK_SIZE = 16;
  NK_FLAGS_STACK_SIZE = 32;
  NK_COLOR_STACK_SIZE = 32;
  NK_PI = 3.141592654;
  NK_MAX_FLOAT_PRECISION = 2;
  LUA_LDIR = '!\lua\';
  LUA_CDIR = '!\';
  LUA_PATH_DEFAULT = '.\?.lua;' + LUA_LDIR + '?.lua;' + LUA_LDIR + '?\init.lua;';
  LUA_CPATH_DEFAULT = '.\?.dll;' + LUA_CDIR + '?.dll;' + LUA_CDIR + 'loadall.dll';
  LUA_PATH = 'LUA_PATH';
  LUA_CPATH = 'LUA_CPATH';
  LUA_INIT = 'LUA_INIT';
  LUA_DIRSEP = '\';
  LUA_PATHSEP = ';';
  LUA_PATH_MARK = '?';
  LUA_EXECDIR = '!';
  LUA_IGMARK = '-';
  LUA_PATH_CONFIG = LUA_DIRSEP + #10 + LUA_PATHSEP + #10 + LUA_PATH_MARK + #10 + LUA_EXECDIR + #10 + LUA_IGMARK + #10;
  LUAI_MAXSTACK = 65500;
  LUAI_MAXCSTACK = 8000;
  LUAI_GCPAUSE = 200;
  LUAI_GCMUL = 200;
  LUA_MAXCAPTURES = 32;
  LUA_IDSIZE = 60;
  BUFSIZ = 512;
  LUA_NUMBER_SCAN = '%lf';
  LUA_NUMBER_FMT = '%.14g';
  LUAI_MAXNUMBER2STR = 32;
  LUA_INTFRMLEN = 'l';
  LUA_VERSION_ = 'Lua 5.1';
  LUA_RELEASE = 'Lua 5.1.4';
  LUA_VERSION_NUM = 501;
  LUA_COPYRIGHT = 'Copyright (C) 1994-2008 Lua.org, PUC-Rio';
  LUA_AUTHORS = 'R. Ierusalimschy, L. H. de Figueiredo & W. Celes';
  LUA_SIGNATURE = #27'Lua';
  LUA_MULTRET = (-1);
  LUA_REGISTRYINDEX = (-10000);
  LUA_ENVIRONINDEX = (-10001);
  LUA_GLOBALSINDEX = (-10002);
  LUA_OK = 0;
  LUA_YIELD_ = 1;
  LUA_ERRRUN = 2;
  LUA_ERRSYNTAX = 3;
  LUA_ERRMEM = 4;
  LUA_ERRERR = 5;
  LUA_TNONE = (-1);
  LUA_TNIL = 0;
  LUA_TBOOLEAN = 1;
  LUA_TLIGHTUSERDATA = 2;
  LUA_TNUMBER = 3;
  LUA_TSTRING = 4;
  LUA_TTABLE = 5;
  LUA_TFUNCTION = 6;
  LUA_TUSERDATA = 7;
  LUA_TTHREAD = 8;
  LUA_MINSTACK = 20;
  LUA_GCSTOP = 0;
  LUA_GCRESTART = 1;
  LUA_GCCOLLECT = 2;
  LUA_GCCOUNT = 3;
  LUA_GCCOUNTB = 4;
  LUA_GCSTEP = 5;
  LUA_GCSETPAUSE = 6;
  LUA_GCSETSTEPMUL = 7;
  LUA_GCISRUNNING = 9;
  LUA_HOOKCALL = 0;
  LUA_HOOKRET = 1;
  LUA_HOOKLINE = 2;
  LUA_HOOKCOUNT = 3;
  LUA_HOOKTAILRET = 4;
  LUA_MASKCALL = (1 shl LUA_HOOKCALL);
  LUA_MASKRET = (1 shl LUA_HOOKRET);
  LUA_MASKLINE = (1 shl LUA_HOOKLINE);
  LUA_MASKCOUNT = (1 shl LUA_HOOKCOUNT);
  LUA_FILEHANDLE = 'FILE*';
  LUA_COLIBNAME = 'coroutine';
  LUA_MATHLIBNAME = 'math';
  LUA_STRLIBNAME = 'string';
  LUA_TABLIBNAME = 'table';
  LUA_IOLIBNAME = 'io';
  LUA_OSLIBNAME = 'os';
  LUA_LOADLIBNAME = 'package';
  LUA_DBLIBNAME = 'debug';
  LUA_BITLIBNAME = 'bit';
  LUA_JITLIBNAME = 'jit';
  LUA_FFILIBNAME = 'ffi';
  LUA_ERRFILE = (LUA_ERRERR+1);
  LUA_NOREF = (-2);
  LUA_REFNIL = (-1);
  LUAJIT_VERSION = 'LuaJIT 2.1.1697887905';
  LUAJIT_VERSION_NUM = 20199;
  LUAJIT_COPYRIGHT = 'Copyright (C) 2005-2023 Mike Pall';
  LUAJIT_URL = 'https://luajit.org/';
  LUAJIT_MODE_MASK = $00ff;
  LUAJIT_MODE_OFF = $0000;
  LUAJIT_MODE_ON = $0100;
  LUAJIT_MODE_FLUSH = $0200;

type
  C2_TYPE = Integer;
  PC2_TYPE = ^C2_TYPE;

const
  C2_TYPE_CIRCLE = 0;
  C2_TYPE_AABB = 1;
  C2_TYPE_CAPSULE = 2;
  C2_TYPE_POLY = 3;

const
  STBI_default = 0;
  STBI_grey = 1;
  STBI_grey_alpha = 2;
  STBI_rgb = 3;
  STBI_rgb_alpha = 4;

const
  STBTT_vmove = 1;
  STBTT_vline = 2;
  STBTT_vcurve = 3;
  STBTT_vcubic = 4;

const
  STBTT_PLATFORM_ID_UNICODE = 0;
  STBTT_PLATFORM_ID_MAC = 1;
  STBTT_PLATFORM_ID_ISO = 2;
  STBTT_PLATFORM_ID_MICROSOFT = 3;

const
  STBTT_UNICODE_EID_UNICODE_1_0 = 0;
  STBTT_UNICODE_EID_UNICODE_1_1 = 1;
  STBTT_UNICODE_EID_ISO_10646 = 2;
  STBTT_UNICODE_EID_UNICODE_2_0_BMP = 3;
  STBTT_UNICODE_EID_UNICODE_2_0_FULL = 4;

const
  STBTT_MS_EID_SYMBOL = 0;
  STBTT_MS_EID_UNICODE_BMP = 1;
  STBTT_MS_EID_SHIFTJIS = 2;
  STBTT_MS_EID_UNICODE_FULL = 10;

const
  STBTT_MAC_EID_ROMAN = 0;
  STBTT_MAC_EID_ARABIC = 4;
  STBTT_MAC_EID_JAPANESE = 1;
  STBTT_MAC_EID_HEBREW = 5;
  STBTT_MAC_EID_CHINESE_TRAD = 2;
  STBTT_MAC_EID_GREEK = 6;
  STBTT_MAC_EID_KOREAN = 3;
  STBTT_MAC_EID_RUSSIAN = 7;

const
  STBTT_MS_LANG_ENGLISH = 1033;
  STBTT_MS_LANG_ITALIAN = 1040;
  STBTT_MS_LANG_CHINESE = 2052;
  STBTT_MS_LANG_JAPANESE = 1041;
  STBTT_MS_LANG_DUTCH = 1043;
  STBTT_MS_LANG_KOREAN = 1042;
  STBTT_MS_LANG_FRENCH = 1036;
  STBTT_MS_LANG_RUSSIAN = 1049;
  STBTT_MS_LANG_GERMAN = 1031;
  STBTT_MS_LANG_SPANISH = 1033;
  STBTT_MS_LANG_HEBREW = 1037;
  STBTT_MS_LANG_SWEDISH = 1053;

const
  STBTT_MAC_LANG_ENGLISH = 0;
  STBTT_MAC_LANG_JAPANESE = 11;
  STBTT_MAC_LANG_ARABIC = 12;
  STBTT_MAC_LANG_KOREAN = 23;
  STBTT_MAC_LANG_DUTCH = 4;
  STBTT_MAC_LANG_RUSSIAN = 32;
  STBTT_MAC_LANG_FRENCH = 1;
  STBTT_MAC_LANG_SPANISH = 6;
  STBTT_MAC_LANG_GERMAN = 2;
  STBTT_MAC_LANG_SWEDISH = 5;
  STBTT_MAC_LANG_HEBREW = 10;
  STBTT_MAC_LANG_CHINESE_SIMPLIFIED = 33;
  STBTT_MAC_LANG_ITALIAN = 3;
  STBTT_MAC_LANG_CHINESE_TRAD = 19;

type
  clog_level = Integer;
  Pclog_level = ^clog_level;

const
  CLOG_DEBUG_ = 0;
  CLOG_INFO_ = 1;
  CLOG_WARN_ = 2;
  CLOG_ERROR_ = 3;

const
  nk_false = 0;
  nk_true = 1;

type
  nk_heading = Integer;
  Pnk_heading = ^nk_heading;

const
  NK_UP = 0;
  NK_RIGHT = 1;
  NK_DOWN = 2;
  NK_LEFT = 3;

type
  nk_button_behavior = Integer;
  Pnk_button_behavior = ^nk_button_behavior;

const
  NK_BUTTON_DEFAULT = 0;
  NK_BUTTON_REPEATER = 1;

type
  nk_modify = Integer;
  Pnk_modify = ^nk_modify;

const
  NK_FIXED = 0;
  NK_MODIFIABLE = 1;

type
  nk_orientation = Integer;
  Pnk_orientation = ^nk_orientation;

const
  NK_VERTICAL = 0;
  NK_HORIZONTAL = 1;

type
  nk_collapse_states = Integer;
  Pnk_collapse_states = ^nk_collapse_states;

const
  NK_MINIMIZED = 0;
  NK_MAXIMIZED = 1;

type
  nk_show_states = Integer;
  Pnk_show_states = ^nk_show_states;

const
  NK_HIDDEN = 0;
  NK_SHOWN = 1;

type
  nk_chart_type = Integer;
  Pnk_chart_type = ^nk_chart_type;

const
  NK_CHART_LINES = 0;
  NK_CHART_COLUMN = 1;
  NK_CHART_MAX = 2;

type
  nk_chart_event = Integer;
  Pnk_chart_event = ^nk_chart_event;

const
  NK_CHART_HOVERING = 1;
  NK_CHART_CLICKED = 2;

type
  nk_color_format = Integer;
  Pnk_color_format = ^nk_color_format;

const
  NK_RGB = 0;
  NK_RGBA = 1;

type
  nk_popup_type = Integer;
  Pnk_popup_type = ^nk_popup_type;

const
  NK_POPUP_STATIC = 0;
  NK_POPUP_DYNAMIC = 1;

type
  nk_layout_format = Integer;
  Pnk_layout_format = ^nk_layout_format;

const
  NK_DYNAMIC = 0;
  NK_STATIC = 1;

type
  nk_tree_type = Integer;
  Pnk_tree_type = ^nk_tree_type;

const
  NK_TREE_NODE = 0;
  NK_TREE_TAB = 1;

type
  nk_symbol_type = Integer;
  Pnk_symbol_type = ^nk_symbol_type;

const
  NK_SYMBOL_NONE = 0;
  NK_SYMBOL_X = 1;
  NK_SYMBOL_UNDERSCORE = 2;
  NK_SYMBOL_CIRCLE_SOLID = 3;
  NK_SYMBOL_CIRCLE_OUTLINE = 4;
  NK_SYMBOL_RECT_SOLID = 5;
  NK_SYMBOL_RECT_OUTLINE = 6;
  NK_SYMBOL_TRIANGLE_UP = 7;
  NK_SYMBOL_TRIANGLE_DOWN = 8;
  NK_SYMBOL_TRIANGLE_LEFT = 9;
  NK_SYMBOL_TRIANGLE_RIGHT = 10;
  NK_SYMBOL_PLUS = 11;
  NK_SYMBOL_MINUS = 12;
  NK_SYMBOL_MAX = 13;

type
  nk_keys = Integer;
  Pnk_keys = ^nk_keys;

const
  NK_KEY_NONE = 0;
  NK_KEY_SHIFT = 1;
  NK_KEY_CTRL = 2;
  NK_KEY_DEL = 3;
  NK_KEY_ENTER = 4;
  NK_KEY_TAB = 5;
  NK_KEY_BACKSPACE = 6;
  NK_KEY_COPY = 7;
  NK_KEY_CUT = 8;
  NK_KEY_PASTE = 9;
  NK_KEY_UP = 10;
  NK_KEY_DOWN = 11;
  NK_KEY_LEFT = 12;
  NK_KEY_RIGHT = 13;
  NK_KEY_TEXT_INSERT_MODE = 14;
  NK_KEY_TEXT_REPLACE_MODE = 15;
  NK_KEY_TEXT_RESET_MODE = 16;
  NK_KEY_TEXT_LINE_START = 17;
  NK_KEY_TEXT_LINE_END = 18;
  NK_KEY_TEXT_START = 19;
  NK_KEY_TEXT_END = 20;
  NK_KEY_TEXT_UNDO = 21;
  NK_KEY_TEXT_REDO = 22;
  NK_KEY_TEXT_SELECT_ALL = 23;
  NK_KEY_TEXT_WORD_LEFT = 24;
  NK_KEY_TEXT_WORD_RIGHT = 25;
  NK_KEY_SCROLL_START = 26;
  NK_KEY_SCROLL_END = 27;
  NK_KEY_SCROLL_DOWN = 28;
  NK_KEY_SCROLL_UP = 29;
  NK_KEY_MAX = 30;

type
  nk_buttons = Integer;
  Pnk_buttons = ^nk_buttons;

const
  NK_BUTTON_LEFT = 0;
  NK_BUTTON_MIDDLE = 1;
  NK_BUTTON_RIGHT = 2;
  NK_BUTTON_DOUBLE = 3;
  NK_BUTTON_MAX = 4;

type
  nk_anti_aliasing = Integer;
  Pnk_anti_aliasing = ^nk_anti_aliasing;

const
  NK_ANTI_ALIASING_OFF = 0;
  NK_ANTI_ALIASING_ON = 1;

type
  nk_convert_result = Integer;
  Pnk_convert_result = ^nk_convert_result;

const
  NK_CONVERT_SUCCESS = 0;
  NK_CONVERT_INVALID_PARAM = 1;
  NK_CONVERT_COMMAND_BUFFER_FULL = 2;
  NK_CONVERT_VERTEX_BUFFER_FULL = 4;
  NK_CONVERT_ELEMENT_BUFFER_FULL = 8;

type
  nk_panel_flags = Integer;
  Pnk_panel_flags = ^nk_panel_flags;

const
  NK_WINDOW_BORDER = 1;
  NK_WINDOW_MOVABLE = 2;
  NK_WINDOW_SCALABLE = 4;
  NK_WINDOW_CLOSABLE = 8;
  NK_WINDOW_MINIMIZABLE = 16;
  NK_WINDOW_NO_SCROLLBAR = 32;
  NK_WINDOW_TITLE = 64;
  NK_WINDOW_SCROLL_AUTO_HIDE = 128;
  NK_WINDOW_BACKGROUND = 256;
  NK_WINDOW_SCALE_LEFT = 512;
  NK_WINDOW_NO_INPUT = 1024;

type
  nk_widget_layout_states = Integer;
  Pnk_widget_layout_states = ^nk_widget_layout_states;

const
  NK_WIDGET_INVALID = 0;
  NK_WIDGET_VALID = 1;
  NK_WIDGET_ROM = 2;

type
  nk_widget_states = Integer;
  Pnk_widget_states = ^nk_widget_states;

const
  NK_WIDGET_STATE_MODIFIED = 2;
  NK_WIDGET_STATE_INACTIVE = 4;
  NK_WIDGET_STATE_ENTERED = 8;
  NK_WIDGET_STATE_HOVER = 16;
  NK_WIDGET_STATE_ACTIVED = 32;
  NK_WIDGET_STATE_LEFT = 64;
  NK_WIDGET_STATE_HOVERED = 18;
  NK_WIDGET_STATE_ACTIVE = 34;

type
  nk_text_align = Integer;
  Pnk_text_align = ^nk_text_align;

const
  NK_TEXT_ALIGN_LEFT = 1;
  NK_TEXT_ALIGN_CENTERED = 2;
  NK_TEXT_ALIGN_RIGHT = 4;
  NK_TEXT_ALIGN_TOP = 8;
  NK_TEXT_ALIGN_MIDDLE = 16;
  NK_TEXT_ALIGN_BOTTOM = 32;

type
  nk_text_alignment = Integer;
  Pnk_text_alignment = ^nk_text_alignment;

const
  NK_TEXT_LEFT = 17;
  NK_TEXT_CENTERED = 18;
  NK_TEXT_RIGHT = 20;

type
  nk_edit_flags = Integer;
  Pnk_edit_flags = ^nk_edit_flags;

const
  NK_EDIT_DEFAULT = 0;
  NK_EDIT_READ_ONLY = 1;
  NK_EDIT_AUTO_SELECT = 2;
  NK_EDIT_SIG_ENTER = 4;
  NK_EDIT_ALLOW_TAB = 8;
  NK_EDIT_NO_CURSOR = 16;
  NK_EDIT_SELECTABLE = 32;
  NK_EDIT_CLIPBOARD = 64;
  NK_EDIT_CTRL_ENTER_NEWLINE = 128;
  NK_EDIT_NO_HORIZONTAL_SCROLL = 256;
  NK_EDIT_ALWAYS_INSERT_MODE = 512;
  NK_EDIT_MULTILINE = 1024;
  NK_EDIT_GOTO_END_ON_ACTIVATE = 2048;

type
  nk_edit_types = Integer;
  Pnk_edit_types = ^nk_edit_types;

const
  NK_EDIT_SIMPLE = 512;
  NK_EDIT_FIELD = 608;
  NK_EDIT_BOX = 1640;
  NK_EDIT_EDITOR = 1128;

type
  nk_edit_events = Integer;
  Pnk_edit_events = ^nk_edit_events;

const
  NK_EDIT_ACTIVE = 1;
  NK_EDIT_INACTIVE = 2;
  NK_EDIT_ACTIVATED = 4;
  NK_EDIT_DEACTIVATED = 8;
  NK_EDIT_COMMITED = 16;

type
  nk_style_colors = Integer;
  Pnk_style_colors = ^nk_style_colors;

const
  NK_COLOR_TEXT = 0;
  NK_COLOR_WINDOW = 1;
  NK_COLOR_HEADER = 2;
  NK_COLOR_BORDER = 3;
  NK_COLOR_BUTTON = 4;
  NK_COLOR_BUTTON_HOVER = 5;
  NK_COLOR_BUTTON_ACTIVE = 6;
  NK_COLOR_TOGGLE = 7;
  NK_COLOR_TOGGLE_HOVER = 8;
  NK_COLOR_TOGGLE_CURSOR = 9;
  NK_COLOR_SELECT = 10;
  NK_COLOR_SELECT_ACTIVE = 11;
  NK_COLOR_SLIDER = 12;
  NK_COLOR_SLIDER_CURSOR = 13;
  NK_COLOR_SLIDER_CURSOR_HOVER = 14;
  NK_COLOR_SLIDER_CURSOR_ACTIVE = 15;
  NK_COLOR_PROPERTY = 16;
  NK_COLOR_EDIT = 17;
  NK_COLOR_EDIT_CURSOR = 18;
  NK_COLOR_COMBO = 19;
  NK_COLOR_CHART = 20;
  NK_COLOR_CHART_COLOR = 21;
  NK_COLOR_CHART_COLOR_HIGHLIGHT = 22;
  NK_COLOR_SCROLLBAR = 23;
  NK_COLOR_SCROLLBAR_CURSOR = 24;
  NK_COLOR_SCROLLBAR_CURSOR_HOVER = 25;
  NK_COLOR_SCROLLBAR_CURSOR_ACTIVE = 26;
  NK_COLOR_TAB_HEADER = 27;
  NK_COLOR_COUNT = 28;

type
  nk_style_cursor = Integer;
  Pnk_style_cursor = ^nk_style_cursor;

const
  NK_CURSOR_ARROW = 0;
  NK_CURSOR_TEXT = 1;
  NK_CURSOR_MOVE = 2;
  NK_CURSOR_RESIZE_VERTICAL = 3;
  NK_CURSOR_RESIZE_HORIZONTAL = 4;
  NK_CURSOR_RESIZE_TOP_LEFT_DOWN_RIGHT = 5;
  NK_CURSOR_RESIZE_TOP_RIGHT_DOWN_LEFT = 6;
  NK_CURSOR_COUNT = 7;

type
  nk_font_coord_type = Integer;
  Pnk_font_coord_type = ^nk_font_coord_type;

const
  NK_COORD_UV = 0;
  NK_COORD_PIXEL = 1;

type
  nk_font_atlas_format = Integer;
  Pnk_font_atlas_format = ^nk_font_atlas_format;

const
  NK_FONT_ATLAS_ALPHA8 = 0;
  NK_FONT_ATLAS_RGBA32 = 1;

type
  nk_allocation_type = Integer;
  Pnk_allocation_type = ^nk_allocation_type;

const
  NK_BUFFER_FIXED = 0;
  NK_BUFFER_DYNAMIC = 1;

type
  nk_buffer_allocation_type = Integer;
  Pnk_buffer_allocation_type = ^nk_buffer_allocation_type;

const
  NK_BUFFER_FRONT = 0;
  NK_BUFFER_BACK = 1;
  NK_BUFFER_MAX = 2;

type
  nk_text_edit_type = Integer;
  Pnk_text_edit_type = ^nk_text_edit_type;

const
  NK_TEXT_EDIT_SINGLE_LINE = 0;
  NK_TEXT_EDIT_MULTI_LINE = 1;

type
  nk_text_edit_mode = Integer;
  Pnk_text_edit_mode = ^nk_text_edit_mode;

const
  NK_TEXT_EDIT_MODE_VIEW = 0;
  NK_TEXT_EDIT_MODE_INSERT = 1;
  NK_TEXT_EDIT_MODE_REPLACE = 2;

type
  nk_command_type = Integer;
  Pnk_command_type = ^nk_command_type;

const
  NK_COMMAND_NOP_ = 0;
  NK_COMMAND_SCISSOR_ = 1;
  NK_COMMAND_LINE_ = 2;
  NK_COMMAND_CURVE_ = 3;
  NK_COMMAND_RECT_ = 4;
  NK_COMMAND_RECT_FILLED_ = 5;
  NK_COMMAND_RECT_MULTI_COLOR_ = 6;
  NK_COMMAND_CIRCLE_ = 7;
  NK_COMMAND_CIRCLE_FILLED_ = 8;
  NK_COMMAND_ARC_ = 9;
  NK_COMMAND_ARC_FILLED_ = 10;
  NK_COMMAND_TRIANGLE_ = 11;
  NK_COMMAND_TRIANGLE_FILLED_ = 12;
  NK_COMMAND_POLYGON_ = 13;
  NK_COMMAND_POLYGON_FILLED_ = 14;
  NK_COMMAND_POLYLINE_ = 15;
  NK_COMMAND_TEXT_ = 16;
  NK_COMMAND_IMAGE_ = 17;
  NK_COMMAND_CUSTOM_ = 18;

type
  nk_command_clipping = Integer;
  Pnk_command_clipping = ^nk_command_clipping;

const
  NK_CLIPPING_OFF = 0;
  NK_CLIPPING_ON = 1;

type
  nk_draw_list_stroke = Integer;
  Pnk_draw_list_stroke = ^nk_draw_list_stroke;

const
  NK_STROKE_OPEN = 0;
  NK_STROKE_CLOSED = 1;

type
  nk_draw_vertex_layout_attribute = Integer;
  Pnk_draw_vertex_layout_attribute = ^nk_draw_vertex_layout_attribute;

const
  NK_VERTEX_POSITION = 0;
  NK_VERTEX_COLOR = 1;
  NK_VERTEX_TEXCOORD = 2;
  NK_VERTEX_ATTRIBUTE_COUNT = 3;

type
  nk_draw_vertex_layout_format = Integer;
  Pnk_draw_vertex_layout_format = ^nk_draw_vertex_layout_format;

const
  NK_FORMAT_SCHAR = 0;
  NK_FORMAT_SSHORT = 1;
  NK_FORMAT_SINT = 2;
  NK_FORMAT_UCHAR = 3;
  NK_FORMAT_USHORT = 4;
  NK_FORMAT_UINT = 5;
  NK_FORMAT_FLOAT = 6;
  NK_FORMAT_DOUBLE = 7;
  NK_FORMAT_COLOR_BEGIN = 8;
  NK_FORMAT_R8G8B8 = 8;
  NK_FORMAT_R16G15B16 = 9;
  NK_FORMAT_R32G32B32 = 10;
  NK_FORMAT_R8G8B8A8 = 11;
  NK_FORMAT_B8G8R8A8 = 12;
  NK_FORMAT_R16G15B16A16 = 13;
  NK_FORMAT_R32G32B32A32 = 14;
  NK_FORMAT_R32G32B32A32_FLOAT = 15;
  NK_FORMAT_R32G32B32A32_DOUBLE = 16;
  NK_FORMAT_RGB32 = 17;
  NK_FORMAT_RGBA32 = 18;
  NK_FORMAT_COLOR_END = 18;
  NK_FORMAT_COUNT = 19;

type
  nk_style_item_type = Integer;
  Pnk_style_item_type = ^nk_style_item_type;

const
  NK_STYLE_ITEM_COLOR = 0;
  NK_STYLE_ITEM_IMAGE = 1;
  NK_STYLE_ITEM_NINE_SLICE = 2;

type
  nk_style_header_align = Integer;
  Pnk_style_header_align = ^nk_style_header_align;

const
  NK_HEADER_LEFT = 0;
  NK_HEADER_RIGHT = 1;

type
  nk_panel_type = Integer;
  Pnk_panel_type = ^nk_panel_type;

const
  NK_PANEL_NONE = 0;
  NK_PANEL_WINDOW = 1;
  NK_PANEL_GROUP = 2;
  NK_PANEL_POPUP = 4;
  NK_PANEL_CONTEXTUAL = 16;
  NK_PANEL_COMBO = 32;
  NK_PANEL_MENU = 64;
  NK_PANEL_TOOLTIP = 128;

type
  nk_panel_set = Integer;
  Pnk_panel_set = ^nk_panel_set;

const
  NK_PANEL_SET_NONBLOCK = 240;
  NK_PANEL_SET_POPUP = 244;
  NK_PANEL_SET_SUB = 246;

type
  nk_panel_row_layout_type = Integer;
  Pnk_panel_row_layout_type = ^nk_panel_row_layout_type;

const
  NK_LAYOUT_DYNAMIC_FIXED = 0;
  NK_LAYOUT_DYNAMIC_ROW = 1;
  NK_LAYOUT_DYNAMIC_FREE = 2;
  NK_LAYOUT_DYNAMIC = 3;
  NK_LAYOUT_STATIC_FIXED = 4;
  NK_LAYOUT_STATIC_ROW = 5;
  NK_LAYOUT_STATIC_FREE = 6;
  NK_LAYOUT_STATIC = 7;
  NK_LAYOUT_TEMPLATE = 8;
  NK_LAYOUT_COUNT = 9;

type
  nk_window_flags = Integer;
  Pnk_window_flags = ^nk_window_flags;

const
  NK_WINDOW_PRIVATE = 2048;
  NK_WINDOW_DYNAMIC = 2048;
  NK_WINDOW_ROM = 4096;
  NK_WINDOW_NOT_INTERACTIVE = 5120;
  NK_WINDOW_HIDDEN = 8192;
  NK_WINDOW_CLOSED = 16384;
  NK_WINDOW_MINIMIZED = 32768;
  NK_WINDOW_REMOVE_ROM = 65536;

type
  nk_glfw_init_state = Integer;
  Pnk_glfw_init_state = ^nk_glfw_init_state;

const
  NK_GLFW3_DEFAULT = 0;
  NK_GLFW3_INSTALL_CALLBACKS = 1;

const
  LUAJIT_MODE_ENGINE = 0;
  LUAJIT_MODE_DEBUG = 1;
  LUAJIT_MODE_FUNC = 2;
  LUAJIT_MODE_ALLFUNC = 3;
  LUAJIT_MODE_ALLSUBFUNC = 4;
  LUAJIT_MODE_TRACE = 5;
  LUAJIT_MODE_WRAPCFUNC = 16;
  LUAJIT_MODE_MAX = 17;

type
  PPUTF8Char = ^PUTF8Char;
  PPInteger = ^PInteger;
  PPSingle = ^PSingle;
  PPPSingle = ^PPSingle;
  PUInt8 = ^UInt8;
  PUInt32 = ^UInt32;
  Palloc_chain = Pointer;
  PPalloc_chain = ^Palloc_chain;
  Pnk_style_slide = Pointer;
  PPnk_style_slide = ^Pnk_style_slide;
  PGLFWvidmode = ^GLFWvidmode;
  PGLFWgammaramp = ^GLFWgammaramp;
  PGLFWimage = ^GLFWimage;
  PGLFWgamepadstate = ^GLFWgamepadstate;
  PGLFWallocator = ^GLFWallocator;
  Pogg_sync_state = ^ogg_sync_state;
  Pvorbis_info = ^vorbis_info;
  Pvorbis_comment = ^vorbis_comment;
  Pogg_stream_state = ^ogg_stream_state;
  Pvorbis_dsp_state = ^vorbis_dsp_state;
  Poggpack_buffer = ^oggpack_buffer;
  Pvorbis_block = ^vorbis_block;
  Pov_callbacks = ^ov_callbacks;
  POggVorbis_File = ^OggVorbis_File;
  Ptm_zip_s = ^tm_zip_s;
  Pzip_fileinfo = ^zip_fileinfo;
  Ptm_unz_s = ^tm_unz_s;
  Punz_file_info64_s = ^unz_file_info64_s;
  Pc2v = ^c2v;
  Pc2r = ^c2r;
  Pc2m = ^c2m;
  Pc2x = ^c2x;
  Pc2h = ^c2h;
  Pc2Circle = ^c2Circle;
  Pc2AABB = ^c2AABB;
  Pc2Capsule = ^c2Capsule;
  Pc2Poly = ^c2Poly;
  Pc2Ray = ^c2Ray;
  Pc2Raycast = ^c2Raycast;
  Pc2Manifold = ^c2Manifold;
  Pc2GJKCache = ^c2GJKCache;
  Pc2TOIResult = ^c2TOIResult;
  Pplm_packet_t = ^plm_packet_t;
  Pplm_plane_t = ^plm_plane_t;
  Pplm_frame_t = ^plm_frame_t;
  Pplm_samples_t = ^plm_samples_t;
  Pstbi_io_callbacks = ^stbi_io_callbacks;
  Pstbtt__buf = ^stbtt__buf;
  Pstbtt_bakedchar = ^stbtt_bakedchar;
  Pstbtt_aligned_quad = ^stbtt_aligned_quad;
  Pstbtt_packedchar = ^stbtt_packedchar;
  Pstbtt_pack_range = ^stbtt_pack_range;
  Pstbtt_pack_context = ^stbtt_pack_context;
  Pstbtt_fontinfo = ^stbtt_fontinfo;
  Pstbtt_kerningentry = ^stbtt_kerningentry;
  Pstbtt_vertex = ^stbtt_vertex;
  PPstbtt_vertex = ^Pstbtt_vertex;
  Pstbtt__bitmap = ^stbtt__bitmap;
  Pclog = ^clog;
  Pnk_color = ^nk_color;
  Pnk_colorf = ^nk_colorf;
  Pnk_vec2 = ^nk_vec2;
  Pnk_vec2i = ^nk_vec2i;
  Pnk_rect = ^nk_rect;
  Pnk_recti = ^nk_recti;
  Pnk_image = ^nk_image;
  Pnk_nine_slice = ^nk_nine_slice;
  Pnk_cursor = ^nk_cursor;
  Pnk_scroll = ^nk_scroll;
  Pnk_allocator = ^nk_allocator;
  Pnk_draw_null_texture = ^nk_draw_null_texture;
  Pnk_convert_config = ^nk_convert_config;
  Pnk_list_view = ^nk_list_view;
  Pnk_user_font_glyph = ^nk_user_font_glyph;
  Pnk_user_font = ^nk_user_font;
  PPnk_user_font = ^Pnk_user_font;
  Pnk_baked_font = ^nk_baked_font;
  Pnk_font_config = ^nk_font_config;
  Pnk_font_glyph = ^nk_font_glyph;
  Pnk_font = ^nk_font;
  Pnk_font_atlas = ^nk_font_atlas;
  PPnk_font_atlas = ^Pnk_font_atlas;
  Pnk_memory_status = ^nk_memory_status;
  Pnk_buffer_marker = ^nk_buffer_marker;
  Pnk_memory = ^nk_memory;
  Pnk_buffer = ^nk_buffer;
  Pnk_str = ^nk_str;
  Pnk_clipboard = ^nk_clipboard;
  Pnk_text_undo_record = ^nk_text_undo_record;
  Pnk_text_undo_state = ^nk_text_undo_state;
  Pnk_text_edit = ^nk_text_edit;
  Pnk_command = ^nk_command;
  Pnk_command_scissor = ^nk_command_scissor;
  Pnk_command_line = ^nk_command_line;
  Pnk_command_curve = ^nk_command_curve;
  Pnk_command_rect = ^nk_command_rect;
  Pnk_command_rect_filled = ^nk_command_rect_filled;
  Pnk_command_rect_multi_color = ^nk_command_rect_multi_color;
  Pnk_command_triangle = ^nk_command_triangle;
  Pnk_command_triangle_filled = ^nk_command_triangle_filled;
  Pnk_command_circle = ^nk_command_circle;
  Pnk_command_circle_filled = ^nk_command_circle_filled;
  Pnk_command_arc = ^nk_command_arc;
  Pnk_command_arc_filled = ^nk_command_arc_filled;
  Pnk_command_polygon = ^nk_command_polygon;
  Pnk_command_polygon_filled = ^nk_command_polygon_filled;
  Pnk_command_polyline = ^nk_command_polyline;
  Pnk_command_image = ^nk_command_image;
  Pnk_command_custom = ^nk_command_custom;
  Pnk_command_text = ^nk_command_text;
  Pnk_command_buffer = ^nk_command_buffer;
  Pnk_mouse_button = ^nk_mouse_button;
  Pnk_mouse = ^nk_mouse;
  Pnk_key = ^nk_key;
  Pnk_keyboard = ^nk_keyboard;
  Pnk_input = ^nk_input;
  Pnk_draw_vertex_layout_element = ^nk_draw_vertex_layout_element;
  Pnk_draw_command = ^nk_draw_command;
  Pnk_draw_list = ^nk_draw_list;
  Pnk_style_item = ^nk_style_item;
  Pnk_style_text = ^nk_style_text;
  Pnk_style_button = ^nk_style_button;
  Pnk_style_toggle = ^nk_style_toggle;
  Pnk_style_selectable = ^nk_style_selectable;
  Pnk_style_slider = ^nk_style_slider;
  Pnk_style_progress = ^nk_style_progress;
  Pnk_style_scrollbar = ^nk_style_scrollbar;
  Pnk_style_edit = ^nk_style_edit;
  Pnk_style_property = ^nk_style_property;
  Pnk_style_chart = ^nk_style_chart;
  Pnk_style_combo = ^nk_style_combo;
  Pnk_style_tab = ^nk_style_tab;
  Pnk_style_window_header = ^nk_style_window_header;
  Pnk_style_window = ^nk_style_window;
  Pnk_style = ^nk_style;
  Pnk_chart_slot = ^nk_chart_slot;
  Pnk_chart = ^nk_chart;
  Pnk_row_layout = ^nk_row_layout;
  Pnk_popup_buffer = ^nk_popup_buffer;
  Pnk_menu_state = ^nk_menu_state;
  Pnk_panel = ^nk_panel;
  Pnk_popup_state = ^nk_popup_state;
  Pnk_edit_state = ^nk_edit_state;
  Pnk_property_state = ^nk_property_state;
  Pnk_window = ^nk_window;
  Pnk_config_stack_style_item_element = ^nk_config_stack_style_item_element;
  Pnk_config_stack_float_element = ^nk_config_stack_float_element;
  Pnk_config_stack_vec2_element = ^nk_config_stack_vec2_element;
  Pnk_config_stack_flags_element = ^nk_config_stack_flags_element;
  Pnk_config_stack_color_element = ^nk_config_stack_color_element;
  Pnk_config_stack_user_font_element = ^nk_config_stack_user_font_element;
  Pnk_config_stack_button_behavior_element = ^nk_config_stack_button_behavior_element;
  Pnk_config_stack_style_item = ^nk_config_stack_style_item;
  Pnk_config_stack_float = ^nk_config_stack_float;
  Pnk_config_stack_vec2 = ^nk_config_stack_vec2;
  Pnk_config_stack_flags = ^nk_config_stack_flags;
  Pnk_config_stack_color = ^nk_config_stack_color;
  Pnk_config_stack_user_font = ^nk_config_stack_user_font;
  Pnk_config_stack_button_behavior = ^nk_config_stack_button_behavior;
  Pnk_configuration_stacks = ^nk_configuration_stacks;
  Pnk_table = ^nk_table;
  Pnk_page_element = ^nk_page_element;
  Pnk_page = ^nk_page;
  Pnk_pool = ^nk_pool;
  Pnk_context = ^nk_context;
  Plua_Debug = ^lua_Debug;
  PluaL_Reg = ^luaL_Reg;
  PluaL_Buffer = ^luaL_Buffer;

  GLFWglproc = procedure(); cdecl;

  GLFWvkproc = procedure(); cdecl;
  PGLFWmonitor = Pointer;
  PPGLFWmonitor = ^PGLFWmonitor;
  PGLFWwindow = Pointer;
  PPGLFWwindow = ^PGLFWwindow;
  PGLFWcursor = Pointer;
  PPGLFWcursor = ^PGLFWcursor;

  GLFWallocatefun = function(size: NativeUInt; user: Pointer): Pointer; cdecl;

  GLFWreallocatefun = function(block: Pointer; size: NativeUInt; user: Pointer): Pointer; cdecl;

  GLFWdeallocatefun = procedure(block: Pointer; user: Pointer); cdecl;

  GLFWerrorfun = procedure(error_code: Integer; const description: PUTF8Char); cdecl;

  GLFWwindowposfun = procedure(window: PGLFWwindow; xpos: Integer; ypos: Integer); cdecl;

  GLFWwindowsizefun = procedure(window: PGLFWwindow; width: Integer; height: Integer); cdecl;

  GLFWwindowclosefun = procedure(window: PGLFWwindow); cdecl;

  GLFWwindowrefreshfun = procedure(window: PGLFWwindow); cdecl;

  GLFWwindowfocusfun = procedure(window: PGLFWwindow; focused: Integer); cdecl;

  GLFWwindowiconifyfun = procedure(window: PGLFWwindow; iconified: Integer); cdecl;

  GLFWwindowmaximizefun = procedure(window: PGLFWwindow; maximized: Integer); cdecl;

  GLFWframebuffersizefun = procedure(window: PGLFWwindow; width: Integer; height: Integer); cdecl;

  GLFWwindowcontentscalefun = procedure(window: PGLFWwindow; xscale: Single; yscale: Single); cdecl;

  GLFWmousebuttonfun = procedure(window: PGLFWwindow; button: Integer; action: Integer; mods: Integer); cdecl;

  GLFWcursorposfun = procedure(window: PGLFWwindow; xpos: Double; ypos: Double); cdecl;

  GLFWcursorenterfun = procedure(window: PGLFWwindow; entered: Integer); cdecl;

  GLFWscrollfun = procedure(window: PGLFWwindow; xoffset: Double; yoffset: Double); cdecl;

  GLFWkeyfun = procedure(window: PGLFWwindow; key: Integer; scancode: Integer; action: Integer; mods: Integer); cdecl;

  GLFWcharfun = procedure(window: PGLFWwindow; codepoint: Cardinal); cdecl;

  GLFWcharmodsfun = procedure(window: PGLFWwindow; codepoint: Cardinal; mods: Integer); cdecl;

  GLFWdropfun = procedure(window: PGLFWwindow; path_count: Integer; paths: PPUTF8Char); cdecl;

  GLFWmonitorfun = procedure(monitor: PGLFWmonitor; event: Integer); cdecl;

  GLFWjoystickfun = procedure(jid: Integer; event: Integer); cdecl;

  GLFWvidmode = record
    width: Integer;
    height: Integer;
    redBits: Integer;
    greenBits: Integer;
    blueBits: Integer;
    refreshRate: Integer;
  end;

  GLFWgammaramp = record
    red: PWord;
    green: PWord;
    blue: PWord;
    size: Cardinal;
  end;

  GLFWimage = record
    width: Integer;
    height: Integer;
    pixels: PByte;
  end;

  GLFWgamepadstate = record
    buttons: array [0..14] of Byte;
    axes: array [0..5] of Single;
  end;

  GLFWallocator = record
    allocate: GLFWallocatefun;
    reallocate: GLFWreallocatefun;
    deallocate: GLFWdeallocatefun;
    user: Pointer;
  end;

  ALboolean = UTF8Char;
  PALboolean = PUTF8Char;
  ALchar = UTF8Char;
  PALchar = PUTF8Char;
  ALbyte = UTF8Char;
  ALubyte = Byte;
  ALshort = Smallint;
  ALushort = Word;
  ALint = Integer;
  PALint = ^ALint;
  ALuint = Cardinal;
  PALuint = ^ALuint;
  ALsizei = Integer;
  ALenum = Integer;
  ALfloat = Single;
  PALfloat = ^ALfloat;
  ALdouble = Double;
  PALdouble = ^ALdouble;
  PALvoid = Pointer;
  PPALvoid = ^PALvoid;
  PALCdevice = Pointer;
  PPALCdevice = ^PALCdevice;
  PALCcontext = Pointer;
  PPALCcontext = ^PALCcontext;
  ALCboolean = UTF8Char;
  ALCchar = UTF8Char;
  PALCchar = PUTF8Char;
  ALCbyte = UTF8Char;
  ALCubyte = Byte;
  ALCshort = Smallint;
  ALCushort = Word;
  ALCint = Integer;
  PALCint = ^ALCint;
  ALCuint = Cardinal;
  ALCsizei = Integer;
  ALCenum = Integer;
  ALCfloat = Single;
  ALCdouble = Double;
  PALCvoid = Pointer;
  PPALCvoid = ^PALCvoid;
  ogg_int16_t = Int16;
  ogg_uint16_t = UInt16;
  ogg_int32_t = Int32;
  ogg_uint32_t = UInt32;
  ogg_int64_t = Int64;
  Pogg_int64_t = ^ogg_int64_t;
  ogg_uint64_t = UInt64;

  ogg_sync_state = record
    data: PByte;
    storage: Integer;
    fill: Integer;
    returned: Integer;
    unsynced: Integer;
    headerbytes: Integer;
    bodybytes: Integer;
  end;

  vorbis_info = record
    version: Integer;
    channels: Integer;
    rate: Integer;
    bitrate_upper: Integer;
    bitrate_nominal: Integer;
    bitrate_lower: Integer;
    bitrate_window: Integer;
    codec_setup: Pointer;
  end;

  vorbis_comment = record
    user_comments: PPUTF8Char;
    comment_lengths: PInteger;
    comments: Integer;
    vendor: PUTF8Char;
  end;

  ogg_stream_state = record
    body_data: PByte;
    body_storage: Integer;
    body_fill: Integer;
    body_returned: Integer;
    lacing_vals: PInteger;
    granule_vals: Pogg_int64_t;
    lacing_storage: Integer;
    lacing_fill: Integer;
    lacing_packet: Integer;
    lacing_returned: Integer;
    header: array [0..281] of Byte;
    header_fill: Integer;
    e_o_s: Integer;
    b_o_s: Integer;
    serialno: Integer;
    pageno: Integer;
    packetno: ogg_int64_t;
    granulepos: ogg_int64_t;
  end;

  vorbis_dsp_state = record
    analysisp: Integer;
    vi: Pvorbis_info;
    pcm: PPSingle;
    pcmret: PPSingle;
    pcm_storage: Integer;
    pcm_current: Integer;
    pcm_returned: Integer;
    preextrapolate: Integer;
    eofflag: Integer;
    lW: Integer;
    W: Integer;
    nW: Integer;
    centerW: Integer;
    granulepos: ogg_int64_t;
    sequence: ogg_int64_t;
    glue_bits: ogg_int64_t;
    time_bits: ogg_int64_t;
    floor_bits: ogg_int64_t;
    res_bits: ogg_int64_t;
    backend_state: Pointer;
  end;

  oggpack_buffer = record
    endbyte: Integer;
    endbit: Integer;
    buffer: PByte;
    ptr: PByte;
    storage: Integer;
  end;

  vorbis_block = record
    pcm: PPSingle;
    opb: oggpack_buffer;
    lW: Integer;
    W: Integer;
    nW: Integer;
    pcmend: Integer;
    mode: Integer;
    eofflag: Integer;
    granulepos: ogg_int64_t;
    sequence: ogg_int64_t;
    vd: Pvorbis_dsp_state;
    localstore: Pointer;
    localtop: Integer;
    localalloc: Integer;
    totaluse: Integer;
    reap: Palloc_chain;
    glue_bits: Integer;
    time_bits: Integer;
    floor_bits: Integer;
    res_bits: Integer;
    internal: Pointer;
  end;

  ov_callbacks = record
    read_func: function(ptr: Pointer; size: NativeUInt; nmemb: NativeUInt; datasource: Pointer): NativeUInt; cdecl;
    seek_func: function(datasource: Pointer; offset: ogg_int64_t; whence: Integer): Integer; cdecl;
    close_func: function(datasource: Pointer): Integer; cdecl;
    tell_func: function(datasource: Pointer): Integer; cdecl;
  end;

  OggVorbis_File = record
    datasource: Pointer;
    seekable: Integer;
    offset: ogg_int64_t;
    &end: ogg_int64_t;
    oy: ogg_sync_state;
    links: Integer;
    offsets: Pogg_int64_t;
    dataoffsets: Pogg_int64_t;
    serialnos: PInteger;
    pcmlengths: Pogg_int64_t;
    vi: Pvorbis_info;
    vc: Pvorbis_comment;
    pcm_offset: ogg_int64_t;
    ready_state: Integer;
    current_serialno: Integer;
    current_link: Integer;
    bittrack: Double;
    samptrack: Double;
    os: ogg_stream_state;
    vd: vorbis_dsp_state;
    vb: vorbis_block;
    callbacks: ov_callbacks;
  end;

  voidp = Pointer;
  unzFile = voidp;
  zipFile = voidp;
  uInt = Cardinal;
  uLong = Cardinal;
  Bytef = &Byte;
  PBytef = ^Bytef;

  tm_zip_s = record
    tm_sec: Integer;
    tm_min: Integer;
    tm_hour: Integer;
    tm_mday: Integer;
    tm_mon: Integer;
    tm_year: Integer;
  end;

  tm_zip = tm_zip_s;

  zip_fileinfo = record
    tmz_date: tm_zip;
    dosDate: uLong;
    internal_fa: uLong;
    external_fa: uLong;
  end;

  tm_unz_s = record
    tm_sec: Integer;
    tm_min: Integer;
    tm_hour: Integer;
    tm_mday: Integer;
    tm_mon: Integer;
    tm_year: Integer;
  end;

  tm_unz = tm_unz_s;

  unz_file_info64_s = record
    version: uLong;
    version_needed: uLong;
    flag: uLong;
    compression_method: uLong;
    dosDate: uLong;
    crc: uLong;
    compressed_size: UInt64;
    uncompressed_size: UInt64;
    size_filename: uLong;
    size_file_extra: uLong;
    size_file_comment: uLong;
    disk_num_start: uLong;
    internal_fa: uLong;
    external_fa: uLong;
    tmu_date: tm_unz;
  end;

  unz_file_info64 = unz_file_info64_s;
  Punz_file_info64 = ^unz_file_info64;

  c2v = record
    x: Single;
    y: Single;
  end;

  c2r = record
    c: Single;
    s: Single;
  end;

  c2m = record
    x: c2v;
    y: c2v;
  end;

  c2x = record
    p: c2v;
    r: c2r;
  end;

  c2h = record
    n: c2v;
    d: Single;
  end;

  c2Circle = record
    p: c2v;
    r: Single;
  end;

  c2AABB = record
    min: c2v;
    max: c2v;
  end;

  c2Capsule = record
    a: c2v;
    b: c2v;
    r: Single;
  end;

  c2Poly = record
    count: Integer;
    verts: array [0..7] of c2v;
    norms: array [0..7] of c2v;
  end;

  c2Ray = record
    p: c2v;
    d: c2v;
    t: Single;
  end;

  c2Raycast = record
    t: Single;
    n: c2v;
  end;

  c2Manifold = record
    count: Integer;
    depths: array [0..1] of Single;
    contact_points: array [0..1] of c2v;
    n: c2v;
  end;

  c2GJKCache = record
    metric: Single;
    count: Integer;
    iA: array [0..2] of Integer;
    iB: array [0..2] of Integer;
    &div: Single;
  end;

  c2TOIResult = record
    hit: Integer;
    toi: Single;
    n: c2v;
    p: c2v;
    iterations: Integer;
  end;

  Pplm_t = Pointer;
  PPplm_t = ^Pplm_t;
  Pplm_buffer_t = Pointer;
  PPplm_buffer_t = ^Pplm_buffer_t;
  Pplm_demux_t = Pointer;
  PPplm_demux_t = ^Pplm_demux_t;
  Pplm_video_t = Pointer;
  PPplm_video_t = ^Pplm_video_t;
  Pplm_audio_t = Pointer;
  PPplm_audio_t = ^Pplm_audio_t;

  plm_packet_t = record
    &type: Integer;
    pts: Double;
    length: NativeUInt;
    data: PUInt8;
  end;

  plm_plane_t = record
    width: Cardinal;
    height: Cardinal;
    data: PUInt8;
  end;

  plm_frame_t = record
    time: Double;
    width: Cardinal;
    height: Cardinal;
    y: plm_plane_t;
    cr: plm_plane_t;
    cb: plm_plane_t;
  end;

  plm_video_decode_callback = procedure(self: Pplm_t; frame: Pplm_frame_t; user: Pointer); cdecl;

  plm_samples_t = record
    time: Double;
    count: Cardinal;
    interleaved: array [0..2303] of Single;
  end;

  plm_audio_decode_callback = procedure(self: Pplm_t; samples: Pplm_samples_t; user: Pointer); cdecl;

  plm_buffer_load_callback = procedure(self: Pplm_buffer_t; user: Pointer); cdecl;
  stbi_uc = Byte;
  Pstbi_uc = ^stbi_uc;
  stbi_us = Word;
  Pstbi_us = ^stbi_us;

  stbi_io_callbacks = record
    read: function(user: Pointer; data: PUTF8Char; size: Integer): Integer; cdecl;
    skip: procedure(user: Pointer; n: Integer); cdecl;
    eof: function(user: Pointer): Integer; cdecl;
  end;

  Pstbi_write_func = procedure(context: Pointer; data: Pointer; size: Integer); cdecl;

  stbtt__buf = record
    data: PByte;
    cursor: Integer;
    size: Integer;
  end;

  stbtt_bakedchar = record
    x0: Word;
    y0: Word;
    x1: Word;
    y1: Word;
    xoff: Single;
    yoff: Single;
    xadvance: Single;
  end;

  stbtt_aligned_quad = record
    x0: Single;
    y0: Single;
    s0: Single;
    t0: Single;
    x1: Single;
    y1: Single;
    s1: Single;
    t1: Single;
  end;

  stbtt_packedchar = record
    x0: Word;
    y0: Word;
    x1: Word;
    y1: Word;
    xoff: Single;
    yoff: Single;
    xadvance: Single;
    xoff2: Single;
    yoff2: Single;
  end;

  Pstbrp_rect = Pointer;
  PPstbrp_rect = ^Pstbrp_rect;

  stbtt_pack_range = record
    font_size: Single;
    first_unicode_codepoint_in_range: Integer;
    array_of_unicode_codepoints: PInteger;
    num_chars: Integer;
    chardata_for_range: Pstbtt_packedchar;
    h_oversample: Byte;
    v_oversample: Byte;
  end;

  stbtt_pack_context = record
    user_allocator_context: Pointer;
    pack_info: Pointer;
    width: Integer;
    height: Integer;
    stride_in_bytes: Integer;
    padding: Integer;
    skip_missing: Integer;
    h_oversample: Cardinal;
    v_oversample: Cardinal;
    pixels: PByte;
    nodes: Pointer;
  end;

  stbtt_fontinfo = record
    userdata: Pointer;
    data: PByte;
    fontstart: Integer;
    numGlyphs: Integer;
    loca: Integer;
    head: Integer;
    glyf: Integer;
    hhea: Integer;
    hmtx: Integer;
    kern: Integer;
    gpos: Integer;
    svg: Integer;
    index_map: Integer;
    indexToLocFormat: Integer;
    cff: stbtt__buf;
    charstrings: stbtt__buf;
    gsubrs: stbtt__buf;
    subrs: stbtt__buf;
    fontdicts: stbtt__buf;
    fdselect: stbtt__buf;
  end;

  stbtt_kerningentry = record
    glyph1: Integer;
    glyph2: Integer;
    advance: Integer;
  end;

  stbtt_vertex = record
    x: Smallint;
    y: Smallint;
    cx: Smallint;
    cy: Smallint;
    cx1: Smallint;
    cy1: Smallint;
    &type: Byte;
    padding: Byte;
  end;

  stbtt__bitmap = record
    w: Integer;
    h: Integer;
    stride: Integer;
    pixels: PByte;
  end;

  clog = record
    level: clog_level;
    fd: Integer;
    fmt: array [0..255] of UTF8Char;
    date_fmt: array [0..255] of UTF8Char;
    time_fmt: array [0..255] of UTF8Char;
    opened: Integer;
  end;

  nk_char = Int8;
  nk_uchar = UInt8;
  nk_byte = UInt8;
  Pnk_byte = ^nk_byte;
  nk_short = Int16;
  nk_ushort = UInt16;
  nk_int = Int32;
  nk_uint = UInt32;
  Pnk_uint = ^nk_uint;
  nk_size = UIntPtr;
  Pnk_size = ^nk_size;
  nk_ptr = UIntPtr;
  nk_bool = Integer;
  Pnk_bool = ^nk_bool;
  nk_hash = nk_uint;
  nk_flags = nk_uint;
  Pnk_flags = ^nk_flags;
  nk_rune = nk_uint;
  Pnk_rune = ^nk_rune;
  _dummy_array0 = array [0..0] of UTF8Char;
  _dummy_array1 = array [0..0] of UTF8Char;
  _dummy_array2 = array [0..0] of UTF8Char;
  _dummy_array3 = array [0..0] of UTF8Char;
  _dummy_array4 = array [0..0] of UTF8Char;
  _dummy_array5 = array [0..0] of UTF8Char;
  _dummy_array6 = array [0..0] of UTF8Char;
  _dummy_array7 = array [0..0] of UTF8Char;
  _dummy_array8 = array [0..0] of UTF8Char;
  _dummy_array9 = array [0..0] of UTF8Char;

  nk_color = record
    r: nk_byte;
    g: nk_byte;
    b: nk_byte;
    a: nk_byte;
  end;

  nk_colorf = record
    r: Single;
    g: Single;
    b: Single;
    a: Single;
  end;

  nk_vec2 = record
    x: Single;
    y: Single;
  end;

  nk_vec2i = record
    x: Smallint;
    y: Smallint;
  end;

  nk_rect = record
    x: Single;
    y: Single;
    w: Single;
    h: Single;
  end;

  nk_recti = record
    x: Smallint;
    y: Smallint;
    w: Smallint;
    h: Smallint;
  end;

  nk_glyph = array [0..3] of UTF8Char;

  nk_handle = record
    case Integer of
      0: (ptr: Pointer);
      1: (id: Integer);
  end;

  nk_image = record
    handle: nk_handle;
    w: nk_ushort;
    h: nk_ushort;
    region: array [0..3] of nk_ushort;
  end;

  nk_nine_slice = record
    img: nk_image;
    l: nk_ushort;
    t: nk_ushort;
    r: nk_ushort;
    b: nk_ushort;
  end;

  nk_cursor = record
    img: nk_image;
    size: nk_vec2;
    offset: nk_vec2;
  end;

  nk_scroll = record
    x: nk_uint;
    y: nk_uint;
  end;

  nk_plugin_alloc = function(p1: nk_handle; old: Pointer; p3: nk_size): Pointer; cdecl;

  nk_plugin_free = procedure(p1: nk_handle; old: Pointer); cdecl;

  nk_plugin_filter = function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;

  nk_plugin_paste = procedure(p1: nk_handle; p2: Pnk_text_edit); cdecl;

  nk_plugin_copy = procedure(p1: nk_handle; const p2: PUTF8Char; len: Integer); cdecl;

  nk_allocator = record
    userdata: nk_handle;
    alloc: nk_plugin_alloc;
    free: nk_plugin_free;
  end;

  nk_draw_null_texture = record
    texture: nk_handle;
    uv: nk_vec2;
  end;

  nk_convert_config = record
    global_alpha: Single;
    line_AA: nk_anti_aliasing;
    shape_AA: nk_anti_aliasing;
    circle_segment_count: Cardinal;
    arc_segment_count: Cardinal;
    curve_segment_count: Cardinal;
    tex_null: nk_draw_null_texture;
    vertex_layout: Pnk_draw_vertex_layout_element;
    vertex_size: nk_size;
    vertex_alignment: nk_size;
  end;

  nk_list_view = record
    &begin: Integer;
    &end: Integer;
    count: Integer;
    total_height: Integer;
    ctx: Pnk_context;
    scroll_pointer: Pnk_uint;
    scroll_value: nk_uint;
  end;

  nk_text_width_f = function(p1: nk_handle; h: Single; const p3: PUTF8Char; len: Integer): Single; cdecl;

  nk_query_font_glyph_f = procedure(handle: nk_handle; font_height: Single; glyph: Pnk_user_font_glyph; codepoint: nk_rune; next_codepoint: nk_rune); cdecl;

  nk_user_font_glyph = record
    uv: array [0..1] of nk_vec2;
    offset: nk_vec2;
    width: Single;
    height: Single;
    xadvance: Single;
  end;

  nk_user_font = record
    userdata: nk_handle;
    height: Single;
    width: nk_text_width_f;
    query: nk_query_font_glyph_f;
    texture: nk_handle;
  end;

  nk_baked_font = record
    height: Single;
    ascent: Single;
    descent: Single;
    glyph_offset: nk_rune;
    glyph_count: nk_rune;
    ranges: Pnk_rune;
  end;

  nk_font_config = record
    next: Pnk_font_config;
    ttf_blob: Pointer;
    ttf_size: nk_size;
    ttf_data_owned_by_atlas: Byte;
    merge_mode: Byte;
    pixel_snap: Byte;
    oversample_v: Byte;
    oversample_h: Byte;
    padding: array [0..2] of Byte;
    size: Single;
    coord_type: nk_font_coord_type;
    spacing: nk_vec2;
    range: Pnk_rune;
    font: Pnk_baked_font;
    fallback_glyph: nk_rune;
    n: Pnk_font_config;
    p: Pnk_font_config;
  end;

  nk_font_glyph = record
    codepoint: nk_rune;
    xadvance: Single;
    x0: Single;
    y0: Single;
    x1: Single;
    y1: Single;
    w: Single;
    h: Single;
    u0: Single;
    v0: Single;
    u1: Single;
    v1: Single;
  end;

  nk_font = record
    next: Pnk_font;
    handle: nk_user_font;
    info: nk_baked_font;
    scale: Single;
    glyphs: Pnk_font_glyph;
    fallback: Pnk_font_glyph;
    fallback_codepoint: nk_rune;
    texture: nk_handle;
    config: Pnk_font_config;
  end;

  nk_font_atlas = record
    pixel: Pointer;
    tex_width: Integer;
    tex_height: Integer;
    permanent: nk_allocator;
    temporary: nk_allocator;
    custom: nk_recti;
    cursors: array [0..6] of nk_cursor;
    glyph_count: Integer;
    glyphs: Pnk_font_glyph;
    default_font: Pnk_font;
    fonts: Pnk_font;
    config: Pnk_font_config;
    font_num: Integer;
  end;

  nk_memory_status = record
    memory: Pointer;
    &type: Cardinal;
    size: nk_size;
    allocated: nk_size;
    needed: nk_size;
    calls: nk_size;
  end;

  nk_buffer_marker = record
    active: nk_bool;
    offset: nk_size;
  end;

  nk_memory = record
    ptr: Pointer;
    size: nk_size;
  end;

  nk_buffer = record
    marker: array [0..1] of nk_buffer_marker;
    pool: nk_allocator;
    &type: nk_allocation_type;
    memory: nk_memory;
    grow_factor: Single;
    allocated: nk_size;
    needed: nk_size;
    calls: nk_size;
    size: nk_size;
  end;

  nk_str = record
    buffer: nk_buffer;
    len: Integer;
  end;

  nk_clipboard = record
    userdata: nk_handle;
    paste: nk_plugin_paste;
    copy: nk_plugin_copy;
  end;

  nk_text_undo_record = record
    where: Integer;
    insert_length: Smallint;
    delete_length: Smallint;
    char_storage: Smallint;
  end;

  nk_text_undo_state = record
    undo_rec: array [0..98] of nk_text_undo_record;
    undo_char: array [0..998] of nk_rune;
    undo_point: Smallint;
    redo_point: Smallint;
    undo_char_point: Smallint;
    redo_char_point: Smallint;
  end;

  nk_text_edit = record
    clip: nk_clipboard;
    &string: nk_str;
    filter: nk_plugin_filter;
    scrollbar: nk_vec2;
    cursor: Integer;
    select_start: Integer;
    select_end: Integer;
    mode: Byte;
    cursor_at_end_of_line: Byte;
    initialized: Byte;
    has_preferred_x: Byte;
    single_line: Byte;
    active: Byte;
    padding1: Byte;
    preferred_x: Single;
    undo: nk_text_undo_state;
  end;

  nk_command = record
    &type: nk_command_type;
    next: nk_size;
  end;

  nk_command_scissor = record
    header: nk_command;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
  end;

  nk_command_line = record
    header: nk_command;
    line_thickness: Word;
    &begin: nk_vec2i;
    &end: nk_vec2i;
    color: nk_color;
  end;

  nk_command_curve = record
    header: nk_command;
    line_thickness: Word;
    &begin: nk_vec2i;
    &end: nk_vec2i;
    ctrl: array [0..1] of nk_vec2i;
    color: nk_color;
  end;

  nk_command_rect = record
    header: nk_command;
    rounding: Word;
    line_thickness: Word;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
    color: nk_color;
  end;

  nk_command_rect_filled = record
    header: nk_command;
    rounding: Word;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
    color: nk_color;
  end;

  nk_command_rect_multi_color = record
    header: nk_command;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
    left: nk_color;
    top: nk_color;
    bottom: nk_color;
    right: nk_color;
  end;

  nk_command_triangle = record
    header: nk_command;
    line_thickness: Word;
    a: nk_vec2i;
    b: nk_vec2i;
    c: nk_vec2i;
    color: nk_color;
  end;

  nk_command_triangle_filled = record
    header: nk_command;
    a: nk_vec2i;
    b: nk_vec2i;
    c: nk_vec2i;
    color: nk_color;
  end;

  nk_command_circle = record
    header: nk_command;
    x: Smallint;
    y: Smallint;
    line_thickness: Word;
    w: Word;
    h: Word;
    color: nk_color;
  end;

  nk_command_circle_filled = record
    header: nk_command;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
    color: nk_color;
  end;

  nk_command_arc = record
    header: nk_command;
    cx: Smallint;
    cy: Smallint;
    r: Word;
    line_thickness: Word;
    a: array [0..1] of Single;
    color: nk_color;
  end;

  nk_command_arc_filled = record
    header: nk_command;
    cx: Smallint;
    cy: Smallint;
    r: Word;
    a: array [0..1] of Single;
    color: nk_color;
  end;

  nk_command_polygon = record
    header: nk_command;
    color: nk_color;
    line_thickness: Word;
    point_count: Word;
    points: array [0..0] of nk_vec2i;
  end;

  nk_command_polygon_filled = record
    header: nk_command;
    color: nk_color;
    point_count: Word;
    points: array [0..0] of nk_vec2i;
  end;

  nk_command_polyline = record
    header: nk_command;
    color: nk_color;
    line_thickness: Word;
    point_count: Word;
    points: array [0..0] of nk_vec2i;
  end;

  nk_command_image = record
    header: nk_command;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
    img: nk_image;
    col: nk_color;
  end;

  nk_command_custom_callback = procedure(canvas: Pointer; x: Smallint; y: Smallint; w: Word; h: Word; callback_data: nk_handle); cdecl;

  nk_command_custom = record
    header: nk_command;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
    callback_data: nk_handle;
    callback: nk_command_custom_callback;
  end;

  nk_command_text = record
    header: nk_command;
    font: Pnk_user_font;
    background: nk_color;
    foreground: nk_color;
    x: Smallint;
    y: Smallint;
    w: Word;
    h: Word;
    height: Single;
    length: Integer;
    &string: array [0..0] of UTF8Char;
  end;

  nk_command_buffer = record
    base: Pnk_buffer;
    clip: nk_rect;
    use_clipping: Integer;
    userdata: nk_handle;
    &begin: nk_size;
    &end: nk_size;
    last: nk_size;
  end;

  nk_mouse_button = record
    down: nk_bool;
    clicked: Cardinal;
    clicked_pos: nk_vec2;
  end;

  nk_mouse = record
    buttons: array [0..3] of nk_mouse_button;
    pos: nk_vec2;
    prev: nk_vec2;
    delta: nk_vec2;
    scroll_delta: nk_vec2;
    grab: Byte;
    grabbed: Byte;
    ungrab: Byte;
  end;

  nk_key = record
    down: nk_bool;
    clicked: Cardinal;
  end;

  nk_keyboard = record
    keys: array [0..29] of nk_key;
    text: array [0..15] of UTF8Char;
    text_len: Integer;
  end;

  nk_input = record
    keyboard: nk_keyboard;
    mouse: nk_mouse;
  end;

  nk_draw_index = nk_ushort;

  nk_draw_vertex_layout_element = record
    attribute: nk_draw_vertex_layout_attribute;
    format: nk_draw_vertex_layout_format;
    offset: nk_size;
  end;

  nk_draw_command = record
    elem_count: Cardinal;
    clip_rect: nk_rect;
    texture: nk_handle;
  end;

  nk_draw_list = record
    clip_rect: nk_rect;
    circle_vtx: array [0..11] of nk_vec2;
    config: nk_convert_config;
    buffer: Pnk_buffer;
    vertices: Pnk_buffer;
    elements: Pnk_buffer;
    element_count: Cardinal;
    vertex_count: Cardinal;
    cmd_count: Cardinal;
    cmd_offset: nk_size;
    path_count: Cardinal;
    path_offset: Cardinal;
    line_AA: nk_anti_aliasing;
    shape_AA: nk_anti_aliasing;
  end;

  nk_style_item_data = record
    case Integer of
      0: (color: nk_color);
      1: (image: nk_image);
      2: (slice: nk_nine_slice);
  end;

  nk_style_item = record
    &type: nk_style_item_type;
    data: nk_style_item_data;
  end;

  nk_style_text = record
    color: nk_color;
    padding: nk_vec2;
  end;

  nk_style_button = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    text_background: nk_color;
    text_normal: nk_color;
    text_hover: nk_color;
    text_active: nk_color;
    text_alignment: nk_flags;
    border: Single;
    rounding: Single;
    padding: nk_vec2;
    image_padding: nk_vec2;
    touch_padding: nk_vec2;
    userdata: nk_handle;
    draw_begin: procedure(p1: Pnk_command_buffer; userdata: nk_handle); cdecl;
    draw_end: procedure(p1: Pnk_command_buffer; userdata: nk_handle); cdecl;
  end;

  nk_style_toggle = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    cursor_normal: nk_style_item;
    cursor_hover: nk_style_item;
    text_normal: nk_color;
    text_hover: nk_color;
    text_active: nk_color;
    text_background: nk_color;
    text_alignment: nk_flags;
    padding: nk_vec2;
    touch_padding: nk_vec2;
    spacing: Single;
    border: Single;
    userdata: nk_handle;
    draw_begin: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
    draw_end: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
  end;

  nk_style_selectable = record
    normal: nk_style_item;
    hover: nk_style_item;
    pressed: nk_style_item;
    normal_active: nk_style_item;
    hover_active: nk_style_item;
    pressed_active: nk_style_item;
    text_normal: nk_color;
    text_hover: nk_color;
    text_pressed: nk_color;
    text_normal_active: nk_color;
    text_hover_active: nk_color;
    text_pressed_active: nk_color;
    text_background: nk_color;
    text_alignment: nk_flags;
    rounding: Single;
    padding: nk_vec2;
    touch_padding: nk_vec2;
    image_padding: nk_vec2;
    userdata: nk_handle;
    draw_begin: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
    draw_end: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
  end;

  nk_style_slider = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    bar_normal: nk_color;
    bar_hover: nk_color;
    bar_active: nk_color;
    bar_filled: nk_color;
    cursor_normal: nk_style_item;
    cursor_hover: nk_style_item;
    cursor_active: nk_style_item;
    border: Single;
    rounding: Single;
    bar_height: Single;
    padding: nk_vec2;
    spacing: nk_vec2;
    cursor_size: nk_vec2;
    show_buttons: Integer;
    inc_button: nk_style_button;
    dec_button: nk_style_button;
    inc_symbol: nk_symbol_type;
    dec_symbol: nk_symbol_type;
    userdata: nk_handle;
    draw_begin: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
    draw_end: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
  end;

  nk_style_progress = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    cursor_normal: nk_style_item;
    cursor_hover: nk_style_item;
    cursor_active: nk_style_item;
    cursor_border_color: nk_color;
    rounding: Single;
    border: Single;
    cursor_border: Single;
    cursor_rounding: Single;
    padding: nk_vec2;
    userdata: nk_handle;
    draw_begin: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
    draw_end: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
  end;

  nk_style_scrollbar = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    cursor_normal: nk_style_item;
    cursor_hover: nk_style_item;
    cursor_active: nk_style_item;
    cursor_border_color: nk_color;
    border: Single;
    rounding: Single;
    border_cursor: Single;
    rounding_cursor: Single;
    padding: nk_vec2;
    show_buttons: Integer;
    inc_button: nk_style_button;
    dec_button: nk_style_button;
    inc_symbol: nk_symbol_type;
    dec_symbol: nk_symbol_type;
    userdata: nk_handle;
    draw_begin: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
    draw_end: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
  end;

  nk_style_edit = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    scrollbar: nk_style_scrollbar;
    cursor_normal: nk_color;
    cursor_hover: nk_color;
    cursor_text_normal: nk_color;
    cursor_text_hover: nk_color;
    text_normal: nk_color;
    text_hover: nk_color;
    text_active: nk_color;
    selected_normal: nk_color;
    selected_hover: nk_color;
    selected_text_normal: nk_color;
    selected_text_hover: nk_color;
    border: Single;
    rounding: Single;
    cursor_size: Single;
    scrollbar_size: nk_vec2;
    padding: nk_vec2;
    row_padding: Single;
  end;

  nk_style_property = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    label_normal: nk_color;
    label_hover: nk_color;
    label_active: nk_color;
    sym_left: nk_symbol_type;
    sym_right: nk_symbol_type;
    border: Single;
    rounding: Single;
    padding: nk_vec2;
    edit: nk_style_edit;
    inc_button: nk_style_button;
    dec_button: nk_style_button;
    userdata: nk_handle;
    draw_begin: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
    draw_end: procedure(p1: Pnk_command_buffer; p2: nk_handle); cdecl;
  end;

  nk_style_chart = record
    background: nk_style_item;
    border_color: nk_color;
    selected_color: nk_color;
    color: nk_color;
    border: Single;
    rounding: Single;
    padding: nk_vec2;
  end;

  nk_style_combo = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    border_color: nk_color;
    label_normal: nk_color;
    label_hover: nk_color;
    label_active: nk_color;
    symbol_normal: nk_color;
    symbol_hover: nk_color;
    symbol_active: nk_color;
    button: nk_style_button;
    sym_normal: nk_symbol_type;
    sym_hover: nk_symbol_type;
    sym_active: nk_symbol_type;
    border: Single;
    rounding: Single;
    content_padding: nk_vec2;
    button_padding: nk_vec2;
    spacing: nk_vec2;
  end;

  nk_style_tab = record
    background: nk_style_item;
    border_color: nk_color;
    text: nk_color;
    tab_maximize_button: nk_style_button;
    tab_minimize_button: nk_style_button;
    node_maximize_button: nk_style_button;
    node_minimize_button: nk_style_button;
    sym_minimize: nk_symbol_type;
    sym_maximize: nk_symbol_type;
    border: Single;
    rounding: Single;
    indent: Single;
    padding: nk_vec2;
    spacing: nk_vec2;
  end;

  nk_style_window_header = record
    normal: nk_style_item;
    hover: nk_style_item;
    active: nk_style_item;
    close_button: nk_style_button;
    minimize_button: nk_style_button;
    close_symbol: nk_symbol_type;
    minimize_symbol: nk_symbol_type;
    maximize_symbol: nk_symbol_type;
    label_normal: nk_color;
    label_hover: nk_color;
    label_active: nk_color;
    align: nk_style_header_align;
    padding: nk_vec2;
    label_padding: nk_vec2;
    spacing: nk_vec2;
  end;

  nk_style_window = record
    header: nk_style_window_header;
    fixed_background: nk_style_item;
    background: nk_color;
    border_color: nk_color;
    popup_border_color: nk_color;
    combo_border_color: nk_color;
    contextual_border_color: nk_color;
    menu_border_color: nk_color;
    group_border_color: nk_color;
    tooltip_border_color: nk_color;
    scaler: nk_style_item;
    border: Single;
    combo_border: Single;
    contextual_border: Single;
    menu_border: Single;
    group_border: Single;
    tooltip_border: Single;
    popup_border: Single;
    min_row_height_padding: Single;
    rounding: Single;
    spacing: nk_vec2;
    scrollbar_size: nk_vec2;
    min_size: nk_vec2;
    padding: nk_vec2;
    group_padding: nk_vec2;
    popup_padding: nk_vec2;
    combo_padding: nk_vec2;
    contextual_padding: nk_vec2;
    menu_padding: nk_vec2;
    tooltip_padding: nk_vec2;
  end;

  nk_style = record
    font: Pnk_user_font;
    cursors: array [0..6] of Pnk_cursor;
    cursor_active: Pnk_cursor;
    cursor_last: Pnk_cursor;
    cursor_visible: Integer;
    text: nk_style_text;
    button: nk_style_button;
    contextual_button: nk_style_button;
    menu_button: nk_style_button;
    option: nk_style_toggle;
    checkbox: nk_style_toggle;
    selectable: nk_style_selectable;
    slider: nk_style_slider;
    progress: nk_style_progress;
    &property: nk_style_property;
    edit: nk_style_edit;
    chart: nk_style_chart;
    scrollh: nk_style_scrollbar;
    scrollv: nk_style_scrollbar;
    tab: nk_style_tab;
    combo: nk_style_combo;
    window: nk_style_window;
  end;

  nk_chart_slot = record
    &type: nk_chart_type;
    color: nk_color;
    highlight: nk_color;
    min: Single;
    max: Single;
    range: Single;
    count: Integer;
    last: nk_vec2;
    index: Integer;
  end;

  nk_chart = record
    slot: Integer;
    x: Single;
    y: Single;
    w: Single;
    h: Single;
    slots: array [0..3] of nk_chart_slot;
  end;

  nk_row_layout = record
    &type: nk_panel_row_layout_type;
    index: Integer;
    height: Single;
    min_height: Single;
    columns: Integer;
    ratio: PSingle;
    item_width: Single;
    item_height: Single;
    item_offset: Single;
    filled: Single;
    item: nk_rect;
    tree_depth: Integer;
    templates: array [0..15] of Single;
  end;

  nk_popup_buffer = record
    &begin: nk_size;
    parent: nk_size;
    last: nk_size;
    &end: nk_size;
    active: nk_bool;
  end;

  nk_menu_state = record
    x: Single;
    y: Single;
    w: Single;
    h: Single;
    offset: nk_scroll;
  end;

  nk_panel = record
    &type: nk_panel_type;
    flags: nk_flags;
    bounds: nk_rect;
    offset_x: Pnk_uint;
    offset_y: Pnk_uint;
    at_x: Single;
    at_y: Single;
    max_x: Single;
    footer_height: Single;
    header_height: Single;
    border: Single;
    has_scrolling: Cardinal;
    clip: nk_rect;
    menu: nk_menu_state;
    row: nk_row_layout;
    chart: nk_chart;
    buffer: Pnk_command_buffer;
    parent: Pnk_panel;
  end;

  nk_popup_state = record
    win: Pnk_window;
    &type: nk_panel_type;
    buf: nk_popup_buffer;
    name: nk_hash;
    active: nk_bool;
    combo_count: Cardinal;
    con_count: Cardinal;
    con_old: Cardinal;
    active_con: Cardinal;
    header: nk_rect;
  end;

  nk_edit_state = record
    name: nk_hash;
    seq: Cardinal;
    old: Cardinal;
    active: Integer;
    prev: Integer;
    cursor: Integer;
    sel_start: Integer;
    sel_end: Integer;
    scrollbar: nk_scroll;
    mode: Byte;
    single_line: Byte;
  end;

  nk_property_state = record
    active: Integer;
    prev: Integer;
    buffer: array [0..63] of UTF8Char;
    length: Integer;
    cursor: Integer;
    select_start: Integer;
    select_end: Integer;
    name: nk_hash;
    seq: Cardinal;
    old: Cardinal;
    state: Integer;
  end;

  nk_window = record
    seq: Cardinal;
    name: nk_hash;
    name_string: array [0..63] of UTF8Char;
    flags: nk_flags;
    bounds: nk_rect;
    scrollbar: nk_scroll;
    buffer: nk_command_buffer;
    layout: Pnk_panel;
    scrollbar_hiding_timer: Single;
    &property: nk_property_state;
    popup: nk_popup_state;
    edit: nk_edit_state;
    scrolled: Cardinal;
    tables: Pnk_table;
    table_count: Cardinal;
    next: Pnk_window;
    prev: Pnk_window;
    parent: Pnk_window;
  end;

  nk_config_stack_style_item_element = record
    address: Pnk_style_item;
    old_value: nk_style_item;
  end;

  nk_config_stack_float_element = record
    address: PSingle;
    old_value: Single;
  end;

  nk_config_stack_vec2_element = record
    address: Pnk_vec2;
    old_value: nk_vec2;
  end;

  nk_config_stack_flags_element = record
    address: Pnk_flags;
    old_value: nk_flags;
  end;

  nk_config_stack_color_element = record
    address: Pnk_color;
    old_value: nk_color;
  end;

  nk_config_stack_user_font_element = record
    address: PPnk_user_font;
    old_value: Pnk_user_font;
  end;

  nk_config_stack_button_behavior_element = record
    address: Pnk_button_behavior;
    old_value: nk_button_behavior;
  end;

  nk_config_stack_style_item = record
    head: Integer;
    elements: array [0..15] of nk_config_stack_style_item_element;
  end;

  nk_config_stack_float = record
    head: Integer;
    elements: array [0..31] of nk_config_stack_float_element;
  end;

  nk_config_stack_vec2 = record
    head: Integer;
    elements: array [0..15] of nk_config_stack_vec2_element;
  end;

  nk_config_stack_flags = record
    head: Integer;
    elements: array [0..31] of nk_config_stack_flags_element;
  end;

  nk_config_stack_color = record
    head: Integer;
    elements: array [0..31] of nk_config_stack_color_element;
  end;

  nk_config_stack_user_font = record
    head: Integer;
    elements: array [0..7] of nk_config_stack_user_font_element;
  end;

  nk_config_stack_button_behavior = record
    head: Integer;
    elements: array [0..7] of nk_config_stack_button_behavior_element;
  end;

  nk_configuration_stacks = record
    style_items: nk_config_stack_style_item;
    floats: nk_config_stack_float;
    vectors: nk_config_stack_vec2;
    flags: nk_config_stack_flags;
    colors: nk_config_stack_color;
    fonts: nk_config_stack_user_font;
    button_behaviors: nk_config_stack_button_behavior;
  end;

  nk_table = record
    seq: Cardinal;
    size: Cardinal;
    keys: array [0..58] of nk_hash;
    values: array [0..58] of nk_uint;
    next: Pnk_table;
    prev: Pnk_table;
  end;

  nk_page_data = record
    case Integer of
      0: (tbl: nk_table);
      1: (pan: nk_panel);
      2: (win: nk_window);
  end;

  nk_page_element = record
    data: nk_page_data;
    next: Pnk_page_element;
    prev: Pnk_page_element;
  end;

  nk_page = record
    size: Cardinal;
    next: Pnk_page;
    win: array [0..0] of nk_page_element;
  end;

  nk_pool = record
    alloc: nk_allocator;
    &type: nk_allocation_type;
    page_count: Cardinal;
    pages: Pnk_page;
    freelist: Pnk_page_element;
    capacity: Cardinal;
    size: nk_size;
    cap: nk_size;
  end;

  nk_context = record
    input: nk_input;
    style: nk_style;
    memory: nk_buffer;
    clip: nk_clipboard;
    last_widget_state: nk_flags;
    button_behavior: nk_button_behavior;
    stacks: nk_configuration_stacks;
    delta_time_seconds: Single;
    draw_list: nk_draw_list;
    text_edit: nk_text_edit;
    overlay: nk_command_buffer;
    build: Integer;
    use_pool: Integer;
    pool: nk_pool;
    &begin: Pnk_window;
    &end: Pnk_window;
    active: Pnk_window;
    current: Pnk_window;
    freelist: Pnk_page_element;
    count: Cardinal;
    seq: Cardinal;
  end;

  GLADapiproc = procedure(); cdecl;

  GLADloadfunc = function(const name: PUTF8Char): GLADapiproc; cdecl;
  Plua_State = Pointer;
  PPlua_State = ^Plua_State;

  lua_CFunction = function(L: Plua_State): Integer; cdecl;

  lua_Reader = function(L: Plua_State; ud: Pointer; sz: PNativeUInt): PUTF8Char; cdecl;

  lua_Writer = function(L: Plua_State; const p: Pointer; sz: NativeUInt; ud: Pointer): Integer; cdecl;

  lua_Alloc = function(ud: Pointer; ptr: Pointer; osize: NativeUInt; nsize: NativeUInt): Pointer; cdecl;
  lua_Number = Double;
  Plua_Number = ^lua_Number;
  lua_Integer = NativeInt;

  lua_Hook = procedure(L: Plua_State; ar: Plua_Debug); cdecl;

  lua_Debug = record
    event: Integer;
    name: PUTF8Char;
    namewhat: PUTF8Char;
    what: PUTF8Char;
    source: PUTF8Char;
    currentline: Integer;
    nups: Integer;
    linedefined: Integer;
    lastlinedefined: Integer;
    short_src: array [0..59] of UTF8Char;
    i_ci: Integer;
  end;

  luaL_Reg = record
    name: PUTF8Char;
    func: lua_CFunction;
  end;

  luaL_Buffer = record
    p: PUTF8Char;
    lvl: Integer;
    L: Plua_State;
    buffer: array [0..511] of UTF8Char;
  end;

  luaJIT_profile_callback = procedure(data: Pointer; L: Plua_State; samples: Integer; vmstate: Integer); cdecl;

const
  PLM_DEMUX_PACKET_PRIVATE: Integer = $BD;
  PLM_DEMUX_PACKET_AUDIO_1: Integer = $C0;
  PLM_DEMUX_PACKET_AUDIO_2: Integer = $C1;
  PLM_DEMUX_PACKET_AUDIO_3: Integer = $C2;
  PLM_DEMUX_PACKET_AUDIO_4: Integer = $C2;
  PLM_DEMUX_PACKET_VIDEO_1: Integer = $E0;

type
  ov_read_filter_filter = procedure(pcm: PPSingle; channels: Integer; samples: Integer; filter_param: Pointer); cdecl;

type
  nk_plot_function_value_getter = function(user: Pointer; index: Integer): Single; cdecl;

type
  nk_combo_callback_item_getter = procedure(p1: Pointer; p2: Integer; p3: PPUTF8Char); cdecl;

type
  nk_combobox_callback_item_getter = procedure(p1: Pointer; p2: Integer; p3: PPUTF8Char); cdecl;

var
  glfwInit: function(): Integer; cdecl;
  glfwTerminate: procedure(); cdecl;
  glfwInitHint: procedure(hint: Integer; value: Integer); cdecl;
  glfwInitAllocator: procedure(const allocator: PGLFWallocator); cdecl;
  glfwGetVersion: procedure(major: PInteger; minor: PInteger; rev: PInteger); cdecl;
  glfwGetVersionString: function(): PUTF8Char; cdecl;
  glfwGetError: function(description: PPUTF8Char): Integer; cdecl;
  glfwSetErrorCallback: function(callback: GLFWerrorfun): GLFWerrorfun; cdecl;
  glfwGetPlatform: function(): Integer; cdecl;
  glfwPlatformSupported: function(&platform: Integer): Integer; cdecl;
  glfwGetMonitors: function(count: PInteger): PPGLFWmonitor; cdecl;
  glfwGetPrimaryMonitor: function(): PGLFWmonitor; cdecl;
  glfwGetMonitorPos: procedure(monitor: PGLFWmonitor; xpos: PInteger; ypos: PInteger); cdecl;
  glfwGetMonitorWorkarea: procedure(monitor: PGLFWmonitor; xpos: PInteger; ypos: PInteger; width: PInteger; height: PInteger); cdecl;
  glfwGetMonitorPhysicalSize: procedure(monitor: PGLFWmonitor; widthMM: PInteger; heightMM: PInteger); cdecl;
  glfwGetMonitorContentScale: procedure(monitor: PGLFWmonitor; xscale: PSingle; yscale: PSingle); cdecl;
  glfwGetMonitorName: function(monitor: PGLFWmonitor): PUTF8Char; cdecl;
  glfwSetMonitorUserPointer: procedure(monitor: PGLFWmonitor; pointer: Pointer); cdecl;
  glfwGetMonitorUserPointer: function(monitor: PGLFWmonitor): Pointer; cdecl;
  glfwSetMonitorCallback: function(callback: GLFWmonitorfun): GLFWmonitorfun; cdecl;
  glfwGetVideoModes: function(monitor: PGLFWmonitor; count: PInteger): PGLFWvidmode; cdecl;
  glfwGetVideoMode: function(monitor: PGLFWmonitor): PGLFWvidmode; cdecl;
  glfwSetGamma: procedure(monitor: PGLFWmonitor; gamma: Single); cdecl;
  glfwGetGammaRamp: function(monitor: PGLFWmonitor): PGLFWgammaramp; cdecl;
  glfwSetGammaRamp: procedure(monitor: PGLFWmonitor; const ramp: PGLFWgammaramp); cdecl;
  glfwDefaultWindowHints: procedure(); cdecl;
  glfwWindowHint: procedure(hint: Integer; value: Integer); cdecl;
  glfwWindowHintString: procedure(hint: Integer; const value: PUTF8Char); cdecl;
  glfwCreateWindow: function(width: Integer; height: Integer; const title: PUTF8Char; monitor: PGLFWmonitor; share: PGLFWwindow): PGLFWwindow; cdecl;
  glfwDestroyWindow: procedure(window: PGLFWwindow); cdecl;
  glfwWindowShouldClose: function(window: PGLFWwindow): Integer; cdecl;
  glfwSetWindowShouldClose: procedure(window: PGLFWwindow; value: Integer); cdecl;
  glfwSetWindowTitle: procedure(window: PGLFWwindow; const title: PUTF8Char); cdecl;
  glfwSetWindowIcon: procedure(window: PGLFWwindow; count: Integer; const images: PGLFWimage); cdecl;
  glfwGetWindowPos: procedure(window: PGLFWwindow; xpos: PInteger; ypos: PInteger); cdecl;
  glfwSetWindowPos: procedure(window: PGLFWwindow; xpos: Integer; ypos: Integer); cdecl;
  glfwGetWindowSize: procedure(window: PGLFWwindow; width: PInteger; height: PInteger); cdecl;
  glfwSetWindowSizeLimits: procedure(window: PGLFWwindow; minwidth: Integer; minheight: Integer; maxwidth: Integer; maxheight: Integer); cdecl;
  glfwSetWindowAspectRatio: procedure(window: PGLFWwindow; numer: Integer; denom: Integer); cdecl;
  glfwSetWindowSize: procedure(window: PGLFWwindow; width: Integer; height: Integer); cdecl;
  glfwGetFramebufferSize: procedure(window: PGLFWwindow; width: PInteger; height: PInteger); cdecl;
  glfwGetWindowFrameSize: procedure(window: PGLFWwindow; left: PInteger; top: PInteger; right: PInteger; bottom: PInteger); cdecl;
  glfwGetWindowContentScale: procedure(window: PGLFWwindow; xscale: PSingle; yscale: PSingle); cdecl;
  glfwGetWindowOpacity: function(window: PGLFWwindow): Single; cdecl;
  glfwSetWindowOpacity: procedure(window: PGLFWwindow; opacity: Single); cdecl;
  glfwIconifyWindow: procedure(window: PGLFWwindow); cdecl;
  glfwRestoreWindow: procedure(window: PGLFWwindow); cdecl;
  glfwMaximizeWindow: procedure(window: PGLFWwindow); cdecl;
  glfwShowWindow: procedure(window: PGLFWwindow); cdecl;
  glfwHideWindow: procedure(window: PGLFWwindow); cdecl;
  glfwFocusWindow: procedure(window: PGLFWwindow); cdecl;
  glfwRequestWindowAttention: procedure(window: PGLFWwindow); cdecl;
  glfwGetWindowMonitor: function(window: PGLFWwindow): PGLFWmonitor; cdecl;
  glfwSetWindowMonitor: procedure(window: PGLFWwindow; monitor: PGLFWmonitor; xpos: Integer; ypos: Integer; width: Integer; height: Integer; refreshRate: Integer); cdecl;
  glfwGetWindowAttrib: function(window: PGLFWwindow; attrib: Integer): Integer; cdecl;
  glfwSetWindowAttrib: procedure(window: PGLFWwindow; attrib: Integer; value: Integer); cdecl;
  glfwSetWindowUserPointer: procedure(window: PGLFWwindow; pointer: Pointer); cdecl;
  glfwGetWindowUserPointer: function(window: PGLFWwindow): Pointer; cdecl;
  glfwSetWindowPosCallback: function(window: PGLFWwindow; callback: GLFWwindowposfun): GLFWwindowposfun; cdecl;
  glfwSetWindowSizeCallback: function(window: PGLFWwindow; callback: GLFWwindowsizefun): GLFWwindowsizefun; cdecl;
  glfwSetWindowCloseCallback: function(window: PGLFWwindow; callback: GLFWwindowclosefun): GLFWwindowclosefun; cdecl;
  glfwSetWindowRefreshCallback: function(window: PGLFWwindow; callback: GLFWwindowrefreshfun): GLFWwindowrefreshfun; cdecl;
  glfwSetWindowFocusCallback: function(window: PGLFWwindow; callback: GLFWwindowfocusfun): GLFWwindowfocusfun; cdecl;
  glfwSetWindowIconifyCallback: function(window: PGLFWwindow; callback: GLFWwindowiconifyfun): GLFWwindowiconifyfun; cdecl;
  glfwSetWindowMaximizeCallback: function(window: PGLFWwindow; callback: GLFWwindowmaximizefun): GLFWwindowmaximizefun; cdecl;
  glfwSetFramebufferSizeCallback: function(window: PGLFWwindow; callback: GLFWframebuffersizefun): GLFWframebuffersizefun; cdecl;
  glfwSetWindowContentScaleCallback: function(window: PGLFWwindow; callback: GLFWwindowcontentscalefun): GLFWwindowcontentscalefun; cdecl;
  glfwPollEvents: procedure(); cdecl;
  glfwWaitEvents: procedure(); cdecl;
  glfwWaitEventsTimeout: procedure(timeout: Double); cdecl;
  glfwPostEmptyEvent: procedure(); cdecl;
  glfwGetInputMode: function(window: PGLFWwindow; mode: Integer): Integer; cdecl;
  glfwSetInputMode: procedure(window: PGLFWwindow; mode: Integer; value: Integer); cdecl;
  glfwRawMouseMotionSupported: function(): Integer; cdecl;
  glfwGetKeyName: function(key: Integer; scancode: Integer): PUTF8Char; cdecl;
  glfwGetKeyScancode: function(key: Integer): Integer; cdecl;
  glfwGetKey: function(window: PGLFWwindow; key: Integer): Integer; cdecl;
  glfwGetMouseButton: function(window: PGLFWwindow; button: Integer): Integer; cdecl;
  glfwGetCursorPos: procedure(window: PGLFWwindow; xpos: PDouble; ypos: PDouble); cdecl;
  glfwSetCursorPos: procedure(window: PGLFWwindow; xpos: Double; ypos: Double); cdecl;
  glfwCreateCursor: function(const image: PGLFWimage; xhot: Integer; yhot: Integer): PGLFWcursor; cdecl;
  glfwCreateStandardCursor: function(shape: Integer): PGLFWcursor; cdecl;
  glfwDestroyCursor: procedure(cursor: PGLFWcursor); cdecl;
  glfwSetCursor: procedure(window: PGLFWwindow; cursor: PGLFWcursor); cdecl;
  glfwSetKeyCallback: function(window: PGLFWwindow; callback: GLFWkeyfun): GLFWkeyfun; cdecl;
  glfwSetCharCallback: function(window: PGLFWwindow; callback: GLFWcharfun): GLFWcharfun; cdecl;
  glfwSetCharModsCallback: function(window: PGLFWwindow; callback: GLFWcharmodsfun): GLFWcharmodsfun; cdecl;
  glfwSetMouseButtonCallback: function(window: PGLFWwindow; callback: GLFWmousebuttonfun): GLFWmousebuttonfun; cdecl;
  glfwSetCursorPosCallback: function(window: PGLFWwindow; callback: GLFWcursorposfun): GLFWcursorposfun; cdecl;
  glfwSetCursorEnterCallback: function(window: PGLFWwindow; callback: GLFWcursorenterfun): GLFWcursorenterfun; cdecl;
  glfwSetScrollCallback: function(window: PGLFWwindow; callback: GLFWscrollfun): GLFWscrollfun; cdecl;
  glfwSetDropCallback: function(window: PGLFWwindow; callback: GLFWdropfun): GLFWdropfun; cdecl;
  glfwJoystickPresent: function(jid: Integer): Integer; cdecl;
  glfwGetJoystickAxes: function(jid: Integer; count: PInteger): PSingle; cdecl;
  glfwGetJoystickButtons: function(jid: Integer; count: PInteger): PByte; cdecl;
  glfwGetJoystickHats: function(jid: Integer; count: PInteger): PByte; cdecl;
  glfwGetJoystickName: function(jid: Integer): PUTF8Char; cdecl;
  glfwGetJoystickGUID: function(jid: Integer): PUTF8Char; cdecl;
  glfwSetJoystickUserPointer: procedure(jid: Integer; pointer: Pointer); cdecl;
  glfwGetJoystickUserPointer: function(jid: Integer): Pointer; cdecl;
  glfwJoystickIsGamepad: function(jid: Integer): Integer; cdecl;
  glfwSetJoystickCallback: function(callback: GLFWjoystickfun): GLFWjoystickfun; cdecl;
  glfwUpdateGamepadMappings: function(const &string: PUTF8Char): Integer; cdecl;
  glfwGetGamepadName: function(jid: Integer): PUTF8Char; cdecl;
  glfwGetGamepadState: function(jid: Integer; state: PGLFWgamepadstate): Integer; cdecl;
  glfwSetClipboardString: procedure(window: PGLFWwindow; const &string: PUTF8Char); cdecl;
  glfwGetClipboardString: function(window: PGLFWwindow): PUTF8Char; cdecl;
  glfwGetTime: function(): Double; cdecl;
  glfwSetTime: procedure(time: Double); cdecl;
  glfwGetTimerValue: function(): UInt64; cdecl;
  glfwGetTimerFrequency: function(): UInt64; cdecl;
  glfwMakeContextCurrent: procedure(window: PGLFWwindow); cdecl;
  glfwGetCurrentContext: function(): PGLFWwindow; cdecl;
  glfwSwapBuffers: procedure(window: PGLFWwindow); cdecl;
  glfwSwapInterval: procedure(interval: Integer); cdecl;
  glfwExtensionSupported: function(const extension: PUTF8Char): Integer; cdecl;
  glfwGetProcAddress: function(const procname: PUTF8Char): GLFWglproc; cdecl;
  glfwVulkanSupported: function(): Integer; cdecl;
  glfwGetRequiredInstanceExtensions: function(count: PUInt32): PPUTF8Char; cdecl;
  glfwGetWin32Adapter: function(monitor: PGLFWmonitor): PUTF8Char; cdecl;
  glfwGetWin32Monitor: function(monitor: PGLFWmonitor): PUTF8Char; cdecl;
  glfwGetWin32Window: function(window: PGLFWwindow): HWND; cdecl;
  alEnable: procedure(capability: ALenum); cdecl;
  alDisable: procedure(capability: ALenum); cdecl;
  alIsEnabled: function(capability: ALenum): ALboolean; cdecl;
  alDopplerFactor: procedure(value: ALfloat); cdecl;
  alDopplerVelocity: procedure(value: ALfloat); cdecl;
  alSpeedOfSound: procedure(value: ALfloat); cdecl;
  alDistanceModel: procedure(distanceModel: ALenum); cdecl;
  alGetString: function(param: ALenum): PALchar; cdecl;
  alGetBooleanv: procedure(param: ALenum; values: PALboolean); cdecl;
  alGetIntegerv: procedure(param: ALenum; values: PALint); cdecl;
  alGetFloatv: procedure(param: ALenum; values: PALfloat); cdecl;
  alGetDoublev: procedure(param: ALenum; values: PALdouble); cdecl;
  alGetBoolean: function(param: ALenum): ALboolean; cdecl;
  alGetInteger: function(param: ALenum): ALint; cdecl;
  alGetFloat: function(param: ALenum): ALfloat; cdecl;
  alGetDouble: function(param: ALenum): ALdouble; cdecl;
  alGetError: function(): ALenum; cdecl;
  alIsExtensionPresent: function(const extname: PALchar): ALboolean; cdecl;
  alGetProcAddress: function(const fname: PALchar): Pointer; cdecl;
  alGetEnumValue: function(const ename: PALchar): ALenum; cdecl;
  alListenerf: procedure(param: ALenum; value: ALfloat); cdecl;
  alListener3f: procedure(param: ALenum; value1: ALfloat; value2: ALfloat; value3: ALfloat); cdecl;
  alListenerfv: procedure(param: ALenum; const values: PALfloat); cdecl;
  alListeneri: procedure(param: ALenum; value: ALint); cdecl;
  alListener3i: procedure(param: ALenum; value1: ALint; value2: ALint; value3: ALint); cdecl;
  alListeneriv: procedure(param: ALenum; const values: PALint); cdecl;
  alGetListenerf: procedure(param: ALenum; value: PALfloat); cdecl;
  alGetListener3f: procedure(param: ALenum; value1: PALfloat; value2: PALfloat; value3: PALfloat); cdecl;
  alGetListenerfv: procedure(param: ALenum; values: PALfloat); cdecl;
  alGetListeneri: procedure(param: ALenum; value: PALint); cdecl;
  alGetListener3i: procedure(param: ALenum; value1: PALint; value2: PALint; value3: PALint); cdecl;
  alGetListeneriv: procedure(param: ALenum; values: PALint); cdecl;
  alGenSources: procedure(n: ALsizei; sources: PALuint); cdecl;
  alDeleteSources: procedure(n: ALsizei; const sources: PALuint); cdecl;
  alIsSource: function(source: ALuint): ALboolean; cdecl;
  alSourcef: procedure(source: ALuint; param: ALenum; value: ALfloat); cdecl;
  alSource3f: procedure(source: ALuint; param: ALenum; value1: ALfloat; value2: ALfloat; value3: ALfloat); cdecl;
  alSourcefv: procedure(source: ALuint; param: ALenum; const values: PALfloat); cdecl;
  alSourcei: procedure(source: ALuint; param: ALenum; value: ALint); cdecl;
  alSource3i: procedure(source: ALuint; param: ALenum; value1: ALint; value2: ALint; value3: ALint); cdecl;
  alSourceiv: procedure(source: ALuint; param: ALenum; const values: PALint); cdecl;
  alGetSourcef: procedure(source: ALuint; param: ALenum; value: PALfloat); cdecl;
  alGetSource3f: procedure(source: ALuint; param: ALenum; value1: PALfloat; value2: PALfloat; value3: PALfloat); cdecl;
  alGetSourcefv: procedure(source: ALuint; param: ALenum; values: PALfloat); cdecl;
  alGetSourcei: procedure(source: ALuint; param: ALenum; value: PALint); cdecl;
  alGetSource3i: procedure(source: ALuint; param: ALenum; value1: PALint; value2: PALint; value3: PALint); cdecl;
  alGetSourceiv: procedure(source: ALuint; param: ALenum; values: PALint); cdecl;
  alSourcePlay: procedure(source: ALuint); cdecl;
  alSourceStop: procedure(source: ALuint); cdecl;
  alSourceRewind: procedure(source: ALuint); cdecl;
  alSourcePause: procedure(source: ALuint); cdecl;
  alSourcePlayv: procedure(n: ALsizei; const sources: PALuint); cdecl;
  alSourceStopv: procedure(n: ALsizei; const sources: PALuint); cdecl;
  alSourceRewindv: procedure(n: ALsizei; const sources: PALuint); cdecl;
  alSourcePausev: procedure(n: ALsizei; const sources: PALuint); cdecl;
  alSourceQueueBuffers: procedure(source: ALuint; nb: ALsizei; const buffers: PALuint); cdecl;
  alSourceUnqueueBuffers: procedure(source: ALuint; nb: ALsizei; buffers: PALuint); cdecl;
  alGenBuffers: procedure(n: ALsizei; buffers: PALuint); cdecl;
  alDeleteBuffers: procedure(n: ALsizei; const buffers: PALuint); cdecl;
  alIsBuffer: function(buffer: ALuint): ALboolean; cdecl;
  alBufferData: procedure(buffer: ALuint; format: ALenum; const data: PALvoid; size: ALsizei; samplerate: ALsizei); cdecl;
  alBufferf: procedure(buffer: ALuint; param: ALenum; value: ALfloat); cdecl;
  alBuffer3f: procedure(buffer: ALuint; param: ALenum; value1: ALfloat; value2: ALfloat; value3: ALfloat); cdecl;
  alBufferfv: procedure(buffer: ALuint; param: ALenum; const values: PALfloat); cdecl;
  alBufferi: procedure(buffer: ALuint; param: ALenum; value: ALint); cdecl;
  alBuffer3i: procedure(buffer: ALuint; param: ALenum; value1: ALint; value2: ALint; value3: ALint); cdecl;
  alBufferiv: procedure(buffer: ALuint; param: ALenum; const values: PALint); cdecl;
  alGetBufferf: procedure(buffer: ALuint; param: ALenum; value: PALfloat); cdecl;
  alGetBuffer3f: procedure(buffer: ALuint; param: ALenum; value1: PALfloat; value2: PALfloat; value3: PALfloat); cdecl;
  alGetBufferfv: procedure(buffer: ALuint; param: ALenum; values: PALfloat); cdecl;
  alGetBufferi: procedure(buffer: ALuint; param: ALenum; value: PALint); cdecl;
  alGetBuffer3i: procedure(buffer: ALuint; param: ALenum; value1: PALint; value2: PALint; value3: PALint); cdecl;
  alGetBufferiv: procedure(buffer: ALuint; param: ALenum; values: PALint); cdecl;
  alcCreateContext: function(device: PALCdevice; const attrlist: PALCint): PALCcontext; cdecl;
  alcMakeContextCurrent: function(context: PALCcontext): ALCboolean; cdecl;
  alcProcessContext: procedure(context: PALCcontext); cdecl;
  alcSuspendContext: procedure(context: PALCcontext); cdecl;
  alcDestroyContext: procedure(context: PALCcontext); cdecl;
  alcGetCurrentContext: function(): PALCcontext; cdecl;
  alcGetContextsDevice: function(context: PALCcontext): PALCdevice; cdecl;
  alcOpenDevice: function(const devicename: PALCchar): PALCdevice; cdecl;
  alcCloseDevice: function(device: PALCdevice): ALCboolean; cdecl;
  alcGetError: function(device: PALCdevice): ALCenum; cdecl;
  alcIsExtensionPresent: function(device: PALCdevice; const extname: PALCchar): ALCboolean; cdecl;
  alcGetProcAddress: function(device: PALCdevice; const funcname: PALCchar): PALCvoid; cdecl;
  alcGetEnumValue: function(device: PALCdevice; const enumname: PALCchar): ALCenum; cdecl;
  alcGetString: function(device: PALCdevice; param: ALCenum): PALCchar; cdecl;
  alcGetIntegerv: procedure(device: PALCdevice; param: ALCenum; size: ALCsizei; values: PALCint); cdecl;
  alcCaptureOpenDevice: function(const devicename: PALCchar; frequency: ALCuint; format: ALCenum; buffersize: ALCsizei): PALCdevice; cdecl;
  alcCaptureCloseDevice: function(device: PALCdevice): ALCboolean; cdecl;
  alcCaptureStart: procedure(device: PALCdevice); cdecl;
  alcCaptureStop: procedure(device: PALCdevice); cdecl;
  alcCaptureSamples: procedure(device: PALCdevice; buffer: PALCvoid; samples: ALCsizei); cdecl;
  ov_clear: function(vf: POggVorbis_File): Integer; cdecl;
  ov_fopen: function(const path: PUTF8Char; vf: POggVorbis_File): Integer; cdecl;
  ov_open_callbacks: function(datasource: Pointer; vf: POggVorbis_File; const initial: PUTF8Char; ibytes: Integer; callbacks: ov_callbacks): Integer; cdecl;
  ov_test_callbacks: function(datasource: Pointer; vf: POggVorbis_File; const initial: PUTF8Char; ibytes: Integer; callbacks: ov_callbacks): Integer; cdecl;
  ov_test_open: function(vf: POggVorbis_File): Integer; cdecl;
  ov_bitrate: function(vf: POggVorbis_File; i: Integer): Integer; cdecl;
  ov_bitrate_instant: function(vf: POggVorbis_File): Integer; cdecl;
  ov_streams: function(vf: POggVorbis_File): Integer; cdecl;
  ov_seekable: function(vf: POggVorbis_File): Integer; cdecl;
  ov_serialnumber: function(vf: POggVorbis_File; i: Integer): Integer; cdecl;
  ov_raw_total: function(vf: POggVorbis_File; i: Integer): ogg_int64_t; cdecl;
  ov_pcm_total: function(vf: POggVorbis_File; i: Integer): ogg_int64_t; cdecl;
  ov_time_total: function(vf: POggVorbis_File; i: Integer): Double; cdecl;
  ov_raw_seek: function(vf: POggVorbis_File; pos: ogg_int64_t): Integer; cdecl;
  ov_pcm_seek: function(vf: POggVorbis_File; pos: ogg_int64_t): Integer; cdecl;
  ov_pcm_seek_page: function(vf: POggVorbis_File; pos: ogg_int64_t): Integer; cdecl;
  ov_time_seek: function(vf: POggVorbis_File; pos: Double): Integer; cdecl;
  ov_time_seek_page: function(vf: POggVorbis_File; pos: Double): Integer; cdecl;
  ov_raw_seek_lap: function(vf: POggVorbis_File; pos: ogg_int64_t): Integer; cdecl;
  ov_pcm_seek_lap: function(vf: POggVorbis_File; pos: ogg_int64_t): Integer; cdecl;
  ov_pcm_seek_page_lap: function(vf: POggVorbis_File; pos: ogg_int64_t): Integer; cdecl;
  ov_time_seek_lap: function(vf: POggVorbis_File; pos: Double): Integer; cdecl;
  ov_time_seek_page_lap: function(vf: POggVorbis_File; pos: Double): Integer; cdecl;
  ov_raw_tell: function(vf: POggVorbis_File): ogg_int64_t; cdecl;
  ov_pcm_tell: function(vf: POggVorbis_File): ogg_int64_t; cdecl;
  ov_time_tell: function(vf: POggVorbis_File): Double; cdecl;
  ov_info: function(vf: POggVorbis_File; link: Integer): Pvorbis_info; cdecl;
  ov_comment: function(vf: POggVorbis_File; link: Integer): Pvorbis_comment; cdecl;
  ov_read_float: function(vf: POggVorbis_File; pcm_channels: PPPSingle; samples: Integer; bitstream: PInteger): Integer; cdecl;
  ov_read_filter: function(vf: POggVorbis_File; buffer: PUTF8Char; length: Integer; bigendianp: Integer; &word: Integer; sgned: Integer; bitstream: PInteger; filter: ov_read_filter_filter; filter_param: Pointer): Integer; cdecl;
  ov_read: function(vf: POggVorbis_File; buffer: PUTF8Char; length: Integer; bigendianp: Integer; &word: Integer; sgned: Integer; bitstream: PInteger): Integer; cdecl;
  ov_crosslap: function(vf1: POggVorbis_File; vf2: POggVorbis_File): Integer; cdecl;
  ov_halfrate: function(vf: POggVorbis_File; flag: Integer): Integer; cdecl;
  ov_halfrate_p: function(vf: POggVorbis_File): Integer; cdecl;
  crc32: function(crc: uLong; const buf: PBytef; len: uInt): uLong; cdecl;
  unzOpen64: function(const path: Pointer): unzFile; cdecl;
  unzLocateFile: function(&file: unzFile; const szFileName: PUTF8Char; iCaseSensitivity: Integer): Integer; cdecl;
  unzClose: function(&file: unzFile): Integer; cdecl;
  unzOpenCurrentFilePassword: function(&file: unzFile; const password: PUTF8Char): Integer; cdecl;
  unzGetCurrentFileInfo64: function(&file: unzFile; pfile_info: Punz_file_info64; szFileName: PUTF8Char; fileNameBufferSize: uLong; extraField: Pointer; extraFieldBufferSize: uLong; szComment: PUTF8Char; commentBufferSize: uLong): Integer; cdecl;
  unzReadCurrentFile: function(&file: unzFile; buf: voidp; len: Cardinal): Integer; cdecl;
  unzCloseCurrentFile: function(&file: unzFile): Integer; cdecl;
  unztell64: function(&file: unzFile): UInt64; cdecl;
  zipOpen64: function(const pathname: Pointer; append: Integer): zipFile; cdecl;
  zipOpenNewFileInZip3_64: function(&file: zipFile; const filename: PUTF8Char; const zipfi: Pzip_fileinfo; const extrafield_local: Pointer; size_extrafield_local: uInt; const extrafield_global: Pointer; size_extrafield_global: uInt; const comment: PUTF8Char; method: Integer; level: Integer; raw: Integer; windowBits: Integer; memLevel: Integer; strategy: Integer; const password: PUTF8Char; crcForCrypting: uLong; zip64: Integer): Integer; cdecl;
  zipWriteInFileInZip: function(&file: zipFile; const buf: Pointer; len: Cardinal): Integer; cdecl;
  zipCloseFileInZip: function(&file: zipFile): Integer; cdecl;
  zipClose: function(&file: zipFile; const global_comment: PUTF8Char): Integer; cdecl;
  c2CircletoCircle: function(A: c2Circle; B: c2Circle): Integer; cdecl;
  c2CircletoAABB: function(A: c2Circle; B: c2AABB): Integer; cdecl;
  c2CircletoCapsule: function(A: c2Circle; B: c2Capsule): Integer; cdecl;
  c2AABBtoAABB: function(A: c2AABB; B: c2AABB): Integer; cdecl;
  c2AABBtoCapsule: function(A: c2AABB; B: c2Capsule): Integer; cdecl;
  c2CapsuletoCapsule: function(A: c2Capsule; B: c2Capsule): Integer; cdecl;
  c2CircletoPoly: function(A: c2Circle; const B: Pc2Poly; const bx: Pc2x): Integer; cdecl;
  c2AABBtoPoly: function(A: c2AABB; const B: Pc2Poly; const bx: Pc2x): Integer; cdecl;
  c2CapsuletoPoly: function(A: c2Capsule; const B: Pc2Poly; const bx: Pc2x): Integer; cdecl;
  c2PolytoPoly: function(const A: Pc2Poly; const ax: Pc2x; const B: Pc2Poly; const bx: Pc2x): Integer; cdecl;
  c2RaytoCircle: function(A: c2Ray; B: c2Circle; &out: Pc2Raycast): Integer; cdecl;
  c2RaytoAABB: function(A: c2Ray; B: c2AABB; &out: Pc2Raycast): Integer; cdecl;
  c2RaytoCapsule: function(A: c2Ray; B: c2Capsule; &out: Pc2Raycast): Integer; cdecl;
  c2RaytoPoly: function(A: c2Ray; const B: Pc2Poly; const bx_ptr: Pc2x; &out: Pc2Raycast): Integer; cdecl;
  c2CircletoCircleManifold: procedure(A: c2Circle; B: c2Circle; m: Pc2Manifold); cdecl;
  c2CircletoAABBManifold: procedure(A: c2Circle; B: c2AABB; m: Pc2Manifold); cdecl;
  c2CircletoCapsuleManifold: procedure(A: c2Circle; B: c2Capsule; m: Pc2Manifold); cdecl;
  c2AABBtoAABBManifold: procedure(A: c2AABB; B: c2AABB; m: Pc2Manifold); cdecl;
  c2AABBtoCapsuleManifold: procedure(A: c2AABB; B: c2Capsule; m: Pc2Manifold); cdecl;
  c2CapsuletoCapsuleManifold: procedure(A: c2Capsule; B: c2Capsule; m: Pc2Manifold); cdecl;
  c2CircletoPolyManifold: procedure(A: c2Circle; const B: Pc2Poly; const bx: Pc2x; m: Pc2Manifold); cdecl;
  c2AABBtoPolyManifold: procedure(A: c2AABB; const B: Pc2Poly; const bx: Pc2x; m: Pc2Manifold); cdecl;
  c2CapsuletoPolyManifold: procedure(A: c2Capsule; const B: Pc2Poly; const bx: Pc2x; m: Pc2Manifold); cdecl;
  c2PolytoPolyManifold: procedure(const A: Pc2Poly; const ax: Pc2x; const B: Pc2Poly; const bx: Pc2x; m: Pc2Manifold); cdecl;
  c2GJK: function(const A: Pointer; typeA: C2_TYPE; const ax_ptr: Pc2x; const B: Pointer; typeB: C2_TYPE; const bx_ptr: Pc2x; outA: Pc2v; outB: Pc2v; use_radius: Integer; iterations: PInteger; cache: Pc2GJKCache): Single; cdecl;
  c2TOI: function(const A: Pointer; typeA: C2_TYPE; const ax_ptr: Pc2x; vA: c2v; const B: Pointer; typeB: C2_TYPE; const bx_ptr: Pc2x; vB: c2v; use_radius: Integer): c2TOIResult; cdecl;
  c2Inflate: procedure(shape: Pointer; &type: C2_TYPE; skin_factor: Single); cdecl;
  c2Hull: function(verts: Pc2v; count: Integer): Integer; cdecl;
  c2Norms: procedure(verts: Pc2v; norms: Pc2v; count: Integer); cdecl;
  c2MakePoly: procedure(p: Pc2Poly); cdecl;
  c2Collided: function(const A: Pointer; const ax: Pc2x; typeA: C2_TYPE; const B: Pointer; const bx: Pc2x; typeB: C2_TYPE): Integer; cdecl;
  c2Collide: procedure(const A: Pointer; const ax: Pc2x; typeA: C2_TYPE; const B: Pointer; const bx: Pc2x; typeB: C2_TYPE; m: Pc2Manifold); cdecl;
  c2CastRay: function(A: c2Ray; const B: Pointer; const bx: Pc2x; typeB: C2_TYPE; &out: Pc2Raycast): Integer; cdecl;
  plm_create_with_filename: function(const filename: PUTF8Char): Pplm_t; cdecl;
  plm_create_with_file: function(fh: PPointer; close_when_done: Integer): Pplm_t; cdecl;
  plm_create_with_memory: function(bytes: PUInt8; length: NativeUInt; free_when_done: Integer): Pplm_t; cdecl;
  plm_create_with_buffer: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_t; cdecl;
  plm_destroy: procedure(self: Pplm_t); cdecl;
  plm_has_headers: function(self: Pplm_t): Integer; cdecl;
  plm_get_video_enabled: function(self: Pplm_t): Integer; cdecl;
  plm_set_video_enabled: procedure(self: Pplm_t; enabled: Integer); cdecl;
  plm_get_num_video_streams: function(self: Pplm_t): Integer; cdecl;
  plm_get_width: function(self: Pplm_t): Integer; cdecl;
  plm_get_height: function(self: Pplm_t): Integer; cdecl;
  plm_get_framerate: function(self: Pplm_t): Double; cdecl;
  plm_get_audio_enabled: function(self: Pplm_t): Integer; cdecl;
  plm_set_audio_enabled: procedure(self: Pplm_t; enabled: Integer); cdecl;
  plm_get_num_audio_streams: function(self: Pplm_t): Integer; cdecl;
  plm_set_audio_stream: procedure(self: Pplm_t; stream_index: Integer); cdecl;
  plm_get_samplerate: function(self: Pplm_t): Integer; cdecl;
  plm_get_audio_lead_time: function(self: Pplm_t): Double; cdecl;
  plm_set_audio_lead_time: procedure(self: Pplm_t; lead_time: Double); cdecl;
  plm_get_time: function(self: Pplm_t): Double; cdecl;
  plm_get_duration: function(self: Pplm_t): Double; cdecl;
  plm_rewind: procedure(self: Pplm_t); cdecl;
  plm_get_loop: function(self: Pplm_t): Integer; cdecl;
  plm_set_loop: procedure(self: Pplm_t; loop: Integer); cdecl;
  plm_has_ended: function(self: Pplm_t): Integer; cdecl;
  plm_set_video_decode_callback: procedure(self: Pplm_t; fp: plm_video_decode_callback; user: Pointer); cdecl;
  plm_set_audio_decode_callback: procedure(self: Pplm_t; fp: plm_audio_decode_callback; user: Pointer); cdecl;
  plm_decode: procedure(self: Pplm_t; seconds: Double); cdecl;
  plm_decode_video: function(self: Pplm_t): Pplm_frame_t; cdecl;
  plm_decode_audio: function(self: Pplm_t): Pplm_samples_t; cdecl;
  plm_seek: function(self: Pplm_t; time: Double; seek_exact: Integer): Integer; cdecl;
  plm_seek_frame: function(self: Pplm_t; time: Double; seek_exact: Integer): Pplm_frame_t; cdecl;
  plm_buffer_create_with_filename: function(const filename: PUTF8Char): Pplm_buffer_t; cdecl;
  plm_buffer_create_with_file: function(fh: PPointer; close_when_done: Integer): Pplm_buffer_t; cdecl;
  plm_buffer_create_with_memory: function(bytes: PUInt8; length: NativeUInt; free_when_done: Integer): Pplm_buffer_t; cdecl;
  plm_buffer_create_with_capacity: function(capacity: NativeUInt): Pplm_buffer_t; cdecl;
  plm_buffer_create_for_appending: function(initial_capacity: NativeUInt): Pplm_buffer_t; cdecl;
  plm_buffer_destroy: procedure(self: Pplm_buffer_t); cdecl;
  plm_buffer_write: function(self: Pplm_buffer_t; bytes: PUInt8; length: NativeUInt): NativeUInt; cdecl;
  plm_buffer_signal_end: procedure(self: Pplm_buffer_t); cdecl;
  plm_buffer_set_load_callback: procedure(self: Pplm_buffer_t; fp: plm_buffer_load_callback; user: Pointer); cdecl;
  plm_buffer_rewind: procedure(self: Pplm_buffer_t); cdecl;
  plm_buffer_get_size: function(self: Pplm_buffer_t): NativeUInt; cdecl;
  plm_buffer_get_remaining: function(self: Pplm_buffer_t): NativeUInt; cdecl;
  plm_buffer_has_ended: function(self: Pplm_buffer_t): Integer; cdecl;
  plm_demux_create: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_demux_t; cdecl;
  plm_demux_destroy: procedure(self: Pplm_demux_t); cdecl;
  plm_demux_has_headers: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_get_num_video_streams: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_get_num_audio_streams: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_rewind: procedure(self: Pplm_demux_t); cdecl;
  plm_demux_has_ended: function(self: Pplm_demux_t): Integer; cdecl;
  plm_demux_seek: function(self: Pplm_demux_t; time: Double; &type: Integer; force_intra: Integer): Pplm_packet_t; cdecl;
  plm_demux_get_start_time: function(self: Pplm_demux_t; &type: Integer): Double; cdecl;
  plm_demux_get_duration: function(self: Pplm_demux_t; &type: Integer): Double; cdecl;
  plm_demux_decode: function(self: Pplm_demux_t): Pplm_packet_t; cdecl;
  plm_video_create_with_buffer: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_video_t; cdecl;
  plm_video_destroy: procedure(self: Pplm_video_t); cdecl;
  plm_video_has_header: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_get_framerate: function(self: Pplm_video_t): Double; cdecl;
  plm_video_get_width: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_get_height: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_set_no_delay: procedure(self: Pplm_video_t; no_delay: Integer); cdecl;
  plm_video_get_time: function(self: Pplm_video_t): Double; cdecl;
  plm_video_set_time: procedure(self: Pplm_video_t; time: Double); cdecl;
  plm_video_rewind: procedure(self: Pplm_video_t); cdecl;
  plm_video_has_ended: function(self: Pplm_video_t): Integer; cdecl;
  plm_video_decode: function(self: Pplm_video_t): Pplm_frame_t; cdecl;
  plm_frame_to_rgb: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_bgr: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_rgba: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_bgra: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_argb: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_frame_to_abgr: procedure(frame: Pplm_frame_t; dest: PUInt8; stride: Integer); cdecl;
  plm_audio_create_with_buffer: function(buffer: Pplm_buffer_t; destroy_when_done: Integer): Pplm_audio_t; cdecl;
  plm_audio_destroy: procedure(self: Pplm_audio_t); cdecl;
  plm_audio_has_header: function(self: Pplm_audio_t): Integer; cdecl;
  plm_audio_get_samplerate: function(self: Pplm_audio_t): Integer; cdecl;
  plm_audio_get_time: function(self: Pplm_audio_t): Double; cdecl;
  plm_audio_set_time: procedure(self: Pplm_audio_t; time: Double); cdecl;
  plm_audio_rewind: procedure(self: Pplm_audio_t); cdecl;
  plm_audio_has_ended: function(self: Pplm_audio_t): Integer; cdecl;
  plm_audio_decode: function(self: Pplm_audio_t): Pplm_samples_t; cdecl;
  stbi_load_from_memory: function(const buffer: Pstbi_uc; len: Integer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_uc; cdecl;
  stbi_load_from_callbacks: function(const clbk: Pstbi_io_callbacks; user: Pointer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_uc; cdecl;
  stbi_load: function(const filename: PUTF8Char; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_uc; cdecl;
  stbi_load_from_file: function(f: PPointer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_uc; cdecl;
  stbi_load_gif_from_memory: function(const buffer: Pstbi_uc; len: Integer; delays: PPInteger; x: PInteger; y: PInteger; z: PInteger; comp: PInteger; req_comp: Integer): Pstbi_uc; cdecl;
  stbi_load_16_from_memory: function(const buffer: Pstbi_uc; len: Integer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_us; cdecl;
  stbi_load_16_from_callbacks: function(const clbk: Pstbi_io_callbacks; user: Pointer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_us; cdecl;
  stbi_load_16: function(const filename: PUTF8Char; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_us; cdecl;
  stbi_load_from_file_16: function(f: PPointer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): Pstbi_us; cdecl;
  stbi_loadf_from_memory: function(const buffer: Pstbi_uc; len: Integer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): PSingle; cdecl;
  stbi_loadf_from_callbacks: function(const clbk: Pstbi_io_callbacks; user: Pointer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): PSingle; cdecl;
  stbi_loadf: function(const filename: PUTF8Char; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): PSingle; cdecl;
  stbi_loadf_from_file: function(f: PPointer; x: PInteger; y: PInteger; channels_in_file: PInteger; desired_channels: Integer): PSingle; cdecl;
  stbi_hdr_to_ldr_gamma: procedure(gamma: Single); cdecl;
  stbi_hdr_to_ldr_scale: procedure(scale: Single); cdecl;
  stbi_ldr_to_hdr_gamma: procedure(gamma: Single); cdecl;
  stbi_ldr_to_hdr_scale: procedure(scale: Single); cdecl;
  stbi_is_hdr_from_callbacks: function(const clbk: Pstbi_io_callbacks; user: Pointer): Integer; cdecl;
  stbi_is_hdr_from_memory: function(const buffer: Pstbi_uc; len: Integer): Integer; cdecl;
  stbi_is_hdr: function(const filename: PUTF8Char): Integer; cdecl;
  stbi_is_hdr_from_file: function(f: PPointer): Integer; cdecl;
  stbi_failure_reason: function(): PUTF8Char; cdecl;
  stbi_image_free: procedure(retval_from_stbi_load: Pointer); cdecl;
  stbi_info_from_memory: function(const buffer: Pstbi_uc; len: Integer; x: PInteger; y: PInteger; comp: PInteger): Integer; cdecl;
  stbi_info_from_callbacks: function(const clbk: Pstbi_io_callbacks; user: Pointer; x: PInteger; y: PInteger; comp: PInteger): Integer; cdecl;
  stbi_is_16_bit_from_memory: function(const buffer: Pstbi_uc; len: Integer): Integer; cdecl;
  stbi_is_16_bit_from_callbacks: function(const clbk: Pstbi_io_callbacks; user: Pointer): Integer; cdecl;
  stbi_info: function(const filename: PUTF8Char; x: PInteger; y: PInteger; comp: PInteger): Integer; cdecl;
  stbi_info_from_file: function(f: PPointer; x: PInteger; y: PInteger; comp: PInteger): Integer; cdecl;
  stbi_is_16_bit: function(const filename: PUTF8Char): Integer; cdecl;
  stbi_is_16_bit_from_file: function(f: PPointer): Integer; cdecl;
  stbi_set_unpremultiply_on_load: procedure(flag_true_if_should_unpremultiply: Integer); cdecl;
  stbi_convert_iphone_png_to_rgb: procedure(flag_true_if_should_convert: Integer); cdecl;
  stbi_set_flip_vertically_on_load: procedure(flag_true_if_should_flip: Integer); cdecl;
  stbi_set_unpremultiply_on_load_thread: procedure(flag_true_if_should_unpremultiply: Integer); cdecl;
  stbi_convert_iphone_png_to_rgb_thread: procedure(flag_true_if_should_convert: Integer); cdecl;
  stbi_set_flip_vertically_on_load_thread: procedure(flag_true_if_should_flip: Integer); cdecl;
  stbi_zlib_decode_malloc_guesssize: function(const buffer: PUTF8Char; len: Integer; initial_size: Integer; outlen: PInteger): PUTF8Char; cdecl;
  stbi_zlib_decode_malloc_guesssize_headerflag: function(const buffer: PUTF8Char; len: Integer; initial_size: Integer; outlen: PInteger; parse_header: Integer): PUTF8Char; cdecl;
  stbi_zlib_decode_malloc: function(const buffer: PUTF8Char; len: Integer; outlen: PInteger): PUTF8Char; cdecl;
  stbi_zlib_decode_buffer: function(obuffer: PUTF8Char; olen: Integer; const ibuffer: PUTF8Char; ilen: Integer): Integer; cdecl;
  stbi_zlib_decode_noheader_malloc: function(const buffer: PUTF8Char; len: Integer; outlen: PInteger): PUTF8Char; cdecl;
  stbi_zlib_decode_noheader_buffer: function(obuffer: PUTF8Char; olen: Integer; const ibuffer: PUTF8Char; ilen: Integer): Integer; cdecl;
  stbi_write_png: function(const filename: PUTF8Char; w: Integer; h: Integer; comp: Integer; const data: Pointer; stride_in_bytes: Integer): Integer; cdecl;
  stbi_write_bmp: function(const filename: PUTF8Char; w: Integer; h: Integer; comp: Integer; const data: Pointer): Integer; cdecl;
  stbi_write_tga: function(const filename: PUTF8Char; w: Integer; h: Integer; comp: Integer; const data: Pointer): Integer; cdecl;
  stbi_write_hdr: function(const filename: PUTF8Char; w: Integer; h: Integer; comp: Integer; const data: PSingle): Integer; cdecl;
  stbi_write_jpg: function(const filename: PUTF8Char; x: Integer; y: Integer; comp: Integer; const data: Pointer; quality: Integer): Integer; cdecl;
  stbi_write_png_to_func: function(func: Pstbi_write_func; context: Pointer; w: Integer; h: Integer; comp: Integer; const data: Pointer; stride_in_bytes: Integer): Integer; cdecl;
  stbi_write_bmp_to_func: function(func: Pstbi_write_func; context: Pointer; w: Integer; h: Integer; comp: Integer; const data: Pointer): Integer; cdecl;
  stbi_write_tga_to_func: function(func: Pstbi_write_func; context: Pointer; w: Integer; h: Integer; comp: Integer; const data: Pointer): Integer; cdecl;
  stbi_write_hdr_to_func: function(func: Pstbi_write_func; context: Pointer; w: Integer; h: Integer; comp: Integer; const data: PSingle): Integer; cdecl;
  stbi_write_jpg_to_func: function(func: Pstbi_write_func; context: Pointer; x: Integer; y: Integer; comp: Integer; const data: Pointer; quality: Integer): Integer; cdecl;
  stbi_flip_vertically_on_write: procedure(flip_boolean: Integer); cdecl;
  stbtt_BakeFontBitmap: function(const data: PByte; offset: Integer; pixel_height: Single; pixels: PByte; pw: Integer; ph: Integer; first_char: Integer; num_chars: Integer; chardata: Pstbtt_bakedchar): Integer; cdecl;
  stbtt_GetBakedQuad: procedure(const chardata: Pstbtt_bakedchar; pw: Integer; ph: Integer; char_index: Integer; xpos: PSingle; ypos: PSingle; q: Pstbtt_aligned_quad; opengl_fillrule: Integer); cdecl;
  stbtt_GetScaledFontVMetrics: procedure(const fontdata: PByte; index: Integer; size: Single; ascent: PSingle; descent: PSingle; lineGap: PSingle); cdecl;
  stbtt_PackBegin: function(spc: Pstbtt_pack_context; pixels: PByte; width: Integer; height: Integer; stride_in_bytes: Integer; padding: Integer; alloc_context: Pointer): Integer; cdecl;
  stbtt_PackEnd: procedure(spc: Pstbtt_pack_context); cdecl;
  stbtt_PackFontRange: function(spc: Pstbtt_pack_context; const fontdata: PByte; font_index: Integer; font_size: Single; first_unicode_char_in_range: Integer; num_chars_in_range: Integer; chardata_for_range: Pstbtt_packedchar): Integer; cdecl;
  stbtt_PackFontRanges: function(spc: Pstbtt_pack_context; const fontdata: PByte; font_index: Integer; ranges: Pstbtt_pack_range; num_ranges: Integer): Integer; cdecl;
  stbtt_PackSetOversampling: procedure(spc: Pstbtt_pack_context; h_oversample: Cardinal; v_oversample: Cardinal); cdecl;
  stbtt_PackSetSkipMissingCodepoints: procedure(spc: Pstbtt_pack_context; skip: Integer); cdecl;
  stbtt_GetPackedQuad: procedure(const chardata: Pstbtt_packedchar; pw: Integer; ph: Integer; char_index: Integer; xpos: PSingle; ypos: PSingle; q: Pstbtt_aligned_quad; align_to_integer: Integer); cdecl;
  stbtt_PackFontRangesGatherRects: function(spc: Pstbtt_pack_context; const info: Pstbtt_fontinfo; ranges: Pstbtt_pack_range; num_ranges: Integer; rects: Pstbrp_rect): Integer; cdecl;
  stbtt_PackFontRangesPackRects: procedure(spc: Pstbtt_pack_context; rects: Pstbrp_rect; num_rects: Integer); cdecl;
  stbtt_PackFontRangesRenderIntoRects: function(spc: Pstbtt_pack_context; const info: Pstbtt_fontinfo; ranges: Pstbtt_pack_range; num_ranges: Integer; rects: Pstbrp_rect): Integer; cdecl;
  stbtt_GetNumberOfFonts: function(const data: PByte): Integer; cdecl;
  stbtt_GetFontOffsetForIndex: function(const data: PByte; index: Integer): Integer; cdecl;
  stbtt_InitFont: function(info: Pstbtt_fontinfo; const data: PByte; offset: Integer): Integer; cdecl;
  stbtt_FindGlyphIndex: function(const info: Pstbtt_fontinfo; unicode_codepoint: Integer): Integer; cdecl;
  stbtt_ScaleForPixelHeight: function(const info: Pstbtt_fontinfo; pixels: Single): Single; cdecl;
  stbtt_ScaleForMappingEmToPixels: function(const info: Pstbtt_fontinfo; pixels: Single): Single; cdecl;
  stbtt_GetFontVMetrics: procedure(const info: Pstbtt_fontinfo; ascent: PInteger; descent: PInteger; lineGap: PInteger); cdecl;
  stbtt_GetFontVMetricsOS2: function(const info: Pstbtt_fontinfo; typoAscent: PInteger; typoDescent: PInteger; typoLineGap: PInteger): Integer; cdecl;
  stbtt_GetFontBoundingBox: procedure(const info: Pstbtt_fontinfo; x0: PInteger; y0: PInteger; x1: PInteger; y1: PInteger); cdecl;
  stbtt_GetCodepointHMetrics: procedure(const info: Pstbtt_fontinfo; codepoint: Integer; advanceWidth: PInteger; leftSideBearing: PInteger); cdecl;
  stbtt_GetCodepointKernAdvance: function(const info: Pstbtt_fontinfo; ch1: Integer; ch2: Integer): Integer; cdecl;
  stbtt_GetCodepointBox: function(const info: Pstbtt_fontinfo; codepoint: Integer; x0: PInteger; y0: PInteger; x1: PInteger; y1: PInteger): Integer; cdecl;
  stbtt_GetGlyphHMetrics: procedure(const info: Pstbtt_fontinfo; glyph_index: Integer; advanceWidth: PInteger; leftSideBearing: PInteger); cdecl;
  stbtt_GetGlyphKernAdvance: function(const info: Pstbtt_fontinfo; glyph1: Integer; glyph2: Integer): Integer; cdecl;
  stbtt_GetGlyphBox: function(const info: Pstbtt_fontinfo; glyph_index: Integer; x0: PInteger; y0: PInteger; x1: PInteger; y1: PInteger): Integer; cdecl;
  stbtt_GetKerningTableLength: function(const info: Pstbtt_fontinfo): Integer; cdecl;
  stbtt_GetKerningTable: function(const info: Pstbtt_fontinfo; table: Pstbtt_kerningentry; table_length: Integer): Integer; cdecl;
  stbtt_IsGlyphEmpty: function(const info: Pstbtt_fontinfo; glyph_index: Integer): Integer; cdecl;
  stbtt_GetCodepointShape: function(const info: Pstbtt_fontinfo; unicode_codepoint: Integer; vertices: PPstbtt_vertex): Integer; cdecl;
  stbtt_GetGlyphShape: function(const info: Pstbtt_fontinfo; glyph_index: Integer; vertices: PPstbtt_vertex): Integer; cdecl;
  stbtt_FreeShape: procedure(const info: Pstbtt_fontinfo; vertices: Pstbtt_vertex); cdecl;
  stbtt_FindSVGDoc: function(const info: Pstbtt_fontinfo; gl: Integer): PByte; cdecl;
  stbtt_GetCodepointSVG: function(const info: Pstbtt_fontinfo; unicode_codepoint: Integer; svg: PPUTF8Char): Integer; cdecl;
  stbtt_GetGlyphSVG: function(const info: Pstbtt_fontinfo; gl: Integer; svg: PPUTF8Char): Integer; cdecl;
  stbtt_FreeBitmap: procedure(bitmap: PByte; userdata: Pointer); cdecl;
  stbtt_GetCodepointBitmap: function(const info: Pstbtt_fontinfo; scale_x: Single; scale_y: Single; codepoint: Integer; width: PInteger; height: PInteger; xoff: PInteger; yoff: PInteger): PByte; cdecl;
  stbtt_GetCodepointBitmapSubpixel: function(const info: Pstbtt_fontinfo; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; codepoint: Integer; width: PInteger; height: PInteger; xoff: PInteger; yoff: PInteger): PByte; cdecl;
  stbtt_MakeCodepointBitmap: procedure(const info: Pstbtt_fontinfo; output: PByte; out_w: Integer; out_h: Integer; out_stride: Integer; scale_x: Single; scale_y: Single; codepoint: Integer); cdecl;
  stbtt_MakeCodepointBitmapSubpixel: procedure(const info: Pstbtt_fontinfo; output: PByte; out_w: Integer; out_h: Integer; out_stride: Integer; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; codepoint: Integer); cdecl;
  stbtt_MakeCodepointBitmapSubpixelPrefilter: procedure(const info: Pstbtt_fontinfo; output: PByte; out_w: Integer; out_h: Integer; out_stride: Integer; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; oversample_x: Integer; oversample_y: Integer; sub_x: PSingle; sub_y: PSingle; codepoint: Integer); cdecl;
  stbtt_GetCodepointBitmapBox: procedure(const font: Pstbtt_fontinfo; codepoint: Integer; scale_x: Single; scale_y: Single; ix0: PInteger; iy0: PInteger; ix1: PInteger; iy1: PInteger); cdecl;
  stbtt_GetCodepointBitmapBoxSubpixel: procedure(const font: Pstbtt_fontinfo; codepoint: Integer; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; ix0: PInteger; iy0: PInteger; ix1: PInteger; iy1: PInteger); cdecl;
  stbtt_GetGlyphBitmap: function(const info: Pstbtt_fontinfo; scale_x: Single; scale_y: Single; glyph: Integer; width: PInteger; height: PInteger; xoff: PInteger; yoff: PInteger): PByte; cdecl;
  stbtt_GetGlyphBitmapSubpixel: function(const info: Pstbtt_fontinfo; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; glyph: Integer; width: PInteger; height: PInteger; xoff: PInteger; yoff: PInteger): PByte; cdecl;
  stbtt_MakeGlyphBitmap: procedure(const info: Pstbtt_fontinfo; output: PByte; out_w: Integer; out_h: Integer; out_stride: Integer; scale_x: Single; scale_y: Single; glyph: Integer); cdecl;
  stbtt_MakeGlyphBitmapSubpixel: procedure(const info: Pstbtt_fontinfo; output: PByte; out_w: Integer; out_h: Integer; out_stride: Integer; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; glyph: Integer); cdecl;
  stbtt_MakeGlyphBitmapSubpixelPrefilter: procedure(const info: Pstbtt_fontinfo; output: PByte; out_w: Integer; out_h: Integer; out_stride: Integer; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; oversample_x: Integer; oversample_y: Integer; sub_x: PSingle; sub_y: PSingle; glyph: Integer); cdecl;
  stbtt_GetGlyphBitmapBox: procedure(const font: Pstbtt_fontinfo; glyph: Integer; scale_x: Single; scale_y: Single; ix0: PInteger; iy0: PInteger; ix1: PInteger; iy1: PInteger); cdecl;
  stbtt_GetGlyphBitmapBoxSubpixel: procedure(const font: Pstbtt_fontinfo; glyph: Integer; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; ix0: PInteger; iy0: PInteger; ix1: PInteger; iy1: PInteger); cdecl;
  stbtt_Rasterize: procedure(result: Pstbtt__bitmap; flatness_in_pixels: Single; vertices: Pstbtt_vertex; num_verts: Integer; scale_x: Single; scale_y: Single; shift_x: Single; shift_y: Single; x_off: Integer; y_off: Integer; invert: Integer; userdata: Pointer); cdecl;
  stbtt_FreeSDF: procedure(bitmap: PByte; userdata: Pointer); cdecl;
  stbtt_GetGlyphSDF: function(const info: Pstbtt_fontinfo; scale: Single; glyph: Integer; padding: Integer; onedge_value: Byte; pixel_dist_scale: Single; width: PInteger; height: PInteger; xoff: PInteger; yoff: PInteger): PByte; cdecl;
  stbtt_GetCodepointSDF: function(const info: Pstbtt_fontinfo; scale: Single; codepoint: Integer; padding: Integer; onedge_value: Byte; pixel_dist_scale: Single; width: PInteger; height: PInteger; xoff: PInteger; yoff: PInteger): PByte; cdecl;
  stbtt_FindMatchingFont: function(const fontdata: PByte; const name: PUTF8Char; flags: Integer): Integer; cdecl;
  stbtt_CompareUTF8toUTF16_bigendian: function(const s1: PUTF8Char; len1: Integer; const s2: PUTF8Char; len2: Integer): Integer; cdecl;
  stbtt_GetFontNameString: function(const font: Pstbtt_fontinfo; length: PInteger; platformID: Integer; encodingID: Integer; languageID: Integer; nameID: Integer): PUTF8Char; cdecl;
  clog_init_path: function(id: Integer; const path: PUTF8Char): Integer; cdecl;
  clog_free: procedure(id: Integer); cdecl;
  clog_debug: procedure(const sfile: PUTF8Char; sline: Integer; id: Integer; const fmt: PUTF8Char) varargs; cdecl;
  clog_info: procedure(const sfile: PUTF8Char; sline: Integer; id: Integer; const fmt: PUTF8Char) varargs; cdecl;
  clog_warn: procedure(const sfile: PUTF8Char; sline: Integer; id: Integer; const fmt: PUTF8Char) varargs; cdecl;
  clog_error: procedure(const sfile: PUTF8Char; sline: Integer; id: Integer; const fmt: PUTF8Char) varargs; cdecl;
  clog_set_level: function(id: Integer; level: clog_level): Integer; cdecl;
  clog_set_time_fmt: function(id: Integer; const fmt: PUTF8Char): Integer; cdecl;
  clog_set_date_fmt: function(id: Integer; const fmt: PUTF8Char): Integer; cdecl;
  clog_set_fmt: function(id: Integer; const fmt: PUTF8Char): Integer; cdecl;
  nk_init_default: function(p1: Pnk_context; const p2: Pnk_user_font): nk_bool; cdecl;
  nk_init_fixed: function(p1: Pnk_context; memory: Pointer; size: nk_size; const p4: Pnk_user_font): nk_bool; cdecl;
  nk_init: function(p1: Pnk_context; p2: Pnk_allocator; const p3: Pnk_user_font): nk_bool; cdecl;
  nk_init_custom: function(p1: Pnk_context; cmds: Pnk_buffer; pool: Pnk_buffer; const p4: Pnk_user_font): nk_bool; cdecl;
  nk_clear: procedure(p1: Pnk_context); cdecl;
  nk_free: procedure(p1: Pnk_context); cdecl;
  nk_input_begin: procedure(p1: Pnk_context); cdecl;
  nk_input_motion: procedure(p1: Pnk_context; x: Integer; y: Integer); cdecl;
  nk_input_key: procedure(p1: Pnk_context; p2: nk_keys; down: nk_bool); cdecl;
  nk_input_button: procedure(p1: Pnk_context; p2: nk_buttons; x: Integer; y: Integer; down: nk_bool); cdecl;
  nk_input_scroll: procedure(p1: Pnk_context; val: nk_vec2); cdecl;
  nk_input_char: procedure(p1: Pnk_context; p2: UTF8Char); cdecl;
  nk_input_glyph: procedure(p1: Pnk_context; const p2: nk_glyph); cdecl;
  nk_input_unicode: procedure(p1: Pnk_context; p2: nk_rune); cdecl;
  nk_input_end: procedure(p1: Pnk_context); cdecl;
  nk__begin: function(p1: Pnk_context): Pnk_command; cdecl;
  nk__next: function(p1: Pnk_context; const p2: Pnk_command): Pnk_command; cdecl;
  nk_convert: function(p1: Pnk_context; cmds: Pnk_buffer; vertices: Pnk_buffer; elements: Pnk_buffer; const p5: Pnk_convert_config): nk_flags; cdecl;
  nk__draw_begin: function(const p1: Pnk_context; const p2: Pnk_buffer): Pnk_draw_command; cdecl;
  nk__draw_end: function(const p1: Pnk_context; const p2: Pnk_buffer): Pnk_draw_command; cdecl;
  nk__draw_next: function(const p1: Pnk_draw_command; const p2: Pnk_buffer; const p3: Pnk_context): Pnk_draw_command; cdecl;
  nk_begin: function(ctx: Pnk_context; const title: PUTF8Char; bounds: nk_rect; flags: nk_flags): nk_bool; cdecl;
  nk_begin_titled: function(ctx: Pnk_context; const name: PUTF8Char; const title: PUTF8Char; bounds: nk_rect; flags: nk_flags): nk_bool; cdecl;
  nk_end: procedure(ctx: Pnk_context); cdecl;
  nk_window_find: function(ctx: Pnk_context; const name: PUTF8Char): Pnk_window; cdecl;
  nk_window_get_bounds: function(const ctx: Pnk_context): nk_rect; cdecl;
  nk_window_get_position: function(const ctx: Pnk_context): nk_vec2; cdecl;
  nk_window_get_size: function(const p1: Pnk_context): nk_vec2; cdecl;
  nk_window_get_width: function(const p1: Pnk_context): Single; cdecl;
  nk_window_get_height: function(const p1: Pnk_context): Single; cdecl;
  nk_window_get_panel: function(p1: Pnk_context): Pnk_panel; cdecl;
  nk_window_get_content_region: function(p1: Pnk_context): nk_rect; cdecl;
  nk_window_get_content_region_min: function(p1: Pnk_context): nk_vec2; cdecl;
  nk_window_get_content_region_max: function(p1: Pnk_context): nk_vec2; cdecl;
  nk_window_get_content_region_size: function(p1: Pnk_context): nk_vec2; cdecl;
  nk_window_get_canvas: function(p1: Pnk_context): Pnk_command_buffer; cdecl;
  nk_window_get_scroll: procedure(p1: Pnk_context; offset_x: Pnk_uint; offset_y: Pnk_uint); cdecl;
  nk_window_has_focus: function(const p1: Pnk_context): nk_bool; cdecl;
  nk_window_is_hovered: function(p1: Pnk_context): nk_bool; cdecl;
  nk_window_is_collapsed: function(ctx: Pnk_context; const name: PUTF8Char): nk_bool; cdecl;
  nk_window_is_closed: function(p1: Pnk_context; const p2: PUTF8Char): nk_bool; cdecl;
  nk_window_is_hidden: function(p1: Pnk_context; const p2: PUTF8Char): nk_bool; cdecl;
  nk_window_is_active: function(p1: Pnk_context; const p2: PUTF8Char): nk_bool; cdecl;
  nk_window_is_any_hovered: function(p1: Pnk_context): nk_bool; cdecl;
  nk_item_is_any_active: function(p1: Pnk_context): nk_bool; cdecl;
  nk_window_set_bounds: procedure(p1: Pnk_context; const name: PUTF8Char; bounds: nk_rect); cdecl;
  nk_window_set_position: procedure(p1: Pnk_context; const name: PUTF8Char; pos: nk_vec2); cdecl;
  nk_window_set_size: procedure(p1: Pnk_context; const name: PUTF8Char; p3: nk_vec2); cdecl;
  nk_window_set_focus: procedure(p1: Pnk_context; const name: PUTF8Char); cdecl;
  nk_window_set_scroll: procedure(p1: Pnk_context; offset_x: nk_uint; offset_y: nk_uint); cdecl;
  nk_window_close: procedure(ctx: Pnk_context; const name: PUTF8Char); cdecl;
  nk_window_collapse: procedure(p1: Pnk_context; const name: PUTF8Char; state: nk_collapse_states); cdecl;
  nk_window_collapse_if: procedure(p1: Pnk_context; const name: PUTF8Char; p3: nk_collapse_states; cond: Integer); cdecl;
  nk_window_show: procedure(p1: Pnk_context; const name: PUTF8Char; p3: nk_show_states); cdecl;
  nk_window_show_if: procedure(p1: Pnk_context; const name: PUTF8Char; p3: nk_show_states; cond: Integer); cdecl;
  nk_layout_set_min_row_height: procedure(p1: Pnk_context; height: Single); cdecl;
  nk_layout_reset_min_row_height: procedure(p1: Pnk_context); cdecl;
  nk_layout_widget_bounds: function(p1: Pnk_context): nk_rect; cdecl;
  nk_layout_ratio_from_pixel: function(p1: Pnk_context; pixel_width: Single): Single; cdecl;
  nk_layout_row_dynamic: procedure(ctx: Pnk_context; height: Single; cols: Integer); cdecl;
  nk_layout_row_static: procedure(ctx: Pnk_context; height: Single; item_width: Integer; cols: Integer); cdecl;
  nk_layout_row_begin: procedure(ctx: Pnk_context; fmt: nk_layout_format; row_height: Single; cols: Integer); cdecl;
  nk_layout_row_push: procedure(p1: Pnk_context; value: Single); cdecl;
  nk_layout_row_end: procedure(p1: Pnk_context); cdecl;
  nk_layout_row: procedure(p1: Pnk_context; p2: nk_layout_format; height: Single; cols: Integer; const ratio: PSingle); cdecl;
  nk_layout_row_template_begin: procedure(p1: Pnk_context; row_height: Single); cdecl;
  nk_layout_row_template_push_dynamic: procedure(p1: Pnk_context); cdecl;
  nk_layout_row_template_push_variable: procedure(p1: Pnk_context; min_width: Single); cdecl;
  nk_layout_row_template_push_static: procedure(p1: Pnk_context; width: Single); cdecl;
  nk_layout_row_template_end: procedure(p1: Pnk_context); cdecl;
  nk_layout_space_begin: procedure(p1: Pnk_context; p2: nk_layout_format; height: Single; widget_count: Integer); cdecl;
  nk_layout_space_push: procedure(p1: Pnk_context; bounds: nk_rect); cdecl;
  nk_layout_space_end: procedure(p1: Pnk_context); cdecl;
  nk_layout_space_bounds: function(p1: Pnk_context): nk_rect; cdecl;
  nk_layout_space_to_screen: function(p1: Pnk_context; p2: nk_vec2): nk_vec2; cdecl;
  nk_layout_space_to_local: function(p1: Pnk_context; p2: nk_vec2): nk_vec2; cdecl;
  nk_layout_space_rect_to_screen: function(p1: Pnk_context; p2: nk_rect): nk_rect; cdecl;
  nk_layout_space_rect_to_local: function(p1: Pnk_context; p2: nk_rect): nk_rect; cdecl;
  nk_spacer: procedure(p1: Pnk_context); cdecl;
  nk_group_begin: function(p1: Pnk_context; const title: PUTF8Char; p3: nk_flags): nk_bool; cdecl;
  nk_group_begin_titled: function(p1: Pnk_context; const name: PUTF8Char; const title: PUTF8Char; p4: nk_flags): nk_bool; cdecl;
  nk_group_end: procedure(p1: Pnk_context); cdecl;
  nk_group_scrolled_offset_begin: function(p1: Pnk_context; x_offset: Pnk_uint; y_offset: Pnk_uint; const title: PUTF8Char; flags: nk_flags): nk_bool; cdecl;
  nk_group_scrolled_begin: function(p1: Pnk_context; off: Pnk_scroll; const title: PUTF8Char; p4: nk_flags): nk_bool; cdecl;
  nk_group_scrolled_end: procedure(p1: Pnk_context); cdecl;
  nk_group_get_scroll: procedure(p1: Pnk_context; const id: PUTF8Char; x_offset: Pnk_uint; y_offset: Pnk_uint); cdecl;
  nk_group_set_scroll: procedure(p1: Pnk_context; const id: PUTF8Char; x_offset: nk_uint; y_offset: nk_uint); cdecl;
  nk_tree_push_hashed: function(p1: Pnk_context; p2: nk_tree_type; const title: PUTF8Char; initial_state: nk_collapse_states; const hash: PUTF8Char; len: Integer; seed: Integer): nk_bool; cdecl;
  nk_tree_image_push_hashed: function(p1: Pnk_context; p2: nk_tree_type; p3: nk_image; const title: PUTF8Char; initial_state: nk_collapse_states; const hash: PUTF8Char; len: Integer; seed: Integer): nk_bool; cdecl;
  nk_tree_pop: procedure(p1: Pnk_context); cdecl;
  nk_tree_state_push: function(p1: Pnk_context; p2: nk_tree_type; const title: PUTF8Char; state: Pnk_collapse_states): nk_bool; cdecl;
  nk_tree_state_image_push: function(p1: Pnk_context; p2: nk_tree_type; p3: nk_image; const title: PUTF8Char; state: Pnk_collapse_states): nk_bool; cdecl;
  nk_tree_state_pop: procedure(p1: Pnk_context); cdecl;
  nk_tree_element_push_hashed: function(p1: Pnk_context; p2: nk_tree_type; const title: PUTF8Char; initial_state: nk_collapse_states; selected: Pnk_bool; const hash: PUTF8Char; len: Integer; seed: Integer): nk_bool; cdecl;
  nk_tree_element_image_push_hashed: function(p1: Pnk_context; p2: nk_tree_type; p3: nk_image; const title: PUTF8Char; initial_state: nk_collapse_states; selected: Pnk_bool; const hash: PUTF8Char; len: Integer; seed: Integer): nk_bool; cdecl;
  nk_tree_element_pop: procedure(p1: Pnk_context); cdecl;
  nk_list_view_begin: function(p1: Pnk_context; &out: Pnk_list_view; const id: PUTF8Char; p4: nk_flags; row_height: Integer; row_count: Integer): nk_bool; cdecl;
  nk_list_view_end: procedure(p1: Pnk_list_view); cdecl;
  nk_widget: function(p1: Pnk_rect; const p2: Pnk_context): nk_widget_layout_states; cdecl;
  nk_widget_fitting: function(p1: Pnk_rect; p2: Pnk_context; p3: nk_vec2): nk_widget_layout_states; cdecl;
  nk_widget_bounds: function(p1: Pnk_context): nk_rect; cdecl;
  nk_widget_position: function(p1: Pnk_context): nk_vec2; cdecl;
  nk_widget_size: function(p1: Pnk_context): nk_vec2; cdecl;
  nk_widget_width: function(p1: Pnk_context): Single; cdecl;
  nk_widget_height: function(p1: Pnk_context): Single; cdecl;
  nk_widget_is_hovered: function(p1: Pnk_context): nk_bool; cdecl;
  nk_widget_is_mouse_clicked: function(p1: Pnk_context; p2: nk_buttons): nk_bool; cdecl;
  nk_widget_has_mouse_click_down: function(p1: Pnk_context; p2: nk_buttons; down: nk_bool): nk_bool; cdecl;
  nk_spacing: procedure(p1: Pnk_context; cols: Integer); cdecl;
  nk_text: procedure(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; p4: nk_flags); cdecl;
  nk_text_colored: procedure(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; p4: nk_flags; p5: nk_color); cdecl;
  nk_text_wrap: procedure(p1: Pnk_context; const p2: PUTF8Char; p3: Integer); cdecl;
  nk_text_wrap_colored: procedure(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; p4: nk_color); cdecl;
  nk_label: procedure(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags); cdecl;
  nk_label_colored: procedure(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags; p4: nk_color); cdecl;
  nk_label_wrap: procedure(p1: Pnk_context; const p2: PUTF8Char); cdecl;
  nk_label_colored_wrap: procedure(p1: Pnk_context; const p2: PUTF8Char; p3: nk_color); cdecl;
  nk_image_rtn: procedure(p1: Pnk_context; p2: nk_image); cdecl;
  nk_image_color: procedure(p1: Pnk_context; p2: nk_image; p3: nk_color); cdecl;
  nk_labelf: procedure(p1: Pnk_context; p2: nk_flags; const p3: PUTF8Char) varargs; cdecl;
  nk_labelf_colored: procedure(p1: Pnk_context; p2: nk_flags; p3: nk_color; const p4: PUTF8Char) varargs; cdecl;
  nk_labelf_wrap: procedure(p1: Pnk_context; const p2: PUTF8Char) varargs; cdecl;
  nk_labelf_colored_wrap: procedure(p1: Pnk_context; p2: nk_color; const p3: PUTF8Char) varargs; cdecl;
  nk_labelfv: procedure(p1: Pnk_context; p2: nk_flags; const p3: PUTF8Char; p4: Pointer); cdecl;
  nk_labelfv_colored: procedure(p1: Pnk_context; p2: nk_flags; p3: nk_color; const p4: PUTF8Char; p5: Pointer); cdecl;
  nk_labelfv_wrap: procedure(p1: Pnk_context; const p2: PUTF8Char; p3: Pointer); cdecl;
  nk_labelfv_colored_wrap: procedure(p1: Pnk_context; p2: nk_color; const p3: PUTF8Char; p4: Pointer); cdecl;
  nk_value_bool: procedure(p1: Pnk_context; const prefix: PUTF8Char; p3: Integer); cdecl;
  nk_value_int: procedure(p1: Pnk_context; const prefix: PUTF8Char; p3: Integer); cdecl;
  nk_value_uint: procedure(p1: Pnk_context; const prefix: PUTF8Char; p3: Cardinal); cdecl;
  nk_value_float: procedure(p1: Pnk_context; const prefix: PUTF8Char; p3: Single); cdecl;
  nk_value_color_byte: procedure(p1: Pnk_context; const prefix: PUTF8Char; p3: nk_color); cdecl;
  nk_value_color_float: procedure(p1: Pnk_context; const prefix: PUTF8Char; p3: nk_color); cdecl;
  nk_value_color_hex: procedure(p1: Pnk_context; const prefix: PUTF8Char; p3: nk_color); cdecl;
  nk_button_text: function(p1: Pnk_context; const title: PUTF8Char; len: Integer): nk_bool; cdecl;
  nk_button_label: function(p1: Pnk_context; const title: PUTF8Char): nk_bool; cdecl;
  nk_button_color: function(p1: Pnk_context; p2: nk_color): nk_bool; cdecl;
  nk_button_symbol: function(p1: Pnk_context; p2: nk_symbol_type): nk_bool; cdecl;
  nk_button_image: function(p1: Pnk_context; img: nk_image): nk_bool; cdecl;
  nk_button_symbol_label: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; text_alignment: nk_flags): nk_bool; cdecl;
  nk_button_symbol_text: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; p4: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_button_image_label: function(p1: Pnk_context; img: nk_image; const p3: PUTF8Char; text_alignment: nk_flags): nk_bool; cdecl;
  nk_button_image_text: function(p1: Pnk_context; img: nk_image; const p3: PUTF8Char; p4: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_button_text_styled: function(p1: Pnk_context; const p2: Pnk_style_button; const title: PUTF8Char; len: Integer): nk_bool; cdecl;
  nk_button_label_styled: function(p1: Pnk_context; const p2: Pnk_style_button; const title: PUTF8Char): nk_bool; cdecl;
  nk_button_symbol_styled: function(p1: Pnk_context; const p2: Pnk_style_button; p3: nk_symbol_type): nk_bool; cdecl;
  nk_button_image_styled: function(p1: Pnk_context; const p2: Pnk_style_button; img: nk_image): nk_bool; cdecl;
  nk_button_symbol_text_styled: function(p1: Pnk_context; const p2: Pnk_style_button; p3: nk_symbol_type; const p4: PUTF8Char; p5: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_button_symbol_label_styled: function(ctx: Pnk_context; const style: Pnk_style_button; symbol: nk_symbol_type; const title: PUTF8Char; align: nk_flags): nk_bool; cdecl;
  nk_button_image_label_styled: function(p1: Pnk_context; const p2: Pnk_style_button; img: nk_image; const p4: PUTF8Char; text_alignment: nk_flags): nk_bool; cdecl;
  nk_button_image_text_styled: function(p1: Pnk_context; const p2: Pnk_style_button; img: nk_image; const p4: PUTF8Char; p5: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_button_set_behavior: procedure(p1: Pnk_context; p2: nk_button_behavior); cdecl;
  nk_button_push_behavior: function(p1: Pnk_context; p2: nk_button_behavior): nk_bool; cdecl;
  nk_button_pop_behavior: function(p1: Pnk_context): nk_bool; cdecl;
  nk_check_label: function(p1: Pnk_context; const p2: PUTF8Char; active: nk_bool): nk_bool; cdecl;
  nk_check_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; active: nk_bool): nk_bool; cdecl;
  nk_check_flags_label: function(p1: Pnk_context; const p2: PUTF8Char; flags: Cardinal; value: Cardinal): Cardinal; cdecl;
  nk_check_flags_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; flags: Cardinal; value: Cardinal): Cardinal; cdecl;
  nk_checkbox_label: function(p1: Pnk_context; const p2: PUTF8Char; active: Pnk_bool): nk_bool; cdecl;
  nk_checkbox_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; active: Pnk_bool): nk_bool; cdecl;
  nk_checkbox_flags_label: function(p1: Pnk_context; const p2: PUTF8Char; flags: PCardinal; value: Cardinal): nk_bool; cdecl;
  nk_checkbox_flags_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; flags: PCardinal; value: Cardinal): nk_bool; cdecl;
  nk_radio_label: function(p1: Pnk_context; const p2: PUTF8Char; active: Pnk_bool): nk_bool; cdecl;
  nk_radio_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; active: Pnk_bool): nk_bool; cdecl;
  nk_option_label: function(p1: Pnk_context; const p2: PUTF8Char; active: nk_bool): nk_bool; cdecl;
  nk_option_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; active: nk_bool): nk_bool; cdecl;
  nk_selectable_label: function(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags; value: Pnk_bool): nk_bool; cdecl;
  nk_selectable_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; align: nk_flags; value: Pnk_bool): nk_bool; cdecl;
  nk_selectable_image_label: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; align: nk_flags; value: Pnk_bool): nk_bool; cdecl;
  nk_selectable_image_text: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; p4: Integer; align: nk_flags; value: Pnk_bool): nk_bool; cdecl;
  nk_selectable_symbol_label: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; align: nk_flags; value: Pnk_bool): nk_bool; cdecl;
  nk_selectable_symbol_text: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; p4: Integer; align: nk_flags; value: Pnk_bool): nk_bool; cdecl;
  nk_select_label: function(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags; value: nk_bool): nk_bool; cdecl;
  nk_select_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; align: nk_flags; value: nk_bool): nk_bool; cdecl;
  nk_select_image_label: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; align: nk_flags; value: nk_bool): nk_bool; cdecl;
  nk_select_image_text: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; p4: Integer; align: nk_flags; value: nk_bool): nk_bool; cdecl;
  nk_select_symbol_label: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; align: nk_flags; value: nk_bool): nk_bool; cdecl;
  nk_select_symbol_text: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; p4: Integer; align: nk_flags; value: nk_bool): nk_bool; cdecl;
  nk_slide_float: function(p1: Pnk_context; min: Single; val: Single; max: Single; step: Single): Single; cdecl;
  nk_slide_int: function(p1: Pnk_context; min: Integer; val: Integer; max: Integer; step: Integer): Integer; cdecl;
  nk_slider_float: function(p1: Pnk_context; min: Single; val: PSingle; max: Single; step: Single): nk_bool; cdecl;
  nk_slider_int: function(p1: Pnk_context; min: Integer; val: PInteger; max: Integer; step: Integer): nk_bool; cdecl;
  nk_progress: function(p1: Pnk_context; cur: Pnk_size; max: nk_size; modifyable: nk_bool): nk_bool; cdecl;
  nk_prog: function(p1: Pnk_context; cur: nk_size; max: nk_size; modifyable: nk_bool): nk_size; cdecl;
  nk_color_picker: function(p1: Pnk_context; p2: nk_colorf; p3: nk_color_format): nk_colorf; cdecl;
  nk_color_pick: function(p1: Pnk_context; p2: Pnk_colorf; p3: nk_color_format): nk_bool; cdecl;
  nk_property_int: procedure(p1: Pnk_context; const name: PUTF8Char; min: Integer; val: PInteger; max: Integer; step: Integer; inc_per_pixel: Single); cdecl;
  nk_property_float: procedure(p1: Pnk_context; const name: PUTF8Char; min: Single; val: PSingle; max: Single; step: Single; inc_per_pixel: Single); cdecl;
  nk_property_double: procedure(p1: Pnk_context; const name: PUTF8Char; min: Double; val: PDouble; max: Double; step: Double; inc_per_pixel: Single); cdecl;
  nk_propertyi: function(p1: Pnk_context; const name: PUTF8Char; min: Integer; val: Integer; max: Integer; step: Integer; inc_per_pixel: Single): Integer; cdecl;
  nk_propertyf: function(p1: Pnk_context; const name: PUTF8Char; min: Single; val: Single; max: Single; step: Single; inc_per_pixel: Single): Single; cdecl;
  nk_propertyd: function(p1: Pnk_context; const name: PUTF8Char; min: Double; val: Double; max: Double; step: Double; inc_per_pixel: Single): Double; cdecl;
  nk_edit_string: function(p1: Pnk_context; p2: nk_flags; buffer: PUTF8Char; len: PInteger; max: Integer; p6: nk_plugin_filter): nk_flags; cdecl;
  nk_edit_string_zero_terminated: function(p1: Pnk_context; p2: nk_flags; buffer: PUTF8Char; max: Integer; p5: nk_plugin_filter): nk_flags; cdecl;
  nk_edit_buffer: function(p1: Pnk_context; p2: nk_flags; p3: Pnk_text_edit; p4: nk_plugin_filter): nk_flags; cdecl;
  nk_edit_focus: procedure(p1: Pnk_context; flags: nk_flags); cdecl;
  nk_edit_unfocus: procedure(p1: Pnk_context); cdecl;
  nk_chart_begin: function(p1: Pnk_context; p2: nk_chart_type; num: Integer; min: Single; max: Single): nk_bool; cdecl;
  nk_chart_begin_colored: function(p1: Pnk_context; p2: nk_chart_type; p3: nk_color; active: nk_color; num: Integer; min: Single; max: Single): nk_bool; cdecl;
  nk_chart_add_slot: procedure(ctx: Pnk_context; const p2: nk_chart_type; count: Integer; min_value: Single; max_value: Single); cdecl;
  nk_chart_add_slot_colored: procedure(ctx: Pnk_context; const p2: nk_chart_type; p3: nk_color; active: nk_color; count: Integer; min_value: Single; max_value: Single); cdecl;
  nk_chart_push: function(p1: Pnk_context; p2: Single): nk_flags; cdecl;
  nk_chart_push_slot: function(p1: Pnk_context; p2: Single; p3: Integer): nk_flags; cdecl;
  nk_chart_end: procedure(p1: Pnk_context); cdecl;
  nk_plot: procedure(p1: Pnk_context; p2: nk_chart_type; const values: PSingle; count: Integer; offset: Integer); cdecl;
  nk_plot_function: procedure(p1: Pnk_context; p2: nk_chart_type; userdata: Pointer; value_getter: nk_plot_function_value_getter; count: Integer; offset: Integer); cdecl;
  nk_popup_begin: function(p1: Pnk_context; p2: nk_popup_type; const p3: PUTF8Char; p4: nk_flags; bounds: nk_rect): nk_bool; cdecl;
  nk_popup_close: procedure(p1: Pnk_context); cdecl;
  nk_popup_end: procedure(p1: Pnk_context); cdecl;
  nk_popup_get_scroll: procedure(p1: Pnk_context; offset_x: Pnk_uint; offset_y: Pnk_uint); cdecl;
  nk_popup_set_scroll: procedure(p1: Pnk_context; offset_x: nk_uint; offset_y: nk_uint); cdecl;
  nk_combo: function(p1: Pnk_context; items: PPUTF8Char; count: Integer; selected: Integer; item_height: Integer; size: nk_vec2): Integer; cdecl;
  nk_combo_separator: function(p1: Pnk_context; const items_separated_by_separator: PUTF8Char; separator: Integer; selected: Integer; count: Integer; item_height: Integer; size: nk_vec2): Integer; cdecl;
  nk_combo_string: function(p1: Pnk_context; const items_separated_by_zeros: PUTF8Char; selected: Integer; count: Integer; item_height: Integer; size: nk_vec2): Integer; cdecl;
  nk_combo_callback: function(p1: Pnk_context; item_getter: nk_combo_callback_item_getter; userdata: Pointer; selected: Integer; count: Integer; item_height: Integer; size: nk_vec2): Integer; cdecl;
  nk_combobox: procedure(p1: Pnk_context; items: PPUTF8Char; count: Integer; selected: PInteger; item_height: Integer; size: nk_vec2); cdecl;
  nk_combobox_string: procedure(p1: Pnk_context; const items_separated_by_zeros: PUTF8Char; selected: PInteger; count: Integer; item_height: Integer; size: nk_vec2); cdecl;
  nk_combobox_separator: procedure(p1: Pnk_context; const items_separated_by_separator: PUTF8Char; separator: Integer; selected: PInteger; count: Integer; item_height: Integer; size: nk_vec2); cdecl;
  nk_combobox_callback: procedure(p1: Pnk_context; item_getter: nk_combobox_callback_item_getter; p3: Pointer; selected: PInteger; count: Integer; item_height: Integer; size: nk_vec2); cdecl;
  nk_combo_begin_text: function(p1: Pnk_context; const selected: PUTF8Char; p3: Integer; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_label: function(p1: Pnk_context; const selected: PUTF8Char; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_color: function(p1: Pnk_context; color: nk_color; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_symbol: function(p1: Pnk_context; p2: nk_symbol_type; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_symbol_label: function(p1: Pnk_context; const selected: PUTF8Char; p3: nk_symbol_type; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_symbol_text: function(p1: Pnk_context; const selected: PUTF8Char; p3: Integer; p4: nk_symbol_type; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_image: function(p1: Pnk_context; img: nk_image; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_image_label: function(p1: Pnk_context; const selected: PUTF8Char; p3: nk_image; size: nk_vec2): nk_bool; cdecl;
  nk_combo_begin_image_text: function(p1: Pnk_context; const selected: PUTF8Char; p3: Integer; p4: nk_image; size: nk_vec2): nk_bool; cdecl;
  nk_combo_item_label: function(p1: Pnk_context; const p2: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_combo_item_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_combo_item_image_label: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_combo_item_image_text: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; p4: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_combo_item_symbol_label: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_combo_item_symbol_text: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; p4: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_combo_close: procedure(p1: Pnk_context); cdecl;
  nk_combo_end: procedure(p1: Pnk_context); cdecl;
  nk_contextual_begin: function(p1: Pnk_context; p2: nk_flags; p3: nk_vec2; trigger_bounds: nk_rect): nk_bool; cdecl;
  nk_contextual_item_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; align: nk_flags): nk_bool; cdecl;
  nk_contextual_item_label: function(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags): nk_bool; cdecl;
  nk_contextual_item_image_label: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_contextual_item_image_text: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; len: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_contextual_item_symbol_label: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_contextual_item_symbol_text: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; p4: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_contextual_close: procedure(p1: Pnk_context); cdecl;
  nk_contextual_end: procedure(p1: Pnk_context); cdecl;
  nk_tooltip: procedure(p1: Pnk_context; const p2: PUTF8Char); cdecl;
  nk_tooltipf: procedure(p1: Pnk_context; const p2: PUTF8Char) varargs; cdecl;
  nk_tooltipfv: procedure(p1: Pnk_context; const p2: PUTF8Char; p3: Pointer); cdecl;
  nk_tooltip_begin: function(p1: Pnk_context; width: Single): nk_bool; cdecl;
  nk_tooltip_end: procedure(p1: Pnk_context); cdecl;
  nk_menubar_begin: procedure(p1: Pnk_context); cdecl;
  nk_menubar_end: procedure(p1: Pnk_context); cdecl;
  nk_menu_begin_text: function(p1: Pnk_context; const title: PUTF8Char; title_len: Integer; align: nk_flags; size: nk_vec2): nk_bool; cdecl;
  nk_menu_begin_label: function(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags; size: nk_vec2): nk_bool; cdecl;
  nk_menu_begin_image: function(p1: Pnk_context; const p2: PUTF8Char; p3: nk_image; size: nk_vec2): nk_bool; cdecl;
  nk_menu_begin_image_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; align: nk_flags; p5: nk_image; size: nk_vec2): nk_bool; cdecl;
  nk_menu_begin_image_label: function(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags; p4: nk_image; size: nk_vec2): nk_bool; cdecl;
  nk_menu_begin_symbol: function(p1: Pnk_context; const p2: PUTF8Char; p3: nk_symbol_type; size: nk_vec2): nk_bool; cdecl;
  nk_menu_begin_symbol_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; align: nk_flags; p5: nk_symbol_type; size: nk_vec2): nk_bool; cdecl;
  nk_menu_begin_symbol_label: function(p1: Pnk_context; const p2: PUTF8Char; align: nk_flags; p4: nk_symbol_type; size: nk_vec2): nk_bool; cdecl;
  nk_menu_item_text: function(p1: Pnk_context; const p2: PUTF8Char; p3: Integer; align: nk_flags): nk_bool; cdecl;
  nk_menu_item_label: function(p1: Pnk_context; const p2: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_menu_item_image_label: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_menu_item_image_text: function(p1: Pnk_context; p2: nk_image; const p3: PUTF8Char; len: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_menu_item_symbol_text: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; p4: Integer; alignment: nk_flags): nk_bool; cdecl;
  nk_menu_item_symbol_label: function(p1: Pnk_context; p2: nk_symbol_type; const p3: PUTF8Char; alignment: nk_flags): nk_bool; cdecl;
  nk_menu_close: procedure(p1: Pnk_context); cdecl;
  nk_menu_end: procedure(p1: Pnk_context); cdecl;
  nk_style_default: procedure(p1: Pnk_context); cdecl;
  nk_style_from_table: procedure(p1: Pnk_context; const p2: Pnk_color); cdecl;
  nk_style_load_cursor: procedure(p1: Pnk_context; p2: nk_style_cursor; const p3: Pnk_cursor); cdecl;
  nk_style_load_all_cursors: procedure(p1: Pnk_context; p2: Pnk_cursor); cdecl;
  nk_style_get_color_by_name: function(p1: nk_style_colors): PUTF8Char; cdecl;
  nk_style_set_font: procedure(p1: Pnk_context; const p2: Pnk_user_font); cdecl;
  nk_style_set_cursor: function(p1: Pnk_context; p2: nk_style_cursor): nk_bool; cdecl;
  nk_style_show_cursor: procedure(p1: Pnk_context); cdecl;
  nk_style_hide_cursor: procedure(p1: Pnk_context); cdecl;
  nk_style_push_font: function(p1: Pnk_context; const p2: Pnk_user_font): nk_bool; cdecl;
  nk_style_push_float: function(p1: Pnk_context; p2: PSingle; p3: Single): nk_bool; cdecl;
  nk_style_push_vec2: function(p1: Pnk_context; p2: Pnk_vec2; p3: nk_vec2): nk_bool; cdecl;
  nk_style_push_style_item: function(p1: Pnk_context; p2: Pnk_style_item; p3: nk_style_item): nk_bool; cdecl;
  nk_style_push_flags: function(p1: Pnk_context; p2: Pnk_flags; p3: nk_flags): nk_bool; cdecl;
  nk_style_push_color: function(p1: Pnk_context; p2: Pnk_color; p3: nk_color): nk_bool; cdecl;
  nk_style_pop_font: function(p1: Pnk_context): nk_bool; cdecl;
  nk_style_pop_float: function(p1: Pnk_context): nk_bool; cdecl;
  nk_style_pop_vec2: function(p1: Pnk_context): nk_bool; cdecl;
  nk_style_pop_style_item: function(p1: Pnk_context): nk_bool; cdecl;
  nk_style_pop_flags: function(p1: Pnk_context): nk_bool; cdecl;
  nk_style_pop_color: function(p1: Pnk_context): nk_bool; cdecl;
  nk_rgb_rtn: function(r: Integer; g: Integer; b: Integer): nk_color; cdecl;
  nk_rgb_iv: function(const rgb: PInteger): nk_color; cdecl;
  nk_rgb_bv: function(const rgb: Pnk_byte): nk_color; cdecl;
  nk_rgb_f: function(r: Single; g: Single; b: Single): nk_color; cdecl;
  nk_rgb_fv: function(const rgb: PSingle): nk_color; cdecl;
  nk_rgb_cf: function(c: nk_colorf): nk_color; cdecl;
  nk_rgb_hex: function(const rgb: PUTF8Char): nk_color; cdecl;
  nk_rgba_rtn: function(r: Integer; g: Integer; b: Integer; a: Integer): nk_color; cdecl;
  nk_rgba_u32: function(p1: nk_uint): nk_color; cdecl;
  nk_rgba_iv: function(const rgba: PInteger): nk_color; cdecl;
  nk_rgba_bv: function(const rgba: Pnk_byte): nk_color; cdecl;
  nk_rgba_f: function(r: Single; g: Single; b: Single; a: Single): nk_color; cdecl;
  nk_rgba_fv: function(const rgba: PSingle): nk_color; cdecl;
  nk_rgba_cf: function(c: nk_colorf): nk_color; cdecl;
  nk_rgba_hex: function(const rgb: PUTF8Char): nk_color; cdecl;
  nk_hsva_colorf: function(h: Single; s: Single; v: Single; a: Single): nk_colorf; cdecl;
  nk_hsva_colorfv: function(c: PSingle): nk_colorf; cdecl;
  nk_colorf_hsva_f: procedure(out_h: PSingle; out_s: PSingle; out_v: PSingle; out_a: PSingle; &in: nk_colorf); cdecl;
  nk_colorf_hsva_fv: procedure(hsva: PSingle; &in: nk_colorf); cdecl;
  nk_hsv: function(h: Integer; s: Integer; v: Integer): nk_color; cdecl;
  nk_hsv_iv: function(const hsv: PInteger): nk_color; cdecl;
  nk_hsv_bv: function(const hsv: Pnk_byte): nk_color; cdecl;
  nk_hsv_f: function(h: Single; s: Single; v: Single): nk_color; cdecl;
  nk_hsv_fv: function(const hsv: PSingle): nk_color; cdecl;
  nk_hsva: function(h: Integer; s: Integer; v: Integer; a: Integer): nk_color; cdecl;
  nk_hsva_iv: function(const hsva: PInteger): nk_color; cdecl;
  nk_hsva_bv: function(const hsva: Pnk_byte): nk_color; cdecl;
  nk_hsva_f: function(h: Single; s: Single; v: Single; a: Single): nk_color; cdecl;
  nk_hsva_fv: function(const hsva: PSingle): nk_color; cdecl;
  nk_color_f: procedure(r: PSingle; g: PSingle; b: PSingle; a: PSingle; p5: nk_color); cdecl;
  nk_color_fv: procedure(rgba_out: PSingle; p2: nk_color); cdecl;
  nk_color_cf: function(p1: nk_color): nk_colorf; cdecl;
  nk_color_d: procedure(r: PDouble; g: PDouble; b: PDouble; a: PDouble; p5: nk_color); cdecl;
  nk_color_dv: procedure(rgba_out: PDouble; p2: nk_color); cdecl;
  nk_color_u32: function(p1: nk_color): nk_uint; cdecl;
  nk_color_hex_rgba: procedure(output: PUTF8Char; p2: nk_color); cdecl;
  nk_color_hex_rgb: procedure(output: PUTF8Char; p2: nk_color); cdecl;
  nk_color_hsv_i: procedure(out_h: PInteger; out_s: PInteger; out_v: PInteger; p4: nk_color); cdecl;
  nk_color_hsv_b: procedure(out_h: Pnk_byte; out_s: Pnk_byte; out_v: Pnk_byte; p4: nk_color); cdecl;
  nk_color_hsv_iv: procedure(hsv_out: PInteger; p2: nk_color); cdecl;
  nk_color_hsv_bv: procedure(hsv_out: Pnk_byte; p2: nk_color); cdecl;
  nk_color_hsv_f: procedure(out_h: PSingle; out_s: PSingle; out_v: PSingle; p4: nk_color); cdecl;
  nk_color_hsv_fv: procedure(hsv_out: PSingle; p2: nk_color); cdecl;
  nk_color_hsva_i: procedure(h: PInteger; s: PInteger; v: PInteger; a: PInteger; p5: nk_color); cdecl;
  nk_color_hsva_b: procedure(h: Pnk_byte; s: Pnk_byte; v: Pnk_byte; a: Pnk_byte; p5: nk_color); cdecl;
  nk_color_hsva_iv: procedure(hsva_out: PInteger; p2: nk_color); cdecl;
  nk_color_hsva_bv: procedure(hsva_out: Pnk_byte; p2: nk_color); cdecl;
  nk_color_hsva_f: procedure(out_h: PSingle; out_s: PSingle; out_v: PSingle; out_a: PSingle; p5: nk_color); cdecl;
  nk_color_hsva_fv: procedure(hsva_out: PSingle; p2: nk_color); cdecl;
  nk_handle_ptr: function(p1: Pointer): nk_handle; cdecl;
  nk_handle_id: function(p1: Integer): nk_handle; cdecl;
  nk_image_handle: function(p1: nk_handle): nk_image; cdecl;
  nk_image_ptr: function(p1: Pointer): nk_image; cdecl;
  nk_image_id: function(p1: Integer): nk_image; cdecl;
  nk_image_is_subimage: function(const img: Pnk_image): nk_bool; cdecl;
  nk_subimage_ptr: function(p1: Pointer; w: nk_ushort; h: nk_ushort; sub_region: nk_rect): nk_image; cdecl;
  nk_subimage_id: function(p1: Integer; w: nk_ushort; h: nk_ushort; sub_region: nk_rect): nk_image; cdecl;
  nk_subimage_handle: function(p1: nk_handle; w: nk_ushort; h: nk_ushort; sub_region: nk_rect): nk_image; cdecl;
  nk_nine_slice_handle: function(p1: nk_handle; l: nk_ushort; t: nk_ushort; r: nk_ushort; b: nk_ushort): nk_nine_slice; cdecl;
  nk_nine_slice_ptr: function(p1: Pointer; l: nk_ushort; t: nk_ushort; r: nk_ushort; b: nk_ushort): nk_nine_slice; cdecl;
  nk_nine_slice_id: function(p1: Integer; l: nk_ushort; t: nk_ushort; r: nk_ushort; b: nk_ushort): nk_nine_slice; cdecl;
  nk_nine_slice_is_sub9slice: function(const img: Pnk_nine_slice): Integer; cdecl;
  nk_sub9slice_ptr: function(p1: Pointer; w: nk_ushort; h: nk_ushort; sub_region: nk_rect; l: nk_ushort; t: nk_ushort; r: nk_ushort; b: nk_ushort): nk_nine_slice; cdecl;
  nk_sub9slice_id: function(p1: Integer; w: nk_ushort; h: nk_ushort; sub_region: nk_rect; l: nk_ushort; t: nk_ushort; r: nk_ushort; b: nk_ushort): nk_nine_slice; cdecl;
  nk_sub9slice_handle: function(p1: nk_handle; w: nk_ushort; h: nk_ushort; sub_region: nk_rect; l: nk_ushort; t: nk_ushort; r: nk_ushort; b: nk_ushort): nk_nine_slice; cdecl;
  nk_murmur_hash: function(const key: Pointer; len: Integer; seed: nk_hash): nk_hash; cdecl;
  nk_triangle_from_direction: procedure(result: Pnk_vec2; r: nk_rect; pad_x: Single; pad_y: Single; p5: nk_heading); cdecl;
  nk_vec2_rtn: function(x: Single; y: Single): nk_vec2; cdecl;
  nk_vec2i_rtn: function(x: Integer; y: Integer): nk_vec2; cdecl;
  nk_vec2v: function(const xy: PSingle): nk_vec2; cdecl;
  nk_vec2iv: function(const xy: PInteger): nk_vec2; cdecl;
  nk_get_null_rect: function(): nk_rect; cdecl;
  nk_rect_rtn: function(x: Single; y: Single; w: Single; h: Single): nk_rect; cdecl;
  nk_recti_rtn: function(x: Integer; y: Integer; w: Integer; h: Integer): nk_rect; cdecl;
  nk_recta: function(pos: nk_vec2; size: nk_vec2): nk_rect; cdecl;
  nk_rectv: function(const xywh: PSingle): nk_rect; cdecl;
  nk_rectiv: function(const xywh: PInteger): nk_rect; cdecl;
  nk_rect_pos: function(p1: nk_rect): nk_vec2; cdecl;
  nk_rect_size: function(p1: nk_rect): nk_vec2; cdecl;
  nk_strlen: function(const str: PUTF8Char): Integer; cdecl;
  nk_stricmp: function(const s1: PUTF8Char; const s2: PUTF8Char): Integer; cdecl;
  nk_stricmpn: function(const s1: PUTF8Char; const s2: PUTF8Char; n: Integer): Integer; cdecl;
  nk_strtoi: function(const str: PUTF8Char; endptr: PPUTF8Char): Integer; cdecl;
  nk_strtof: function(const str: PUTF8Char; endptr: PPUTF8Char): Single; cdecl;
  nk_strtod: function(const str: PUTF8Char; endptr: PPUTF8Char): Double; cdecl;
  nk_strfilter: function(const text: PUTF8Char; const regexp: PUTF8Char): Integer; cdecl;
  nk_strmatch_fuzzy_string: function(const str: PUTF8Char; const pattern: PUTF8Char; out_score: PInteger): Integer; cdecl;
  nk_strmatch_fuzzy_text: function(const txt: PUTF8Char; txt_len: Integer; const pattern: PUTF8Char; out_score: PInteger): Integer; cdecl;
  nk_utf_decode: function(const p1: PUTF8Char; p2: Pnk_rune; p3: Integer): Integer; cdecl;
  nk_utf_encode: function(p1: nk_rune; p2: PUTF8Char; p3: Integer): Integer; cdecl;
  nk_utf_len: function(const p1: PUTF8Char; byte_len: Integer): Integer; cdecl;
  nk_utf_at: function(const buffer: PUTF8Char; length: Integer; index: Integer; unicode: Pnk_rune; len: PInteger): PUTF8Char; cdecl;
  nk_font_default_glyph_ranges: function(): Pnk_rune; cdecl;
  nk_font_chinese_glyph_ranges: function(): Pnk_rune; cdecl;
  nk_font_cyrillic_glyph_ranges: function(): Pnk_rune; cdecl;
  nk_font_korean_glyph_ranges: function(): Pnk_rune; cdecl;
  nk_font_atlas_init_default: procedure(p1: Pnk_font_atlas); cdecl;
  nk_font_atlas_init: procedure(p1: Pnk_font_atlas; p2: Pnk_allocator); cdecl;
  nk_font_atlas_init_custom: procedure(p1: Pnk_font_atlas; persistent: Pnk_allocator; transient: Pnk_allocator); cdecl;
  nk_font_atlas_begin: procedure(p1: Pnk_font_atlas); cdecl;
  nk_font_config_rtn: function(pixel_height: Single): nk_font_config; cdecl;
  nk_font_atlas_add: function(p1: Pnk_font_atlas; const p2: Pnk_font_config): Pnk_font; cdecl;
  nk_font_atlas_add_default: function(p1: Pnk_font_atlas; height: Single; const p3: Pnk_font_config): Pnk_font; cdecl;
  nk_font_atlas_add_from_memory: function(atlas: Pnk_font_atlas; memory: Pointer; size: nk_size; height: Single; const config: Pnk_font_config): Pnk_font; cdecl;
  nk_font_atlas_add_from_file: function(atlas: Pnk_font_atlas; const file_path: PUTF8Char; height: Single; const p4: Pnk_font_config): Pnk_font; cdecl;
  nk_font_atlas_add_compressed: function(p1: Pnk_font_atlas; memory: Pointer; size: nk_size; height: Single; const p5: Pnk_font_config): Pnk_font; cdecl;
  nk_font_atlas_add_compressed_base85: function(p1: Pnk_font_atlas; const data: PUTF8Char; height: Single; const config: Pnk_font_config): Pnk_font; cdecl;
  nk_font_atlas_bake: function(p1: Pnk_font_atlas; width: PInteger; height: PInteger; p4: nk_font_atlas_format): Pointer; cdecl;
  nk_font_atlas_end: procedure(p1: Pnk_font_atlas; tex: nk_handle; p3: Pnk_draw_null_texture); cdecl;
  nk_font_find_glyph: function(p1: Pnk_font; unicode: nk_rune): Pnk_font_glyph; cdecl;
  nk_font_atlas_cleanup: procedure(atlas: Pnk_font_atlas); cdecl;
  nk_font_atlas_clear: procedure(p1: Pnk_font_atlas); cdecl;
  nk_buffer_init_default: procedure(p1: Pnk_buffer); cdecl;
  nk_buffer_init: procedure(p1: Pnk_buffer; const p2: Pnk_allocator; size: nk_size); cdecl;
  nk_buffer_init_fixed: procedure(p1: Pnk_buffer; memory: Pointer; size: nk_size); cdecl;
  nk_buffer_info: procedure(p1: Pnk_memory_status; p2: Pnk_buffer); cdecl;
  nk_buffer_push: procedure(p1: Pnk_buffer; &type: nk_buffer_allocation_type; const memory: Pointer; size: nk_size; align: nk_size); cdecl;
  nk_buffer_mark: procedure(p1: Pnk_buffer; &type: nk_buffer_allocation_type); cdecl;
  nk_buffer_reset: procedure(p1: Pnk_buffer; &type: nk_buffer_allocation_type); cdecl;
  nk_buffer_clear: procedure(p1: Pnk_buffer); cdecl;
  nk_buffer_free: procedure(p1: Pnk_buffer); cdecl;
  nk_buffer_memory: function(p1: Pnk_buffer): Pointer; cdecl;
  nk_buffer_memory_const: function(const p1: Pnk_buffer): Pointer; cdecl;
  nk_buffer_total: function(p1: Pnk_buffer): nk_size; cdecl;
  nk_str_init_default: procedure(p1: Pnk_str); cdecl;
  nk_str_init: procedure(p1: Pnk_str; const p2: Pnk_allocator; size: nk_size); cdecl;
  nk_str_init_fixed: procedure(p1: Pnk_str; memory: Pointer; size: nk_size); cdecl;
  nk_str_clear: procedure(p1: Pnk_str); cdecl;
  nk_str_free: procedure(p1: Pnk_str); cdecl;
  nk_str_append_text_char: function(p1: Pnk_str; const p2: PUTF8Char; p3: Integer): Integer; cdecl;
  nk_str_append_str_char: function(p1: Pnk_str; const p2: PUTF8Char): Integer; cdecl;
  nk_str_append_text_utf8: function(p1: Pnk_str; const p2: PUTF8Char; p3: Integer): Integer; cdecl;
  nk_str_append_str_utf8: function(p1: Pnk_str; const p2: PUTF8Char): Integer; cdecl;
  nk_str_append_text_runes: function(p1: Pnk_str; const p2: Pnk_rune; p3: Integer): Integer; cdecl;
  nk_str_append_str_runes: function(p1: Pnk_str; const p2: Pnk_rune): Integer; cdecl;
  nk_str_insert_at_char: function(p1: Pnk_str; pos: Integer; const p3: PUTF8Char; p4: Integer): Integer; cdecl;
  nk_str_insert_at_rune: function(p1: Pnk_str; pos: Integer; const p3: PUTF8Char; p4: Integer): Integer; cdecl;
  nk_str_insert_text_char: function(p1: Pnk_str; pos: Integer; const p3: PUTF8Char; p4: Integer): Integer; cdecl;
  nk_str_insert_str_char: function(p1: Pnk_str; pos: Integer; const p3: PUTF8Char): Integer; cdecl;
  nk_str_insert_text_utf8: function(p1: Pnk_str; pos: Integer; const p3: PUTF8Char; p4: Integer): Integer; cdecl;
  nk_str_insert_str_utf8: function(p1: Pnk_str; pos: Integer; const p3: PUTF8Char): Integer; cdecl;
  nk_str_insert_text_runes: function(p1: Pnk_str; pos: Integer; const p3: Pnk_rune; p4: Integer): Integer; cdecl;
  nk_str_insert_str_runes: function(p1: Pnk_str; pos: Integer; const p3: Pnk_rune): Integer; cdecl;
  nk_str_remove_chars: procedure(p1: Pnk_str; len: Integer); cdecl;
  nk_str_remove_runes: procedure(str: Pnk_str; len: Integer); cdecl;
  nk_str_delete_chars: procedure(p1: Pnk_str; pos: Integer; len: Integer); cdecl;
  nk_str_delete_runes: procedure(p1: Pnk_str; pos: Integer; len: Integer); cdecl;
  nk_str_at_char: function(p1: Pnk_str; pos: Integer): PUTF8Char; cdecl;
  nk_str_at_rune: function(p1: Pnk_str; pos: Integer; unicode: Pnk_rune; len: PInteger): PUTF8Char; cdecl;
  nk_str_rune_at: function(const p1: Pnk_str; pos: Integer): nk_rune; cdecl;
  nk_str_at_char_const: function(const p1: Pnk_str; pos: Integer): PUTF8Char; cdecl;
  nk_str_at_const: function(const p1: Pnk_str; pos: Integer; unicode: Pnk_rune; len: PInteger): PUTF8Char; cdecl;
  nk_str_get: function(p1: Pnk_str): PUTF8Char; cdecl;
  nk_str_get_const: function(const p1: Pnk_str): PUTF8Char; cdecl;
  nk_str_len: function(p1: Pnk_str): Integer; cdecl;
  nk_str_len_char: function(p1: Pnk_str): Integer; cdecl;
  nk_filter_default: function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;
  nk_filter_ascii: function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;
  nk_filter_float: function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;
  nk_filter_decimal: function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;
  nk_filter_hex: function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;
  nk_filter_oct: function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;
  nk_filter_binary: function(const p1: Pnk_text_edit; unicode: nk_rune): nk_bool; cdecl;
  nk_textedit_init_default: procedure(p1: Pnk_text_edit); cdecl;
  nk_textedit_init: procedure(p1: Pnk_text_edit; p2: Pnk_allocator; size: nk_size); cdecl;
  nk_textedit_init_fixed: procedure(p1: Pnk_text_edit; memory: Pointer; size: nk_size); cdecl;
  nk_textedit_free: procedure(p1: Pnk_text_edit); cdecl;
  nk_textedit_text: procedure(p1: Pnk_text_edit; const p2: PUTF8Char; total_len: Integer); cdecl;
  nk_textedit_delete: procedure(p1: Pnk_text_edit; where: Integer; len: Integer); cdecl;
  nk_textedit_delete_selection: procedure(p1: Pnk_text_edit); cdecl;
  nk_textedit_select_all: procedure(p1: Pnk_text_edit); cdecl;
  nk_textedit_cut: function(p1: Pnk_text_edit): nk_bool; cdecl;
  nk_textedit_paste: function(p1: Pnk_text_edit; const p2: PUTF8Char; len: Integer): nk_bool; cdecl;
  nk_textedit_undo: procedure(p1: Pnk_text_edit); cdecl;
  nk_textedit_redo: procedure(p1: Pnk_text_edit); cdecl;
  nk_stroke_line: procedure(b: Pnk_command_buffer; x0: Single; y0: Single; x1: Single; y1: Single; line_thickness: Single; p7: nk_color); cdecl;
  nk_stroke_curve: procedure(p1: Pnk_command_buffer; p2: Single; p3: Single; p4: Single; p5: Single; p6: Single; p7: Single; p8: Single; p9: Single; line_thickness: Single; p11: nk_color); cdecl;
  nk_stroke_rect: procedure(p1: Pnk_command_buffer; p2: nk_rect; rounding: Single; line_thickness: Single; p5: nk_color); cdecl;
  nk_stroke_circle: procedure(p1: Pnk_command_buffer; p2: nk_rect; line_thickness: Single; p4: nk_color); cdecl;
  nk_stroke_arc: procedure(p1: Pnk_command_buffer; cx: Single; cy: Single; radius: Single; a_min: Single; a_max: Single; line_thickness: Single; p8: nk_color); cdecl;
  nk_stroke_triangle: procedure(p1: Pnk_command_buffer; p2: Single; p3: Single; p4: Single; p5: Single; p6: Single; p7: Single; line_thichness: Single; p9: nk_color); cdecl;
  nk_stroke_polyline: procedure(p1: Pnk_command_buffer; points: PSingle; point_count: Integer; line_thickness: Single; col: nk_color); cdecl;
  nk_stroke_polygon: procedure(p1: Pnk_command_buffer; p2: PSingle; point_count: Integer; line_thickness: Single; p5: nk_color); cdecl;
  nk_fill_rect: procedure(p1: Pnk_command_buffer; p2: nk_rect; rounding: Single; p4: nk_color); cdecl;
  nk_fill_rect_multi_color: procedure(p1: Pnk_command_buffer; p2: nk_rect; left: nk_color; top: nk_color; right: nk_color; bottom: nk_color); cdecl;
  nk_fill_circle: procedure(p1: Pnk_command_buffer; p2: nk_rect; p3: nk_color); cdecl;
  nk_fill_arc: procedure(p1: Pnk_command_buffer; cx: Single; cy: Single; radius: Single; a_min: Single; a_max: Single; p7: nk_color); cdecl;
  nk_fill_triangle: procedure(p1: Pnk_command_buffer; x0: Single; y0: Single; x1: Single; y1: Single; x2: Single; y2: Single; p8: nk_color); cdecl;
  nk_fill_polygon: procedure(p1: Pnk_command_buffer; p2: PSingle; point_count: Integer; p4: nk_color); cdecl;
  nk_draw_image: procedure(p1: Pnk_command_buffer; p2: nk_rect; const p3: Pnk_image; p4: nk_color); cdecl;
  nk_draw_nine_slice: procedure(p1: Pnk_command_buffer; p2: nk_rect; const p3: Pnk_nine_slice; p4: nk_color); cdecl;
  nk_draw_text: procedure(p1: Pnk_command_buffer; p2: nk_rect; const text: PUTF8Char; len: Integer; const p5: Pnk_user_font; p6: nk_color; p7: nk_color); cdecl;
  nk_push_scissor: procedure(p1: Pnk_command_buffer; p2: nk_rect); cdecl;
  nk_push_custom: procedure(p1: Pnk_command_buffer; p2: nk_rect; p3: nk_command_custom_callback; usr: nk_handle); cdecl;
  nk_input_has_mouse_click: function(const p1: Pnk_input; p2: nk_buttons): nk_bool; cdecl;
  nk_input_has_mouse_click_in_rect: function(const p1: Pnk_input; p2: nk_buttons; p3: nk_rect): nk_bool; cdecl;
  nk_input_has_mouse_click_in_button_rect: function(const p1: Pnk_input; p2: nk_buttons; p3: nk_rect): nk_bool; cdecl;
  nk_input_has_mouse_click_down_in_rect: function(const p1: Pnk_input; p2: nk_buttons; p3: nk_rect; down: nk_bool): nk_bool; cdecl;
  nk_input_is_mouse_click_in_rect: function(const p1: Pnk_input; p2: nk_buttons; p3: nk_rect): nk_bool; cdecl;
  nk_input_is_mouse_click_down_in_rect: function(const i: Pnk_input; id: nk_buttons; b: nk_rect; down: nk_bool): nk_bool; cdecl;
  nk_input_any_mouse_click_in_rect: function(const p1: Pnk_input; p2: nk_rect): nk_bool; cdecl;
  nk_input_is_mouse_prev_hovering_rect: function(const p1: Pnk_input; p2: nk_rect): nk_bool; cdecl;
  nk_input_is_mouse_hovering_rect: function(const p1: Pnk_input; p2: nk_rect): nk_bool; cdecl;
  nk_input_mouse_clicked: function(const p1: Pnk_input; p2: nk_buttons; p3: nk_rect): nk_bool; cdecl;
  nk_input_is_mouse_down: function(const p1: Pnk_input; p2: nk_buttons): nk_bool; cdecl;
  nk_input_is_mouse_pressed: function(const p1: Pnk_input; p2: nk_buttons): nk_bool; cdecl;
  nk_input_is_mouse_released: function(const p1: Pnk_input; p2: nk_buttons): nk_bool; cdecl;
  nk_input_is_key_pressed: function(const p1: Pnk_input; p2: nk_keys): nk_bool; cdecl;
  nk_input_is_key_released: function(const p1: Pnk_input; p2: nk_keys): nk_bool; cdecl;
  nk_input_is_key_down: function(const p1: Pnk_input; p2: nk_keys): nk_bool; cdecl;
  nk_draw_list_init: procedure(p1: Pnk_draw_list); cdecl;
  nk_draw_list_setup: procedure(p1: Pnk_draw_list; const p2: Pnk_convert_config; cmds: Pnk_buffer; vertices: Pnk_buffer; elements: Pnk_buffer; line_aa: nk_anti_aliasing; shape_aa: nk_anti_aliasing); cdecl;
  nk__draw_list_begin: function(const p1: Pnk_draw_list; const p2: Pnk_buffer): Pnk_draw_command; cdecl;
  nk__draw_list_next: function(const p1: Pnk_draw_command; const p2: Pnk_buffer; const p3: Pnk_draw_list): Pnk_draw_command; cdecl;
  nk__draw_list_end: function(const p1: Pnk_draw_list; const p2: Pnk_buffer): Pnk_draw_command; cdecl;
  nk_draw_list_path_clear: procedure(p1: Pnk_draw_list); cdecl;
  nk_draw_list_path_line_to: procedure(p1: Pnk_draw_list; pos: nk_vec2); cdecl;
  nk_draw_list_path_arc_to_fast: procedure(p1: Pnk_draw_list; center: nk_vec2; radius: Single; a_min: Integer; a_max: Integer); cdecl;
  nk_draw_list_path_arc_to: procedure(p1: Pnk_draw_list; center: nk_vec2; radius: Single; a_min: Single; a_max: Single; segments: Cardinal); cdecl;
  nk_draw_list_path_rect_to: procedure(p1: Pnk_draw_list; a: nk_vec2; b: nk_vec2; rounding: Single); cdecl;
  nk_draw_list_path_curve_to: procedure(p1: Pnk_draw_list; p2: nk_vec2; p3: nk_vec2; p4: nk_vec2; num_segments: Cardinal); cdecl;
  nk_draw_list_path_fill: procedure(p1: Pnk_draw_list; p2: nk_color); cdecl;
  nk_draw_list_path_stroke: procedure(p1: Pnk_draw_list; p2: nk_color; closed: nk_draw_list_stroke; thickness: Single); cdecl;
  nk_draw_list_stroke_line: procedure(p1: Pnk_draw_list; a: nk_vec2; b: nk_vec2; p4: nk_color; thickness: Single); cdecl;
  nk_draw_list_stroke_rect: procedure(p1: Pnk_draw_list; rect: nk_rect; p3: nk_color; rounding: Single; thickness: Single); cdecl;
  nk_draw_list_stroke_triangle: procedure(p1: Pnk_draw_list; a: nk_vec2; b: nk_vec2; c: nk_vec2; p5: nk_color; thickness: Single); cdecl;
  nk_draw_list_stroke_circle: procedure(p1: Pnk_draw_list; center: nk_vec2; radius: Single; p4: nk_color; segs: Cardinal; thickness: Single); cdecl;
  nk_draw_list_stroke_curve: procedure(p1: Pnk_draw_list; p0: nk_vec2; cp0: nk_vec2; cp1: nk_vec2; p5: nk_vec2; p6: nk_color; segments: Cardinal; thickness: Single); cdecl;
  nk_draw_list_stroke_poly_line: procedure(p1: Pnk_draw_list; const pnts: Pnk_vec2; const cnt: Cardinal; p4: nk_color; p5: nk_draw_list_stroke; thickness: Single; p7: nk_anti_aliasing); cdecl;
  nk_draw_list_fill_rect: procedure(p1: Pnk_draw_list; rect: nk_rect; p3: nk_color; rounding: Single); cdecl;
  nk_draw_list_fill_rect_multi_color: procedure(p1: Pnk_draw_list; rect: nk_rect; left: nk_color; top: nk_color; right: nk_color; bottom: nk_color); cdecl;
  nk_draw_list_fill_triangle: procedure(p1: Pnk_draw_list; a: nk_vec2; b: nk_vec2; c: nk_vec2; p5: nk_color); cdecl;
  nk_draw_list_fill_circle: procedure(p1: Pnk_draw_list; center: nk_vec2; radius: Single; col: nk_color; segs: Cardinal); cdecl;
  nk_draw_list_fill_poly_convex: procedure(p1: Pnk_draw_list; const points: Pnk_vec2; const count: Cardinal; p4: nk_color; p5: nk_anti_aliasing); cdecl;
  nk_draw_list_add_image: procedure(p1: Pnk_draw_list; texture: nk_image; rect: nk_rect; p4: nk_color); cdecl;
  nk_draw_list_add_text: procedure(p1: Pnk_draw_list; const p2: Pnk_user_font; p3: nk_rect; const text: PUTF8Char; len: Integer; font_height: Single; p7: nk_color); cdecl;
  nk_style_item_color_rtn: function(p1: nk_color): nk_style_item; cdecl;
  nk_style_item_image_rtn: function(img: nk_image): nk_style_item; cdecl;
  nk_style_item_nine_slice_rtn: function(slice: nk_nine_slice): nk_style_item; cdecl;
  nk_style_item_hide: function(): nk_style_item; cdecl;
  nk_glfw3_init: function(win: PGLFWwindow; p2: nk_glfw_init_state): Pnk_context; cdecl;
  nk_glfw3_font_stash_begin: procedure(atlas: PPnk_font_atlas); cdecl;
  nk_glfw3_font_stash_end: procedure(); cdecl;
  nk_glfw3_new_frame: procedure(); cdecl;
  nk_glfw3_render: procedure(p1: nk_anti_aliasing); cdecl;
  nk_glfw3_shutdown: procedure(); cdecl;
  nk_glfw3_char_callback: procedure(win: PGLFWwindow; codepoint: Cardinal); cdecl;
  nk_gflw3_scroll_callback: procedure(win: PGLFWwindow; xoff: Double; yoff: Double); cdecl;
  gladLoadGL: function(load: GLADloadfunc): Integer; cdecl;
  lua_newstate: function(f: lua_Alloc; ud: Pointer): Plua_State; cdecl;
  lua_close: procedure(L: Plua_State); cdecl;
  lua_newthread: function(L: Plua_State): Plua_State; cdecl;
  lua_atpanic: function(L: Plua_State; panicf: lua_CFunction): lua_CFunction; cdecl;
  lua_gettop: function(L: Plua_State): Integer; cdecl;
  lua_settop: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_pushvalue: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_remove: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_insert: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_replace: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_checkstack: function(L: Plua_State; sz: Integer): Integer; cdecl;
  lua_xmove: procedure(from: Plua_State; &to: Plua_State; n: Integer); cdecl;
  lua_isnumber: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_isstring: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_iscfunction: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_isuserdata: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_type: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_typename: function(L: Plua_State; tp: Integer): PUTF8Char; cdecl;
  lua_equal: function(L: Plua_State; idx1: Integer; idx2: Integer): Integer; cdecl;
  lua_rawequal: function(L: Plua_State; idx1: Integer; idx2: Integer): Integer; cdecl;
  lua_lessthan: function(L: Plua_State; idx1: Integer; idx2: Integer): Integer; cdecl;
  lua_tonumber: function(L: Plua_State; idx: Integer): lua_Number; cdecl;
  lua_tointeger: function(L: Plua_State; idx: Integer): lua_Integer; cdecl;
  lua_toboolean: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_tolstring: function(L: Plua_State; idx: Integer; len: PNativeUInt): PUTF8Char; cdecl;
  lua_objlen: function(L: Plua_State; idx: Integer): NativeUInt; cdecl;
  lua_tocfunction: function(L: Plua_State; idx: Integer): lua_CFunction; cdecl;
  lua_touserdata: function(L: Plua_State; idx: Integer): Pointer; cdecl;
  lua_tothread: function(L: Plua_State; idx: Integer): Plua_State; cdecl;
  lua_topointer: function(L: Plua_State; idx: Integer): Pointer; cdecl;
  lua_pushnil: procedure(L: Plua_State); cdecl;
  lua_pushnumber: procedure(L: Plua_State; n: lua_Number); cdecl;
  lua_pushinteger: procedure(L: Plua_State; n: lua_Integer); cdecl;
lua_pushlstring: procedure(L: Plua_State; const s: PUTF8Char; len: NativeUInt); cdecl;
  lua_pushstring: procedure(L: Plua_State; const s: PUTF8Char); cdecl;
  lua_pushvfstring: function(L: Plua_State; const fmt: PUTF8Char; argp: Pointer): PUTF8Char; cdecl;
  lua_pushfstring: function(L: Plua_State; const fmt: PUTF8Char): PUTF8Char varargs; cdecl;
  lua_pushcclosure: procedure(L: Plua_State; fn: lua_CFunction; n: Integer); cdecl;
  lua_pushboolean: procedure(L: Plua_State; b: Integer); cdecl;
  lua_pushlightuserdata: procedure(L: Plua_State; p: Pointer); cdecl;
  lua_pushthread: function(L: Plua_State): Integer; cdecl;
  lua_gettable: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_getfield: procedure(L: Plua_State; idx: Integer; const k: PUTF8Char); cdecl;
  lua_rawget: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_rawgeti: procedure(L: Plua_State; idx: Integer; n: Integer); cdecl;
  lua_createtable: procedure(L: Plua_State; narr: Integer; nrec: Integer); cdecl;
  lua_newuserdata: function(L: Plua_State; sz: NativeUInt): Pointer; cdecl;
  lua_getmetatable: function(L: Plua_State; objindex: Integer): Integer; cdecl;
  lua_getfenv: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_settable: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_setfield: procedure(L: Plua_State; idx: Integer; const k: PUTF8Char); cdecl;
  lua_rawset: procedure(L: Plua_State; idx: Integer); cdecl;
  lua_rawseti: procedure(L: Plua_State; idx: Integer; n: Integer); cdecl;
  lua_setmetatable: function(L: Plua_State; objindex: Integer): Integer; cdecl;
  lua_setfenv: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_call: procedure(L: Plua_State; nargs: Integer; nresults: Integer); cdecl;
  lua_pcall: function(L: Plua_State; nargs: Integer; nresults: Integer; errfunc: Integer): Integer; cdecl;
  lua_cpcall: function(L: Plua_State; func: lua_CFunction; ud: Pointer): Integer; cdecl;
  lua_load: function(L: Plua_State; reader: lua_Reader; dt: Pointer; const chunkname: PUTF8Char): Integer; cdecl;
  lua_dump: function(L: Plua_State; writer: lua_Writer; data: Pointer): Integer; cdecl;
  lua_yield: function(L: Plua_State; nresults: Integer): Integer; cdecl;
  lua_resume: function(L: Plua_State; narg: Integer): Integer; cdecl;
  lua_status: function(L: Plua_State): Integer; cdecl;
  lua_gc: function(L: Plua_State; what: Integer; data: Integer): Integer; cdecl;
  lua_error: function(L: Plua_State): Integer; cdecl;
  lua_next: function(L: Plua_State; idx: Integer): Integer; cdecl;
  lua_concat: procedure(L: Plua_State; n: Integer); cdecl;
  lua_getallocf: function(L: Plua_State; ud: PPointer): lua_Alloc; cdecl;
  lua_setallocf: procedure(L: Plua_State; f: lua_Alloc; ud: Pointer); cdecl;
  lua_getstack: function(L: Plua_State; level: Integer; ar: Plua_Debug): Integer; cdecl;
  lua_getinfo: function(L: Plua_State; const what: PUTF8Char; ar: Plua_Debug): Integer; cdecl;
  lua_getlocal: function(L: Plua_State; const ar: Plua_Debug; n: Integer): PUTF8Char; cdecl;
  lua_setlocal: function(L: Plua_State; const ar: Plua_Debug; n: Integer): PUTF8Char; cdecl;
  lua_getupvalue: function(L: Plua_State; funcindex: Integer; n: Integer): PUTF8Char; cdecl;
  lua_setupvalue: function(L: Plua_State; funcindex: Integer; n: Integer): PUTF8Char; cdecl;
  lua_sethook: function(L: Plua_State; func: lua_Hook; mask: Integer; count: Integer): Integer; cdecl;
  lua_gethook: function(L: Plua_State): lua_Hook; cdecl;
  lua_gethookmask: function(L: Plua_State): Integer; cdecl;
  lua_gethookcount: function(L: Plua_State): Integer; cdecl;
  lua_upvalueid: function(L: Plua_State; idx: Integer; n: Integer): Pointer; cdecl;
  lua_upvaluejoin: procedure(L: Plua_State; idx1: Integer; n1: Integer; idx2: Integer; n2: Integer); cdecl;
  lua_loadx: function(L: Plua_State; reader: lua_Reader; dt: Pointer; const chunkname: PUTF8Char; const mode: PUTF8Char): Integer; cdecl;
  lua_version: function(L: Plua_State): Plua_Number; cdecl;
  lua_copy: procedure(L: Plua_State; fromidx: Integer; toidx: Integer); cdecl;
  lua_tonumberx: function(L: Plua_State; idx: Integer; isnum: PInteger): lua_Number; cdecl;
  lua_tointegerx: function(L: Plua_State; idx: Integer; isnum: PInteger): lua_Integer; cdecl;
  lua_isyieldable: function(L: Plua_State): Integer; cdecl;
  luaopen_base: function(L: Plua_State): Integer; cdecl;
  luaopen_math: function(L: Plua_State): Integer; cdecl;
  luaopen_string: function(L: Plua_State): Integer; cdecl;
  luaopen_table: function(L: Plua_State): Integer; cdecl;
  luaopen_io: function(L: Plua_State): Integer; cdecl;
  luaopen_os: function(L: Plua_State): Integer; cdecl;
  luaopen_package: function(L: Plua_State): Integer; cdecl;
  luaopen_debug: function(L: Plua_State): Integer; cdecl;
  luaopen_bit: function(L: Plua_State): Integer; cdecl;
  luaopen_jit: function(L: Plua_State): Integer; cdecl;
  luaopen_ffi: function(L: Plua_State): Integer; cdecl;
  luaopen_string_buffer: function(L: Plua_State): Integer; cdecl;
  luaL_openlibs: procedure(L: Plua_State); cdecl;
  luaL_openlib: procedure(L: Plua_State; const libname: PUTF8Char; const l_: PluaL_Reg; nup: Integer); cdecl;
  luaL_register: procedure(L: Plua_State; const libname: PUTF8Char; const l_: PluaL_Reg); cdecl;
  luaL_getmetafield: function(L: Plua_State; obj: Integer; const e: PUTF8Char): Integer; cdecl;
  luaL_callmeta: function(L: Plua_State; obj: Integer; const e: PUTF8Char): Integer; cdecl;
  luaL_typerror: function(L: Plua_State; narg: Integer; const tname: PUTF8Char): Integer; cdecl;
  luaL_argerror: function(L: Plua_State; numarg: Integer; const extramsg: PUTF8Char): Integer; cdecl;
  luaL_checklstring: function(L: Plua_State; numArg: Integer; l_: PNativeUInt): PUTF8Char; cdecl;
  luaL_optlstring: function(L: Plua_State; numArg: Integer; const def: PUTF8Char; l_: PNativeUInt): PUTF8Char; cdecl;
  luaL_checknumber: function(L: Plua_State; numArg: Integer): lua_Number; cdecl;
  luaL_optnumber: function(L: Plua_State; nArg: Integer; def: lua_Number): lua_Number; cdecl;
  luaL_checkinteger: function(L: Plua_State; numArg: Integer): lua_Integer; cdecl;
  luaL_optinteger: function(L: Plua_State; nArg: Integer; def: lua_Integer): lua_Integer; cdecl;
  luaL_checkstack: procedure(L: Plua_State; sz: Integer; const msg: PUTF8Char); cdecl;
  luaL_checktype: procedure(L: Plua_State; narg: Integer; t: Integer); cdecl;
  luaL_checkany: procedure(L: Plua_State; narg: Integer); cdecl;
  luaL_newmetatable: function(L: Plua_State; const tname: PUTF8Char): Integer; cdecl;
  luaL_checkudata: function(L: Plua_State; ud: Integer; const tname: PUTF8Char): Pointer; cdecl;
  luaL_where: procedure(L: Plua_State; lvl: Integer); cdecl;
  luaL_error: function(L: Plua_State; const fmt: PUTF8Char): Integer varargs; cdecl;
  luaL_checkoption: function(L: Plua_State; narg: Integer; const def: PUTF8Char; lst: PPUTF8Char): Integer; cdecl;
  luaL_ref: function(L: Plua_State; t: Integer): Integer; cdecl;
  luaL_unref: procedure(L: Plua_State; t: Integer; ref: Integer); cdecl;
  luaL_loadfile: function(L: Plua_State; const filename: PUTF8Char): Integer; cdecl;
  luaL_loadbuffer: function(L: Plua_State; const buff: PUTF8Char; sz: NativeUInt; const name: PUTF8Char): Integer; cdecl;
  luaL_loadstring: function(L: Plua_State; const s: PUTF8Char): Integer; cdecl;
  luaL_newstate: function(): Plua_State; cdecl;
  luaL_gsub: function(L: Plua_State; const s: PUTF8Char; const p: PUTF8Char; const r: PUTF8Char): PUTF8Char; cdecl;
  luaL_findtable: function(L: Plua_State; idx: Integer; const fname: PUTF8Char; szhint: Integer): PUTF8Char; cdecl;
  luaL_fileresult: function(L: Plua_State; stat: Integer; const fname: PUTF8Char): Integer; cdecl;
  luaL_execresult: function(L: Plua_State; stat: Integer): Integer; cdecl;
  luaL_loadfilex: function(L: Plua_State; const filename: PUTF8Char; const mode: PUTF8Char): Integer; cdecl;
  luaL_loadbufferx: function(L: Plua_State; const buff: PUTF8Char; sz: NativeUInt; const name: PUTF8Char; const mode: PUTF8Char): Integer; cdecl;
  luaL_traceback: procedure(L: Plua_State; L1: Plua_State; const msg: PUTF8Char; level: Integer); cdecl;
  luaL_setfuncs: procedure(L: Plua_State; const l_: PluaL_Reg; nup: Integer); cdecl;
  luaL_pushmodule: procedure(L: Plua_State; const modname: PUTF8Char; sizehint: Integer); cdecl;
  luaL_testudata: function(L: Plua_State; ud: Integer; const tname: PUTF8Char): Pointer; cdecl;
  luaL_setmetatable: procedure(L: Plua_State; const tname: PUTF8Char); cdecl;
  luaL_buffinit: procedure(L: Plua_State; B: PluaL_Buffer); cdecl;
  luaL_prepbuffer: function(B: PluaL_Buffer): PUTF8Char; cdecl;
  luaL_addlstring: procedure(B: PluaL_Buffer; const s: PUTF8Char; l: NativeUInt); cdecl;
  luaL_addstring: procedure(B: PluaL_Buffer; const s: PUTF8Char); cdecl;
  luaL_addvalue: procedure(B: PluaL_Buffer); cdecl;
  luaL_pushresult: procedure(B: PluaL_Buffer); cdecl;
  luaJIT_setmode: function(L: Plua_State; idx: Integer; mode: Integer): Integer; cdecl;
  luaJIT_profile_start: procedure(L: Plua_State; const mode: PUTF8Char; cb: luaJIT_profile_callback; data: Pointer); cdecl;
  luaJIT_profile_stop: procedure(L: Plua_State); cdecl;
  luaJIT_profile_dumpstack: function(L: Plua_State; const fmt: PUTF8Char; depth: Integer; len: PNativeUInt): PUTF8Char; cdecl;
  luaJIT_version_2_1_1697887905: procedure(); cdecl;

{$REGION ' Lua Macros ' }
function lua_isfunction(aState: Pointer; n: Integer): Boolean; inline;
function lua_isvariable(aState: Pointer; n: Integer): Boolean; inline;
procedure lua_newtable(aState: Pointer); inline;
procedure lua_pop(aState: Pointer; n: Integer); inline;
procedure lua_getglobal(aState: Pointer; aName: PAnsiChar); inline;
procedure lua_setglobal(aState: Pointer; aName: PAnsiChar); inline;
procedure lua_pushcfunction(aState: Pointer; aFunc: lua_CFunction); inline;
procedure lua_register(aState: Pointer; aName: PAnsiChar; aFunc: lua_CFunction); inline;
function lua_isnil(aState: Pointer; n: Integer): Boolean; inline;
function lua_tostring(aState: Pointer; idx: Integer): string; inline;
function luaL_dofile(aState: Pointer; aFilename: PAnsiChar): Integer; inline;
function luaL_dostring(aState: Pointer; aStr: PAnsiChar): Integer; inline;
function luaL_dobuffer(aState: Pointer; aBuffer: Pointer; aSize: NativeUInt; aName: PAnsiChar): Integer; inline;
function lua_upvalueindex(i: Integer): Integer; inline;
{$ENDREGION}

procedure GetExports(const aDLLHandle: THandle);

implementation

{$REGION ' Lua Macros ' }
function lua_isfunction(aState: Pointer; n: Integer): Boolean; inline;
begin
  Result := Boolean(lua_type(aState, n) = LUA_TFUNCTION);
end;

function lua_isvariable(aState: Pointer; n: Integer): Boolean; inline;
var
  aType: Integer;
begin
  aType := lua_type(aState, n);

  if (aType = LUA_TBOOLEAN) or (aType = LUA_TLIGHTUSERDATA) or (aType = LUA_TNUMBER) or (aType = LUA_TSTRING) then
    Result := True
  else
    Result := False;
end;

procedure lua_newtable(aState: Pointer); inline;
begin
  lua_createtable(aState, 0, 0);
end;

procedure lua_pop(aState: Pointer; n: Integer); inline;
begin
  lua_settop(aState, -n - 1);
end;

procedure lua_getglobal(aState: Pointer; aName: PAnsiChar); inline;
begin
  lua_getfield(aState, LUA_GLOBALSINDEX, aName);
end;

procedure lua_setglobal(aState: Pointer; aName: PAnsiChar); inline;
begin
  lua_setfield(aState, LUA_GLOBALSINDEX, aName);
end;

procedure lua_pushcfunction(aState: Pointer; aFunc: lua_CFunction); inline;
begin
  lua_pushcclosure(aState, aFunc, 0);
end;

procedure lua_register(aState: Pointer; aName: PAnsiChar; aFunc: lua_CFunction); inline;
begin
  lua_pushcfunction(aState, aFunc);
  lua_setglobal(aState, aName);
end;

function lua_isnil(aState: Pointer; n: Integer): Boolean; inline;
begin
  Result := Boolean(lua_type(aState, n) = LUA_TNIL);
end;

function lua_tostring(aState: Pointer; idx: Integer): string; inline;
begin
  Result := string(lua_tolstring(aState, idx, nil));
end;

function luaL_dofile(aState: Pointer; aFilename: PAnsiChar): Integer; inline;
Var
  Res: Integer;
begin
  Res := luaL_loadfile(aState, aFilename);
  if Res = 0 then
    Res := lua_pcall(aState, 0, 0, 0);
  Result := Res;
end;

function luaL_dostring(aState: Pointer; aStr: PAnsiChar): Integer; inline;
Var
  Res: Integer;
begin
  Res := luaL_loadstring(aState, aStr);
  if Res = 0 then
    Res := lua_pcall(aState, 0, 0, 0);
  Result := Res;
end;

function luaL_dobuffer(aState: Pointer; aBuffer: Pointer; aSize: NativeUInt;
  aName: PAnsiChar): Integer; inline;
var
  Res: Integer;
begin
  Res := luaL_loadbuffer(aState, aBuffer, aSize, aName);
  if Res = 0 then
    Res := lua_pcall(aState, 0, 0, 0);
  Result := Res;
end;

function lua_upvalueindex(i: Integer): Integer; inline;
begin
  Result := LUA_GLOBALSINDEX - i;
end;
{$ENDREGION}

procedure GetExports(const aDLLHandle: THandle);
begin
  if aDllHandle = 0 then Exit;
  alBuffer3f := GetProcAddress(aDLLHandle, 'alBuffer3f');
  alBuffer3i := GetProcAddress(aDLLHandle, 'alBuffer3i');
  alBufferData := GetProcAddress(aDLLHandle, 'alBufferData');
  alBufferf := GetProcAddress(aDLLHandle, 'alBufferf');
  alBufferfv := GetProcAddress(aDLLHandle, 'alBufferfv');
  alBufferi := GetProcAddress(aDLLHandle, 'alBufferi');
  alBufferiv := GetProcAddress(aDLLHandle, 'alBufferiv');
  alcCaptureCloseDevice := GetProcAddress(aDLLHandle, 'alcCaptureCloseDevice');
  alcCaptureOpenDevice := GetProcAddress(aDLLHandle, 'alcCaptureOpenDevice');
  alcCaptureSamples := GetProcAddress(aDLLHandle, 'alcCaptureSamples');
  alcCaptureStart := GetProcAddress(aDLLHandle, 'alcCaptureStart');
  alcCaptureStop := GetProcAddress(aDLLHandle, 'alcCaptureStop');
  alcCloseDevice := GetProcAddress(aDLLHandle, 'alcCloseDevice');
  alcCreateContext := GetProcAddress(aDLLHandle, 'alcCreateContext');
  alcDestroyContext := GetProcAddress(aDLLHandle, 'alcDestroyContext');
  alcGetContextsDevice := GetProcAddress(aDLLHandle, 'alcGetContextsDevice');
  alcGetCurrentContext := GetProcAddress(aDLLHandle, 'alcGetCurrentContext');
  alcGetEnumValue := GetProcAddress(aDLLHandle, 'alcGetEnumValue');
  alcGetError := GetProcAddress(aDLLHandle, 'alcGetError');
  alcGetIntegerv := GetProcAddress(aDLLHandle, 'alcGetIntegerv');
  alcGetProcAddress := GetProcAddress(aDLLHandle, 'alcGetProcAddress');
  alcGetString := GetProcAddress(aDLLHandle, 'alcGetString');
  alcIsExtensionPresent := GetProcAddress(aDLLHandle, 'alcIsExtensionPresent');
  alcMakeContextCurrent := GetProcAddress(aDLLHandle, 'alcMakeContextCurrent');
  alcOpenDevice := GetProcAddress(aDLLHandle, 'alcOpenDevice');
  alcProcessContext := GetProcAddress(aDLLHandle, 'alcProcessContext');
  alcSuspendContext := GetProcAddress(aDLLHandle, 'alcSuspendContext');
  alDeleteBuffers := GetProcAddress(aDLLHandle, 'alDeleteBuffers');
  alDeleteSources := GetProcAddress(aDLLHandle, 'alDeleteSources');
  alDisable := GetProcAddress(aDLLHandle, 'alDisable');
  alDistanceModel := GetProcAddress(aDLLHandle, 'alDistanceModel');
  alDopplerFactor := GetProcAddress(aDLLHandle, 'alDopplerFactor');
  alDopplerVelocity := GetProcAddress(aDLLHandle, 'alDopplerVelocity');
  alEnable := GetProcAddress(aDLLHandle, 'alEnable');
  alGenBuffers := GetProcAddress(aDLLHandle, 'alGenBuffers');
  alGenSources := GetProcAddress(aDLLHandle, 'alGenSources');
  alGetBoolean := GetProcAddress(aDLLHandle, 'alGetBoolean');
  alGetBooleanv := GetProcAddress(aDLLHandle, 'alGetBooleanv');
  alGetBuffer3f := GetProcAddress(aDLLHandle, 'alGetBuffer3f');
  alGetBuffer3i := GetProcAddress(aDLLHandle, 'alGetBuffer3i');
  alGetBufferf := GetProcAddress(aDLLHandle, 'alGetBufferf');
  alGetBufferfv := GetProcAddress(aDLLHandle, 'alGetBufferfv');
  alGetBufferi := GetProcAddress(aDLLHandle, 'alGetBufferi');
  alGetBufferiv := GetProcAddress(aDLLHandle, 'alGetBufferiv');
  alGetDouble := GetProcAddress(aDLLHandle, 'alGetDouble');
  alGetDoublev := GetProcAddress(aDLLHandle, 'alGetDoublev');
  alGetEnumValue := GetProcAddress(aDLLHandle, 'alGetEnumValue');
  alGetError := GetProcAddress(aDLLHandle, 'alGetError');
  alGetFloat := GetProcAddress(aDLLHandle, 'alGetFloat');
  alGetFloatv := GetProcAddress(aDLLHandle, 'alGetFloatv');
  alGetInteger := GetProcAddress(aDLLHandle, 'alGetInteger');
  alGetIntegerv := GetProcAddress(aDLLHandle, 'alGetIntegerv');
  alGetListener3f := GetProcAddress(aDLLHandle, 'alGetListener3f');
  alGetListener3i := GetProcAddress(aDLLHandle, 'alGetListener3i');
  alGetListenerf := GetProcAddress(aDLLHandle, 'alGetListenerf');
  alGetListenerfv := GetProcAddress(aDLLHandle, 'alGetListenerfv');
  alGetListeneri := GetProcAddress(aDLLHandle, 'alGetListeneri');
  alGetListeneriv := GetProcAddress(aDLLHandle, 'alGetListeneriv');
  alGetProcAddress := GetProcAddress(aDLLHandle, 'alGetProcAddress');
  alGetSource3f := GetProcAddress(aDLLHandle, 'alGetSource3f');
  alGetSource3i := GetProcAddress(aDLLHandle, 'alGetSource3i');
  alGetSourcef := GetProcAddress(aDLLHandle, 'alGetSourcef');
  alGetSourcefv := GetProcAddress(aDLLHandle, 'alGetSourcefv');
  alGetSourcei := GetProcAddress(aDLLHandle, 'alGetSourcei');
  alGetSourceiv := GetProcAddress(aDLLHandle, 'alGetSourceiv');
  alGetString := GetProcAddress(aDLLHandle, 'alGetString');
  alIsBuffer := GetProcAddress(aDLLHandle, 'alIsBuffer');
  alIsEnabled := GetProcAddress(aDLLHandle, 'alIsEnabled');
  alIsExtensionPresent := GetProcAddress(aDLLHandle, 'alIsExtensionPresent');
  alIsSource := GetProcAddress(aDLLHandle, 'alIsSource');
  alListener3f := GetProcAddress(aDLLHandle, 'alListener3f');
  alListener3i := GetProcAddress(aDLLHandle, 'alListener3i');
  alListenerf := GetProcAddress(aDLLHandle, 'alListenerf');
  alListenerfv := GetProcAddress(aDLLHandle, 'alListenerfv');
  alListeneri := GetProcAddress(aDLLHandle, 'alListeneri');
  alListeneriv := GetProcAddress(aDLLHandle, 'alListeneriv');
  alSource3f := GetProcAddress(aDLLHandle, 'alSource3f');
  alSource3i := GetProcAddress(aDLLHandle, 'alSource3i');
  alSourcef := GetProcAddress(aDLLHandle, 'alSourcef');
  alSourcefv := GetProcAddress(aDLLHandle, 'alSourcefv');
  alSourcei := GetProcAddress(aDLLHandle, 'alSourcei');
  alSourceiv := GetProcAddress(aDLLHandle, 'alSourceiv');
  alSourcePause := GetProcAddress(aDLLHandle, 'alSourcePause');
  alSourcePausev := GetProcAddress(aDLLHandle, 'alSourcePausev');
  alSourcePlay := GetProcAddress(aDLLHandle, 'alSourcePlay');
  alSourcePlayv := GetProcAddress(aDLLHandle, 'alSourcePlayv');
  alSourceQueueBuffers := GetProcAddress(aDLLHandle, 'alSourceQueueBuffers');
  alSourceRewind := GetProcAddress(aDLLHandle, 'alSourceRewind');
  alSourceRewindv := GetProcAddress(aDLLHandle, 'alSourceRewindv');
  alSourceStop := GetProcAddress(aDLLHandle, 'alSourceStop');
  alSourceStopv := GetProcAddress(aDLLHandle, 'alSourceStopv');
  alSourceUnqueueBuffers := GetProcAddress(aDLLHandle, 'alSourceUnqueueBuffers');
  alSpeedOfSound := GetProcAddress(aDLLHandle, 'alSpeedOfSound');
  c2AABBtoAABB := GetProcAddress(aDLLHandle, 'c2AABBtoAABB');
  c2AABBtoAABBManifold := GetProcAddress(aDLLHandle, 'c2AABBtoAABBManifold');
  c2AABBtoCapsule := GetProcAddress(aDLLHandle, 'c2AABBtoCapsule');
  c2AABBtoCapsuleManifold := GetProcAddress(aDLLHandle, 'c2AABBtoCapsuleManifold');
  c2AABBtoPoly := GetProcAddress(aDLLHandle, 'c2AABBtoPoly');
  c2AABBtoPolyManifold := GetProcAddress(aDLLHandle, 'c2AABBtoPolyManifold');
  c2CapsuletoCapsule := GetProcAddress(aDLLHandle, 'c2CapsuletoCapsule');
  c2CapsuletoCapsuleManifold := GetProcAddress(aDLLHandle, 'c2CapsuletoCapsuleManifold');
  c2CapsuletoPoly := GetProcAddress(aDLLHandle, 'c2CapsuletoPoly');
  c2CapsuletoPolyManifold := GetProcAddress(aDLLHandle, 'c2CapsuletoPolyManifold');
  c2CastRay := GetProcAddress(aDLLHandle, 'c2CastRay');
  c2CircletoAABB := GetProcAddress(aDLLHandle, 'c2CircletoAABB');
  c2CircletoAABBManifold := GetProcAddress(aDLLHandle, 'c2CircletoAABBManifold');
  c2CircletoCapsule := GetProcAddress(aDLLHandle, 'c2CircletoCapsule');
  c2CircletoCapsuleManifold := GetProcAddress(aDLLHandle, 'c2CircletoCapsuleManifold');
  c2CircletoCircle := GetProcAddress(aDLLHandle, 'c2CircletoCircle');
  c2CircletoCircleManifold := GetProcAddress(aDLLHandle, 'c2CircletoCircleManifold');
  c2CircletoPoly := GetProcAddress(aDLLHandle, 'c2CircletoPoly');
  c2CircletoPolyManifold := GetProcAddress(aDLLHandle, 'c2CircletoPolyManifold');
  c2Collide := GetProcAddress(aDLLHandle, 'c2Collide');
  c2Collided := GetProcAddress(aDLLHandle, 'c2Collided');
  c2GJK := GetProcAddress(aDLLHandle, 'c2GJK');
  c2Hull := GetProcAddress(aDLLHandle, 'c2Hull');
  c2Inflate := GetProcAddress(aDLLHandle, 'c2Inflate');
  c2MakePoly := GetProcAddress(aDLLHandle, 'c2MakePoly');
  c2Norms := GetProcAddress(aDLLHandle, 'c2Norms');
  c2PolytoPoly := GetProcAddress(aDLLHandle, 'c2PolytoPoly');
  c2PolytoPolyManifold := GetProcAddress(aDLLHandle, 'c2PolytoPolyManifold');
  c2RaytoAABB := GetProcAddress(aDLLHandle, 'c2RaytoAABB');
  c2RaytoCapsule := GetProcAddress(aDLLHandle, 'c2RaytoCapsule');
  c2RaytoCircle := GetProcAddress(aDLLHandle, 'c2RaytoCircle');
  c2RaytoPoly := GetProcAddress(aDLLHandle, 'c2RaytoPoly');
  c2TOI := GetProcAddress(aDLLHandle, 'c2TOI');
  clog_debug := GetProcAddress(aDLLHandle, 'clog_debug');
  clog_error := GetProcAddress(aDLLHandle, 'clog_error');
  clog_free := GetProcAddress(aDLLHandle, 'clog_free');
  clog_info := GetProcAddress(aDLLHandle, 'clog_info');
  clog_init_path := GetProcAddress(aDLLHandle, 'clog_init_path');
  clog_set_date_fmt := GetProcAddress(aDLLHandle, 'clog_set_date_fmt');
  clog_set_fmt := GetProcAddress(aDLLHandle, 'clog_set_fmt');
  clog_set_level := GetProcAddress(aDLLHandle, 'clog_set_level');
  clog_set_time_fmt := GetProcAddress(aDLLHandle, 'clog_set_time_fmt');
  clog_warn := GetProcAddress(aDLLHandle, 'clog_warn');
  crc32 := GetProcAddress(aDLLHandle, 'crc32');
  gladLoadGL := GetProcAddress(aDLLHandle, 'gladLoadGL');
  glfwCreateCursor := GetProcAddress(aDLLHandle, 'glfwCreateCursor');
  glfwCreateStandardCursor := GetProcAddress(aDLLHandle, 'glfwCreateStandardCursor');
  glfwCreateWindow := GetProcAddress(aDLLHandle, 'glfwCreateWindow');
  glfwDefaultWindowHints := GetProcAddress(aDLLHandle, 'glfwDefaultWindowHints');
  glfwDestroyCursor := GetProcAddress(aDLLHandle, 'glfwDestroyCursor');
  glfwDestroyWindow := GetProcAddress(aDLLHandle, 'glfwDestroyWindow');
  glfwExtensionSupported := GetProcAddress(aDLLHandle, 'glfwExtensionSupported');
  glfwFocusWindow := GetProcAddress(aDLLHandle, 'glfwFocusWindow');
  glfwGetClipboardString := GetProcAddress(aDLLHandle, 'glfwGetClipboardString');
  glfwGetCurrentContext := GetProcAddress(aDLLHandle, 'glfwGetCurrentContext');
  glfwGetCursorPos := GetProcAddress(aDLLHandle, 'glfwGetCursorPos');
  glfwGetError := GetProcAddress(aDLLHandle, 'glfwGetError');
  glfwGetFramebufferSize := GetProcAddress(aDLLHandle, 'glfwGetFramebufferSize');
  glfwGetGamepadName := GetProcAddress(aDLLHandle, 'glfwGetGamepadName');
  glfwGetGamepadState := GetProcAddress(aDLLHandle, 'glfwGetGamepadState');
  glfwGetGammaRamp := GetProcAddress(aDLLHandle, 'glfwGetGammaRamp');
  glfwGetInputMode := GetProcAddress(aDLLHandle, 'glfwGetInputMode');
  glfwGetJoystickAxes := GetProcAddress(aDLLHandle, 'glfwGetJoystickAxes');
  glfwGetJoystickButtons := GetProcAddress(aDLLHandle, 'glfwGetJoystickButtons');
  glfwGetJoystickGUID := GetProcAddress(aDLLHandle, 'glfwGetJoystickGUID');
  glfwGetJoystickHats := GetProcAddress(aDLLHandle, 'glfwGetJoystickHats');
  glfwGetJoystickName := GetProcAddress(aDLLHandle, 'glfwGetJoystickName');
  glfwGetJoystickUserPointer := GetProcAddress(aDLLHandle, 'glfwGetJoystickUserPointer');
  glfwGetKey := GetProcAddress(aDLLHandle, 'glfwGetKey');
  glfwGetKeyName := GetProcAddress(aDLLHandle, 'glfwGetKeyName');
  glfwGetKeyScancode := GetProcAddress(aDLLHandle, 'glfwGetKeyScancode');
  glfwGetMonitorContentScale := GetProcAddress(aDLLHandle, 'glfwGetMonitorContentScale');
  glfwGetMonitorName := GetProcAddress(aDLLHandle, 'glfwGetMonitorName');
  glfwGetMonitorPhysicalSize := GetProcAddress(aDLLHandle, 'glfwGetMonitorPhysicalSize');
  glfwGetMonitorPos := GetProcAddress(aDLLHandle, 'glfwGetMonitorPos');
  glfwGetMonitors := GetProcAddress(aDLLHandle, 'glfwGetMonitors');
  glfwGetMonitorUserPointer := GetProcAddress(aDLLHandle, 'glfwGetMonitorUserPointer');
  glfwGetMonitorWorkarea := GetProcAddress(aDLLHandle, 'glfwGetMonitorWorkarea');
  glfwGetMouseButton := GetProcAddress(aDLLHandle, 'glfwGetMouseButton');
  glfwGetPlatform := GetProcAddress(aDLLHandle, 'glfwGetPlatform');
  glfwGetPrimaryMonitor := GetProcAddress(aDLLHandle, 'glfwGetPrimaryMonitor');
  glfwGetProcAddress := GetProcAddress(aDLLHandle, 'glfwGetProcAddress');
  glfwGetRequiredInstanceExtensions := GetProcAddress(aDLLHandle, 'glfwGetRequiredInstanceExtensions');
  glfwGetTime := GetProcAddress(aDLLHandle, 'glfwGetTime');
  glfwGetTimerFrequency := GetProcAddress(aDLLHandle, 'glfwGetTimerFrequency');
  glfwGetTimerValue := GetProcAddress(aDLLHandle, 'glfwGetTimerValue');
  glfwGetVersion := GetProcAddress(aDLLHandle, 'glfwGetVersion');
  glfwGetVersionString := GetProcAddress(aDLLHandle, 'glfwGetVersionString');
  glfwGetVideoMode := GetProcAddress(aDLLHandle, 'glfwGetVideoMode');
  glfwGetVideoModes := GetProcAddress(aDLLHandle, 'glfwGetVideoModes');
  glfwGetWin32Adapter := GetProcAddress(aDLLHandle, 'glfwGetWin32Adapter');
  glfwGetWin32Monitor := GetProcAddress(aDLLHandle, 'glfwGetWin32Monitor');
  glfwGetWin32Window := GetProcAddress(aDLLHandle, 'glfwGetWin32Window');
  glfwGetWindowAttrib := GetProcAddress(aDLLHandle, 'glfwGetWindowAttrib');
  glfwGetWindowContentScale := GetProcAddress(aDLLHandle, 'glfwGetWindowContentScale');
  glfwGetWindowFrameSize := GetProcAddress(aDLLHandle, 'glfwGetWindowFrameSize');
  glfwGetWindowMonitor := GetProcAddress(aDLLHandle, 'glfwGetWindowMonitor');
  glfwGetWindowOpacity := GetProcAddress(aDLLHandle, 'glfwGetWindowOpacity');
  glfwGetWindowPos := GetProcAddress(aDLLHandle, 'glfwGetWindowPos');
  glfwGetWindowSize := GetProcAddress(aDLLHandle, 'glfwGetWindowSize');
  glfwGetWindowUserPointer := GetProcAddress(aDLLHandle, 'glfwGetWindowUserPointer');
  glfwHideWindow := GetProcAddress(aDLLHandle, 'glfwHideWindow');
  glfwIconifyWindow := GetProcAddress(aDLLHandle, 'glfwIconifyWindow');
  glfwInit := GetProcAddress(aDLLHandle, 'glfwInit');
  glfwInitAllocator := GetProcAddress(aDLLHandle, 'glfwInitAllocator');
  glfwInitHint := GetProcAddress(aDLLHandle, 'glfwInitHint');
  glfwJoystickIsGamepad := GetProcAddress(aDLLHandle, 'glfwJoystickIsGamepad');
  glfwJoystickPresent := GetProcAddress(aDLLHandle, 'glfwJoystickPresent');
  glfwMakeContextCurrent := GetProcAddress(aDLLHandle, 'glfwMakeContextCurrent');
  glfwMaximizeWindow := GetProcAddress(aDLLHandle, 'glfwMaximizeWindow');
  glfwPlatformSupported := GetProcAddress(aDLLHandle, 'glfwPlatformSupported');
  glfwPollEvents := GetProcAddress(aDLLHandle, 'glfwPollEvents');
  glfwPostEmptyEvent := GetProcAddress(aDLLHandle, 'glfwPostEmptyEvent');
  glfwRawMouseMotionSupported := GetProcAddress(aDLLHandle, 'glfwRawMouseMotionSupported');
  glfwRequestWindowAttention := GetProcAddress(aDLLHandle, 'glfwRequestWindowAttention');
  glfwRestoreWindow := GetProcAddress(aDLLHandle, 'glfwRestoreWindow');
  glfwSetCharCallback := GetProcAddress(aDLLHandle, 'glfwSetCharCallback');
  glfwSetCharModsCallback := GetProcAddress(aDLLHandle, 'glfwSetCharModsCallback');
  glfwSetClipboardString := GetProcAddress(aDLLHandle, 'glfwSetClipboardString');
  glfwSetCursor := GetProcAddress(aDLLHandle, 'glfwSetCursor');
  glfwSetCursorEnterCallback := GetProcAddress(aDLLHandle, 'glfwSetCursorEnterCallback');
  glfwSetCursorPos := GetProcAddress(aDLLHandle, 'glfwSetCursorPos');
  glfwSetCursorPosCallback := GetProcAddress(aDLLHandle, 'glfwSetCursorPosCallback');
  glfwSetDropCallback := GetProcAddress(aDLLHandle, 'glfwSetDropCallback');
  glfwSetErrorCallback := GetProcAddress(aDLLHandle, 'glfwSetErrorCallback');
  glfwSetFramebufferSizeCallback := GetProcAddress(aDLLHandle, 'glfwSetFramebufferSizeCallback');
  glfwSetGamma := GetProcAddress(aDLLHandle, 'glfwSetGamma');
  glfwSetGammaRamp := GetProcAddress(aDLLHandle, 'glfwSetGammaRamp');
  glfwSetInputMode := GetProcAddress(aDLLHandle, 'glfwSetInputMode');
  glfwSetJoystickCallback := GetProcAddress(aDLLHandle, 'glfwSetJoystickCallback');
  glfwSetJoystickUserPointer := GetProcAddress(aDLLHandle, 'glfwSetJoystickUserPointer');
  glfwSetKeyCallback := GetProcAddress(aDLLHandle, 'glfwSetKeyCallback');
  glfwSetMonitorCallback := GetProcAddress(aDLLHandle, 'glfwSetMonitorCallback');
  glfwSetMonitorUserPointer := GetProcAddress(aDLLHandle, 'glfwSetMonitorUserPointer');
  glfwSetMouseButtonCallback := GetProcAddress(aDLLHandle, 'glfwSetMouseButtonCallback');
  glfwSetScrollCallback := GetProcAddress(aDLLHandle, 'glfwSetScrollCallback');
  glfwSetTime := GetProcAddress(aDLLHandle, 'glfwSetTime');
  glfwSetWindowAspectRatio := GetProcAddress(aDLLHandle, 'glfwSetWindowAspectRatio');
  glfwSetWindowAttrib := GetProcAddress(aDLLHandle, 'glfwSetWindowAttrib');
  glfwSetWindowCloseCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowCloseCallback');
  glfwSetWindowContentScaleCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowContentScaleCallback');
  glfwSetWindowFocusCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowFocusCallback');
  glfwSetWindowIcon := GetProcAddress(aDLLHandle, 'glfwSetWindowIcon');
  glfwSetWindowIconifyCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowIconifyCallback');
  glfwSetWindowMaximizeCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowMaximizeCallback');
  glfwSetWindowMonitor := GetProcAddress(aDLLHandle, 'glfwSetWindowMonitor');
  glfwSetWindowOpacity := GetProcAddress(aDLLHandle, 'glfwSetWindowOpacity');
  glfwSetWindowPos := GetProcAddress(aDLLHandle, 'glfwSetWindowPos');
  glfwSetWindowPosCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowPosCallback');
  glfwSetWindowRefreshCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowRefreshCallback');
  glfwSetWindowShouldClose := GetProcAddress(aDLLHandle, 'glfwSetWindowShouldClose');
  glfwSetWindowSize := GetProcAddress(aDLLHandle, 'glfwSetWindowSize');
  glfwSetWindowSizeCallback := GetProcAddress(aDLLHandle, 'glfwSetWindowSizeCallback');
  glfwSetWindowSizeLimits := GetProcAddress(aDLLHandle, 'glfwSetWindowSizeLimits');
  glfwSetWindowTitle := GetProcAddress(aDLLHandle, 'glfwSetWindowTitle');
  glfwSetWindowUserPointer := GetProcAddress(aDLLHandle, 'glfwSetWindowUserPointer');
  glfwShowWindow := GetProcAddress(aDLLHandle, 'glfwShowWindow');
  glfwSwapBuffers := GetProcAddress(aDLLHandle, 'glfwSwapBuffers');
  glfwSwapInterval := GetProcAddress(aDLLHandle, 'glfwSwapInterval');
  glfwTerminate := GetProcAddress(aDLLHandle, 'glfwTerminate');
  glfwUpdateGamepadMappings := GetProcAddress(aDLLHandle, 'glfwUpdateGamepadMappings');
  glfwVulkanSupported := GetProcAddress(aDLLHandle, 'glfwVulkanSupported');
  glfwWaitEvents := GetProcAddress(aDLLHandle, 'glfwWaitEvents');
  glfwWaitEventsTimeout := GetProcAddress(aDLLHandle, 'glfwWaitEventsTimeout');
  glfwWindowHint := GetProcAddress(aDLLHandle, 'glfwWindowHint');
  glfwWindowHintString := GetProcAddress(aDLLHandle, 'glfwWindowHintString');
  glfwWindowShouldClose := GetProcAddress(aDLLHandle, 'glfwWindowShouldClose');
  lua_atpanic := GetProcAddress(aDLLHandle, 'lua_atpanic');
  lua_call := GetProcAddress(aDLLHandle, 'lua_call');
  lua_checkstack := GetProcAddress(aDLLHandle, 'lua_checkstack');
  lua_close := GetProcAddress(aDLLHandle, 'lua_close');
  lua_concat := GetProcAddress(aDLLHandle, 'lua_concat');
  lua_copy := GetProcAddress(aDLLHandle, 'lua_copy');
  lua_cpcall := GetProcAddress(aDLLHandle, 'lua_cpcall');
  lua_createtable := GetProcAddress(aDLLHandle, 'lua_createtable');
  lua_dump := GetProcAddress(aDLLHandle, 'lua_dump');
  lua_equal := GetProcAddress(aDLLHandle, 'lua_equal');
  lua_error := GetProcAddress(aDLLHandle, 'lua_error');
  lua_gc := GetProcAddress(aDLLHandle, 'lua_gc');
  lua_getallocf := GetProcAddress(aDLLHandle, 'lua_getallocf');
  lua_getfenv := GetProcAddress(aDLLHandle, 'lua_getfenv');
  lua_getfield := GetProcAddress(aDLLHandle, 'lua_getfield');
  lua_gethook := GetProcAddress(aDLLHandle, 'lua_gethook');
  lua_gethookcount := GetProcAddress(aDLLHandle, 'lua_gethookcount');
  lua_gethookmask := GetProcAddress(aDLLHandle, 'lua_gethookmask');
  lua_getinfo := GetProcAddress(aDLLHandle, 'lua_getinfo');
  lua_getlocal := GetProcAddress(aDLLHandle, 'lua_getlocal');
  lua_getmetatable := GetProcAddress(aDLLHandle, 'lua_getmetatable');
  lua_getstack := GetProcAddress(aDLLHandle, 'lua_getstack');
  lua_gettable := GetProcAddress(aDLLHandle, 'lua_gettable');
  lua_gettop := GetProcAddress(aDLLHandle, 'lua_gettop');
  lua_getupvalue := GetProcAddress(aDLLHandle, 'lua_getupvalue');
  lua_insert := GetProcAddress(aDLLHandle, 'lua_insert');
  lua_iscfunction := GetProcAddress(aDLLHandle, 'lua_iscfunction');
  lua_isnumber := GetProcAddress(aDLLHandle, 'lua_isnumber');
  lua_isstring := GetProcAddress(aDLLHandle, 'lua_isstring');
  lua_isuserdata := GetProcAddress(aDLLHandle, 'lua_isuserdata');
  lua_isyieldable := GetProcAddress(aDLLHandle, 'lua_isyieldable');
  lua_lessthan := GetProcAddress(aDLLHandle, 'lua_lessthan');
  lua_load := GetProcAddress(aDLLHandle, 'lua_load');
  lua_loadx := GetProcAddress(aDLLHandle, 'lua_loadx');
  lua_newstate := GetProcAddress(aDLLHandle, 'lua_newstate');
  lua_newthread := GetProcAddress(aDLLHandle, 'lua_newthread');
  lua_newuserdata := GetProcAddress(aDLLHandle, 'lua_newuserdata');
  lua_next := GetProcAddress(aDLLHandle, 'lua_next');
  lua_objlen := GetProcAddress(aDLLHandle, 'lua_objlen');
  lua_pcall := GetProcAddress(aDLLHandle, 'lua_pcall');
  lua_pushboolean := GetProcAddress(aDLLHandle, 'lua_pushboolean');
  lua_pushcclosure := GetProcAddress(aDLLHandle, 'lua_pushcclosure');
  lua_pushfstring := GetProcAddress(aDLLHandle, 'lua_pushfstring');
  lua_pushinteger := GetProcAddress(aDLLHandle, 'lua_pushinteger');
  lua_pushlightuserdata := GetProcAddress(aDLLHandle, 'lua_pushlightuserdata');
  lua_pushlstring := GetProcAddress(aDLLHandle, 'lua_pushlstring');
  lua_pushnil := GetProcAddress(aDLLHandle, 'lua_pushnil');
  lua_pushnumber := GetProcAddress(aDLLHandle, 'lua_pushnumber');
  lua_pushstring := GetProcAddress(aDLLHandle, 'lua_pushstring');
  lua_pushthread := GetProcAddress(aDLLHandle, 'lua_pushthread');
  lua_pushvalue := GetProcAddress(aDLLHandle, 'lua_pushvalue');
  lua_pushvfstring := GetProcAddress(aDLLHandle, 'lua_pushvfstring');
  lua_rawequal := GetProcAddress(aDLLHandle, 'lua_rawequal');
  lua_rawget := GetProcAddress(aDLLHandle, 'lua_rawget');
  lua_rawgeti := GetProcAddress(aDLLHandle, 'lua_rawgeti');
  lua_rawset := GetProcAddress(aDLLHandle, 'lua_rawset');
  lua_rawseti := GetProcAddress(aDLLHandle, 'lua_rawseti');
  lua_remove := GetProcAddress(aDLLHandle, 'lua_remove');
  lua_replace := GetProcAddress(aDLLHandle, 'lua_replace');
  lua_resume := GetProcAddress(aDLLHandle, 'lua_resume');
  lua_setallocf := GetProcAddress(aDLLHandle, 'lua_setallocf');
  lua_setfenv := GetProcAddress(aDLLHandle, 'lua_setfenv');
  lua_setfield := GetProcAddress(aDLLHandle, 'lua_setfield');
  lua_sethook := GetProcAddress(aDLLHandle, 'lua_sethook');
  lua_setlocal := GetProcAddress(aDLLHandle, 'lua_setlocal');
  lua_setmetatable := GetProcAddress(aDLLHandle, 'lua_setmetatable');
  lua_settable := GetProcAddress(aDLLHandle, 'lua_settable');
  lua_settop := GetProcAddress(aDLLHandle, 'lua_settop');
  lua_setupvalue := GetProcAddress(aDLLHandle, 'lua_setupvalue');
  lua_status := GetProcAddress(aDLLHandle, 'lua_status');
  lua_toboolean := GetProcAddress(aDLLHandle, 'lua_toboolean');
  lua_tocfunction := GetProcAddress(aDLLHandle, 'lua_tocfunction');
  lua_tointeger := GetProcAddress(aDLLHandle, 'lua_tointeger');
  lua_tointegerx := GetProcAddress(aDLLHandle, 'lua_tointegerx');
  lua_tolstring := GetProcAddress(aDLLHandle, 'lua_tolstring');
  lua_tonumber := GetProcAddress(aDLLHandle, 'lua_tonumber');
  lua_tonumberx := GetProcAddress(aDLLHandle, 'lua_tonumberx');
  lua_topointer := GetProcAddress(aDLLHandle, 'lua_topointer');
  lua_tothread := GetProcAddress(aDLLHandle, 'lua_tothread');
  lua_touserdata := GetProcAddress(aDLLHandle, 'lua_touserdata');
  lua_type := GetProcAddress(aDLLHandle, 'lua_type');
  lua_typename := GetProcAddress(aDLLHandle, 'lua_typename');
  lua_upvalueid := GetProcAddress(aDLLHandle, 'lua_upvalueid');
  lua_upvaluejoin := GetProcAddress(aDLLHandle, 'lua_upvaluejoin');
  lua_version := GetProcAddress(aDLLHandle, 'lua_version');
  lua_xmove := GetProcAddress(aDLLHandle, 'lua_xmove');
  lua_yield := GetProcAddress(aDLLHandle, 'lua_yield');
  luaJIT_profile_dumpstack := GetProcAddress(aDLLHandle, 'luaJIT_profile_dumpstack');
  luaJIT_profile_start := GetProcAddress(aDLLHandle, 'luaJIT_profile_start');
  luaJIT_profile_stop := GetProcAddress(aDLLHandle, 'luaJIT_profile_stop');
  luaJIT_setmode := GetProcAddress(aDLLHandle, 'luaJIT_setmode');
  luaJIT_version_2_1_1697887905 := GetProcAddress(aDLLHandle, 'luaJIT_version_2_1_1697887905');
  luaL_addlstring := GetProcAddress(aDLLHandle, 'luaL_addlstring');
  luaL_addstring := GetProcAddress(aDLLHandle, 'luaL_addstring');
  luaL_addvalue := GetProcAddress(aDLLHandle, 'luaL_addvalue');
  luaL_argerror := GetProcAddress(aDLLHandle, 'luaL_argerror');
  luaL_buffinit := GetProcAddress(aDLLHandle, 'luaL_buffinit');
  luaL_callmeta := GetProcAddress(aDLLHandle, 'luaL_callmeta');
  luaL_checkany := GetProcAddress(aDLLHandle, 'luaL_checkany');
  luaL_checkinteger := GetProcAddress(aDLLHandle, 'luaL_checkinteger');
  luaL_checklstring := GetProcAddress(aDLLHandle, 'luaL_checklstring');
  luaL_checknumber := GetProcAddress(aDLLHandle, 'luaL_checknumber');
  luaL_checkoption := GetProcAddress(aDLLHandle, 'luaL_checkoption');
  luaL_checkstack := GetProcAddress(aDLLHandle, 'luaL_checkstack');
  luaL_checktype := GetProcAddress(aDLLHandle, 'luaL_checktype');
  luaL_checkudata := GetProcAddress(aDLLHandle, 'luaL_checkudata');
  luaL_error := GetProcAddress(aDLLHandle, 'luaL_error');
  luaL_execresult := GetProcAddress(aDLLHandle, 'luaL_execresult');
  luaL_fileresult := GetProcAddress(aDLLHandle, 'luaL_fileresult');
  luaL_findtable := GetProcAddress(aDLLHandle, 'luaL_findtable');
  luaL_getmetafield := GetProcAddress(aDLLHandle, 'luaL_getmetafield');
  luaL_gsub := GetProcAddress(aDLLHandle, 'luaL_gsub');
  luaL_loadbuffer := GetProcAddress(aDLLHandle, 'luaL_loadbuffer');
  luaL_loadbufferx := GetProcAddress(aDLLHandle, 'luaL_loadbufferx');
  luaL_loadfile := GetProcAddress(aDLLHandle, 'luaL_loadfile');
  luaL_loadfilex := GetProcAddress(aDLLHandle, 'luaL_loadfilex');
  luaL_loadstring := GetProcAddress(aDLLHandle, 'luaL_loadstring');
  luaL_newmetatable := GetProcAddress(aDLLHandle, 'luaL_newmetatable');
  luaL_newstate := GetProcAddress(aDLLHandle, 'luaL_newstate');
  luaL_openlib := GetProcAddress(aDLLHandle, 'luaL_openlib');
  luaL_openlibs := GetProcAddress(aDLLHandle, 'luaL_openlibs');
  luaL_optinteger := GetProcAddress(aDLLHandle, 'luaL_optinteger');
  luaL_optlstring := GetProcAddress(aDLLHandle, 'luaL_optlstring');
  luaL_optnumber := GetProcAddress(aDLLHandle, 'luaL_optnumber');
  luaL_prepbuffer := GetProcAddress(aDLLHandle, 'luaL_prepbuffer');
  luaL_pushmodule := GetProcAddress(aDLLHandle, 'luaL_pushmodule');
  luaL_pushresult := GetProcAddress(aDLLHandle, 'luaL_pushresult');
  luaL_ref := GetProcAddress(aDLLHandle, 'luaL_ref');
  luaL_register := GetProcAddress(aDLLHandle, 'luaL_register');
  luaL_setfuncs := GetProcAddress(aDLLHandle, 'luaL_setfuncs');
  luaL_setmetatable := GetProcAddress(aDLLHandle, 'luaL_setmetatable');
  luaL_testudata := GetProcAddress(aDLLHandle, 'luaL_testudata');
  luaL_traceback := GetProcAddress(aDLLHandle, 'luaL_traceback');
  luaL_typerror := GetProcAddress(aDLLHandle, 'luaL_typerror');
  luaL_unref := GetProcAddress(aDLLHandle, 'luaL_unref');
  luaL_where := GetProcAddress(aDLLHandle, 'luaL_where');
  luaopen_base := GetProcAddress(aDLLHandle, 'luaopen_base');
  luaopen_bit := GetProcAddress(aDLLHandle, 'luaopen_bit');
  luaopen_debug := GetProcAddress(aDLLHandle, 'luaopen_debug');
  luaopen_ffi := GetProcAddress(aDLLHandle, 'luaopen_ffi');
  luaopen_io := GetProcAddress(aDLLHandle, 'luaopen_io');
  luaopen_jit := GetProcAddress(aDLLHandle, 'luaopen_jit');
  luaopen_math := GetProcAddress(aDLLHandle, 'luaopen_math');
  luaopen_os := GetProcAddress(aDLLHandle, 'luaopen_os');
  luaopen_package := GetProcAddress(aDLLHandle, 'luaopen_package');
  luaopen_string := GetProcAddress(aDLLHandle, 'luaopen_string');
  luaopen_string_buffer := GetProcAddress(aDLLHandle, 'luaopen_string_buffer');
  luaopen_table := GetProcAddress(aDLLHandle, 'luaopen_table');
  nk__begin := GetProcAddress(aDLLHandle, 'nk__begin');
  nk__draw_begin := GetProcAddress(aDLLHandle, 'nk__draw_begin');
  nk__draw_end := GetProcAddress(aDLLHandle, 'nk__draw_end');
  nk__draw_list_begin := GetProcAddress(aDLLHandle, 'nk__draw_list_begin');
  nk__draw_list_end := GetProcAddress(aDLLHandle, 'nk__draw_list_end');
  nk__draw_list_next := GetProcAddress(aDLLHandle, 'nk__draw_list_next');
  nk__draw_next := GetProcAddress(aDLLHandle, 'nk__draw_next');
  nk__next := GetProcAddress(aDLLHandle, 'nk__next');
  nk_begin := GetProcAddress(aDLLHandle, 'nk_begin');
  nk_begin_titled := GetProcAddress(aDLLHandle, 'nk_begin_titled');
  nk_buffer_clear := GetProcAddress(aDLLHandle, 'nk_buffer_clear');
  nk_buffer_free := GetProcAddress(aDLLHandle, 'nk_buffer_free');
  nk_buffer_info := GetProcAddress(aDLLHandle, 'nk_buffer_info');
  nk_buffer_init := GetProcAddress(aDLLHandle, 'nk_buffer_init');
  nk_buffer_init_default := GetProcAddress(aDLLHandle, 'nk_buffer_init_default');
  nk_buffer_init_fixed := GetProcAddress(aDLLHandle, 'nk_buffer_init_fixed');
  nk_buffer_mark := GetProcAddress(aDLLHandle, 'nk_buffer_mark');
  nk_buffer_memory := GetProcAddress(aDLLHandle, 'nk_buffer_memory');
  nk_buffer_memory_const := GetProcAddress(aDLLHandle, 'nk_buffer_memory_const');
  nk_buffer_push := GetProcAddress(aDLLHandle, 'nk_buffer_push');
  nk_buffer_reset := GetProcAddress(aDLLHandle, 'nk_buffer_reset');
  nk_buffer_total := GetProcAddress(aDLLHandle, 'nk_buffer_total');
  nk_button_color := GetProcAddress(aDLLHandle, 'nk_button_color');
  nk_button_image := GetProcAddress(aDLLHandle, 'nk_button_image');
  nk_button_image_label := GetProcAddress(aDLLHandle, 'nk_button_image_label');
  nk_button_image_label_styled := GetProcAddress(aDLLHandle, 'nk_button_image_label_styled');
  nk_button_image_styled := GetProcAddress(aDLLHandle, 'nk_button_image_styled');
  nk_button_image_text := GetProcAddress(aDLLHandle, 'nk_button_image_text');
  nk_button_image_text_styled := GetProcAddress(aDLLHandle, 'nk_button_image_text_styled');
  nk_button_label := GetProcAddress(aDLLHandle, 'nk_button_label');
  nk_button_label_styled := GetProcAddress(aDLLHandle, 'nk_button_label_styled');
  nk_button_pop_behavior := GetProcAddress(aDLLHandle, 'nk_button_pop_behavior');
  nk_button_push_behavior := GetProcAddress(aDLLHandle, 'nk_button_push_behavior');
  nk_button_set_behavior := GetProcAddress(aDLLHandle, 'nk_button_set_behavior');
  nk_button_symbol := GetProcAddress(aDLLHandle, 'nk_button_symbol');
  nk_button_symbol_label := GetProcAddress(aDLLHandle, 'nk_button_symbol_label');
  nk_button_symbol_label_styled := GetProcAddress(aDLLHandle, 'nk_button_symbol_label_styled');
  nk_button_symbol_styled := GetProcAddress(aDLLHandle, 'nk_button_symbol_styled');
  nk_button_symbol_text := GetProcAddress(aDLLHandle, 'nk_button_symbol_text');
  nk_button_symbol_text_styled := GetProcAddress(aDLLHandle, 'nk_button_symbol_text_styled');
  nk_button_text := GetProcAddress(aDLLHandle, 'nk_button_text');
  nk_button_text_styled := GetProcAddress(aDLLHandle, 'nk_button_text_styled');
  nk_chart_add_slot := GetProcAddress(aDLLHandle, 'nk_chart_add_slot');
  nk_chart_add_slot_colored := GetProcAddress(aDLLHandle, 'nk_chart_add_slot_colored');
  nk_chart_begin := GetProcAddress(aDLLHandle, 'nk_chart_begin');
  nk_chart_begin_colored := GetProcAddress(aDLLHandle, 'nk_chart_begin_colored');
  nk_chart_end := GetProcAddress(aDLLHandle, 'nk_chart_end');
  nk_chart_push := GetProcAddress(aDLLHandle, 'nk_chart_push');
  nk_chart_push_slot := GetProcAddress(aDLLHandle, 'nk_chart_push_slot');
  nk_check_flags_label := GetProcAddress(aDLLHandle, 'nk_check_flags_label');
  nk_check_flags_text := GetProcAddress(aDLLHandle, 'nk_check_flags_text');
  nk_check_label := GetProcAddress(aDLLHandle, 'nk_check_label');
  nk_check_text := GetProcAddress(aDLLHandle, 'nk_check_text');
  nk_checkbox_flags_label := GetProcAddress(aDLLHandle, 'nk_checkbox_flags_label');
  nk_checkbox_flags_text := GetProcAddress(aDLLHandle, 'nk_checkbox_flags_text');
  nk_checkbox_label := GetProcAddress(aDLLHandle, 'nk_checkbox_label');
  nk_checkbox_text := GetProcAddress(aDLLHandle, 'nk_checkbox_text');
  nk_clear := GetProcAddress(aDLLHandle, 'nk_clear');
  nk_color_cf := GetProcAddress(aDLLHandle, 'nk_color_cf');
  nk_color_d := GetProcAddress(aDLLHandle, 'nk_color_d');
  nk_color_dv := GetProcAddress(aDLLHandle, 'nk_color_dv');
  nk_color_f := GetProcAddress(aDLLHandle, 'nk_color_f');
  nk_color_fv := GetProcAddress(aDLLHandle, 'nk_color_fv');
  nk_color_hex_rgb := GetProcAddress(aDLLHandle, 'nk_color_hex_rgb');
  nk_color_hex_rgba := GetProcAddress(aDLLHandle, 'nk_color_hex_rgba');
  nk_color_hsv_b := GetProcAddress(aDLLHandle, 'nk_color_hsv_b');
  nk_color_hsv_bv := GetProcAddress(aDLLHandle, 'nk_color_hsv_bv');
  nk_color_hsv_f := GetProcAddress(aDLLHandle, 'nk_color_hsv_f');
  nk_color_hsv_fv := GetProcAddress(aDLLHandle, 'nk_color_hsv_fv');
  nk_color_hsv_i := GetProcAddress(aDLLHandle, 'nk_color_hsv_i');
  nk_color_hsv_iv := GetProcAddress(aDLLHandle, 'nk_color_hsv_iv');
  nk_color_hsva_b := GetProcAddress(aDLLHandle, 'nk_color_hsva_b');
  nk_color_hsva_bv := GetProcAddress(aDLLHandle, 'nk_color_hsva_bv');
  nk_color_hsva_f := GetProcAddress(aDLLHandle, 'nk_color_hsva_f');
  nk_color_hsva_fv := GetProcAddress(aDLLHandle, 'nk_color_hsva_fv');
  nk_color_hsva_i := GetProcAddress(aDLLHandle, 'nk_color_hsva_i');
  nk_color_hsva_iv := GetProcAddress(aDLLHandle, 'nk_color_hsva_iv');
  nk_color_pick := GetProcAddress(aDLLHandle, 'nk_color_pick');
  nk_color_picker := GetProcAddress(aDLLHandle, 'nk_color_picker');
  nk_color_u32 := GetProcAddress(aDLLHandle, 'nk_color_u32');
  nk_colorf_hsva_f := GetProcAddress(aDLLHandle, 'nk_colorf_hsva_f');
  nk_colorf_hsva_fv := GetProcAddress(aDLLHandle, 'nk_colorf_hsva_fv');
  nk_combo := GetProcAddress(aDLLHandle, 'nk_combo');
  nk_combo_begin_color := GetProcAddress(aDLLHandle, 'nk_combo_begin_color');
  nk_combo_begin_image := GetProcAddress(aDLLHandle, 'nk_combo_begin_image');
  nk_combo_begin_image_label := GetProcAddress(aDLLHandle, 'nk_combo_begin_image_label');
  nk_combo_begin_image_text := GetProcAddress(aDLLHandle, 'nk_combo_begin_image_text');
  nk_combo_begin_label := GetProcAddress(aDLLHandle, 'nk_combo_begin_label');
  nk_combo_begin_symbol := GetProcAddress(aDLLHandle, 'nk_combo_begin_symbol');
  nk_combo_begin_symbol_label := GetProcAddress(aDLLHandle, 'nk_combo_begin_symbol_label');
  nk_combo_begin_symbol_text := GetProcAddress(aDLLHandle, 'nk_combo_begin_symbol_text');
  nk_combo_begin_text := GetProcAddress(aDLLHandle, 'nk_combo_begin_text');
  nk_combo_callback := GetProcAddress(aDLLHandle, 'nk_combo_callback');
  nk_combo_close := GetProcAddress(aDLLHandle, 'nk_combo_close');
  nk_combo_end := GetProcAddress(aDLLHandle, 'nk_combo_end');
  nk_combo_item_image_label := GetProcAddress(aDLLHandle, 'nk_combo_item_image_label');
  nk_combo_item_image_text := GetProcAddress(aDLLHandle, 'nk_combo_item_image_text');
  nk_combo_item_label := GetProcAddress(aDLLHandle, 'nk_combo_item_label');
  nk_combo_item_symbol_label := GetProcAddress(aDLLHandle, 'nk_combo_item_symbol_label');
  nk_combo_item_symbol_text := GetProcAddress(aDLLHandle, 'nk_combo_item_symbol_text');
  nk_combo_item_text := GetProcAddress(aDLLHandle, 'nk_combo_item_text');
  nk_combo_separator := GetProcAddress(aDLLHandle, 'nk_combo_separator');
  nk_combo_string := GetProcAddress(aDLLHandle, 'nk_combo_string');
  nk_combobox := GetProcAddress(aDLLHandle, 'nk_combobox');
  nk_combobox_callback := GetProcAddress(aDLLHandle, 'nk_combobox_callback');
  nk_combobox_separator := GetProcAddress(aDLLHandle, 'nk_combobox_separator');
  nk_combobox_string := GetProcAddress(aDLLHandle, 'nk_combobox_string');
  nk_contextual_begin := GetProcAddress(aDLLHandle, 'nk_contextual_begin');
  nk_contextual_close := GetProcAddress(aDLLHandle, 'nk_contextual_close');
  nk_contextual_end := GetProcAddress(aDLLHandle, 'nk_contextual_end');
  nk_contextual_item_image_label := GetProcAddress(aDLLHandle, 'nk_contextual_item_image_label');
  nk_contextual_item_image_text := GetProcAddress(aDLLHandle, 'nk_contextual_item_image_text');
  nk_contextual_item_label := GetProcAddress(aDLLHandle, 'nk_contextual_item_label');
  nk_contextual_item_symbol_label := GetProcAddress(aDLLHandle, 'nk_contextual_item_symbol_label');
  nk_contextual_item_symbol_text := GetProcAddress(aDLLHandle, 'nk_contextual_item_symbol_text');
  nk_contextual_item_text := GetProcAddress(aDLLHandle, 'nk_contextual_item_text');
  nk_convert := GetProcAddress(aDLLHandle, 'nk_convert');
  nk_draw_image := GetProcAddress(aDLLHandle, 'nk_draw_image');
  nk_draw_list_add_image := GetProcAddress(aDLLHandle, 'nk_draw_list_add_image');
  nk_draw_list_add_text := GetProcAddress(aDLLHandle, 'nk_draw_list_add_text');
  nk_draw_list_fill_circle := GetProcAddress(aDLLHandle, 'nk_draw_list_fill_circle');
  nk_draw_list_fill_poly_convex := GetProcAddress(aDLLHandle, 'nk_draw_list_fill_poly_convex');
  nk_draw_list_fill_rect := GetProcAddress(aDLLHandle, 'nk_draw_list_fill_rect');
  nk_draw_list_fill_rect_multi_color := GetProcAddress(aDLLHandle, 'nk_draw_list_fill_rect_multi_color');
  nk_draw_list_fill_triangle := GetProcAddress(aDLLHandle, 'nk_draw_list_fill_triangle');
  nk_draw_list_init := GetProcAddress(aDLLHandle, 'nk_draw_list_init');
  nk_draw_list_path_arc_to := GetProcAddress(aDLLHandle, 'nk_draw_list_path_arc_to');
  nk_draw_list_path_arc_to_fast := GetProcAddress(aDLLHandle, 'nk_draw_list_path_arc_to_fast');
  nk_draw_list_path_clear := GetProcAddress(aDLLHandle, 'nk_draw_list_path_clear');
  nk_draw_list_path_curve_to := GetProcAddress(aDLLHandle, 'nk_draw_list_path_curve_to');
  nk_draw_list_path_fill := GetProcAddress(aDLLHandle, 'nk_draw_list_path_fill');
  nk_draw_list_path_line_to := GetProcAddress(aDLLHandle, 'nk_draw_list_path_line_to');
  nk_draw_list_path_rect_to := GetProcAddress(aDLLHandle, 'nk_draw_list_path_rect_to');
  nk_draw_list_path_stroke := GetProcAddress(aDLLHandle, 'nk_draw_list_path_stroke');
  nk_draw_list_setup := GetProcAddress(aDLLHandle, 'nk_draw_list_setup');
  nk_draw_list_stroke_circle := GetProcAddress(aDLLHandle, 'nk_draw_list_stroke_circle');
  nk_draw_list_stroke_curve := GetProcAddress(aDLLHandle, 'nk_draw_list_stroke_curve');
  nk_draw_list_stroke_line := GetProcAddress(aDLLHandle, 'nk_draw_list_stroke_line');
  nk_draw_list_stroke_poly_line := GetProcAddress(aDLLHandle, 'nk_draw_list_stroke_poly_line');
  nk_draw_list_stroke_rect := GetProcAddress(aDLLHandle, 'nk_draw_list_stroke_rect');
  nk_draw_list_stroke_triangle := GetProcAddress(aDLLHandle, 'nk_draw_list_stroke_triangle');
  nk_draw_nine_slice := GetProcAddress(aDLLHandle, 'nk_draw_nine_slice');
  nk_draw_text := GetProcAddress(aDLLHandle, 'nk_draw_text');
  nk_edit_buffer := GetProcAddress(aDLLHandle, 'nk_edit_buffer');
  nk_edit_focus := GetProcAddress(aDLLHandle, 'nk_edit_focus');
  nk_edit_string := GetProcAddress(aDLLHandle, 'nk_edit_string');
  nk_edit_string_zero_terminated := GetProcAddress(aDLLHandle, 'nk_edit_string_zero_terminated');
  nk_edit_unfocus := GetProcAddress(aDLLHandle, 'nk_edit_unfocus');
  nk_end := GetProcAddress(aDLLHandle, 'nk_end');
  nk_fill_arc := GetProcAddress(aDLLHandle, 'nk_fill_arc');
  nk_fill_circle := GetProcAddress(aDLLHandle, 'nk_fill_circle');
  nk_fill_polygon := GetProcAddress(aDLLHandle, 'nk_fill_polygon');
  nk_fill_rect := GetProcAddress(aDLLHandle, 'nk_fill_rect');
  nk_fill_rect_multi_color := GetProcAddress(aDLLHandle, 'nk_fill_rect_multi_color');
  nk_fill_triangle := GetProcAddress(aDLLHandle, 'nk_fill_triangle');
  nk_filter_ascii := GetProcAddress(aDLLHandle, 'nk_filter_ascii');
  nk_filter_binary := GetProcAddress(aDLLHandle, 'nk_filter_binary');
  nk_filter_decimal := GetProcAddress(aDLLHandle, 'nk_filter_decimal');
  nk_filter_default := GetProcAddress(aDLLHandle, 'nk_filter_default');
  nk_filter_float := GetProcAddress(aDLLHandle, 'nk_filter_float');
  nk_filter_hex := GetProcAddress(aDLLHandle, 'nk_filter_hex');
  nk_filter_oct := GetProcAddress(aDLLHandle, 'nk_filter_oct');
  nk_font_atlas_add := GetProcAddress(aDLLHandle, 'nk_font_atlas_add');
  nk_font_atlas_add_compressed := GetProcAddress(aDLLHandle, 'nk_font_atlas_add_compressed');
  nk_font_atlas_add_compressed_base85 := GetProcAddress(aDLLHandle, 'nk_font_atlas_add_compressed_base85');
  nk_font_atlas_add_default := GetProcAddress(aDLLHandle, 'nk_font_atlas_add_default');
  nk_font_atlas_add_from_file := GetProcAddress(aDLLHandle, 'nk_font_atlas_add_from_file');
  nk_font_atlas_add_from_memory := GetProcAddress(aDLLHandle, 'nk_font_atlas_add_from_memory');
  nk_font_atlas_bake := GetProcAddress(aDLLHandle, 'nk_font_atlas_bake');
  nk_font_atlas_begin := GetProcAddress(aDLLHandle, 'nk_font_atlas_begin');
  nk_font_atlas_cleanup := GetProcAddress(aDLLHandle, 'nk_font_atlas_cleanup');
  nk_font_atlas_clear := GetProcAddress(aDLLHandle, 'nk_font_atlas_clear');
  nk_font_atlas_end := GetProcAddress(aDLLHandle, 'nk_font_atlas_end');
  nk_font_atlas_init := GetProcAddress(aDLLHandle, 'nk_font_atlas_init');
  nk_font_atlas_init_custom := GetProcAddress(aDLLHandle, 'nk_font_atlas_init_custom');
  nk_font_atlas_init_default := GetProcAddress(aDLLHandle, 'nk_font_atlas_init_default');
  nk_font_chinese_glyph_ranges := GetProcAddress(aDLLHandle, 'nk_font_chinese_glyph_ranges');
  nk_font_config_rtn := GetProcAddress(aDLLHandle, 'nk_font_config');
  nk_font_cyrillic_glyph_ranges := GetProcAddress(aDLLHandle, 'nk_font_cyrillic_glyph_ranges');
  nk_font_default_glyph_ranges := GetProcAddress(aDLLHandle, 'nk_font_default_glyph_ranges');
  nk_font_find_glyph := GetProcAddress(aDLLHandle, 'nk_font_find_glyph');
  nk_font_korean_glyph_ranges := GetProcAddress(aDLLHandle, 'nk_font_korean_glyph_ranges');
  nk_free := GetProcAddress(aDLLHandle, 'nk_free');
  nk_get_null_rect := GetProcAddress(aDLLHandle, 'nk_get_null_rect');
  nk_gflw3_scroll_callback := GetProcAddress(aDLLHandle, 'nk_gflw3_scroll_callback');
  nk_glfw3_char_callback := GetProcAddress(aDLLHandle, 'nk_glfw3_char_callback');
  nk_glfw3_font_stash_begin := GetProcAddress(aDLLHandle, 'nk_glfw3_font_stash_begin');
  nk_glfw3_font_stash_end := GetProcAddress(aDLLHandle, 'nk_glfw3_font_stash_end');
  nk_glfw3_init := GetProcAddress(aDLLHandle, 'nk_glfw3_init');
  nk_glfw3_new_frame := GetProcAddress(aDLLHandle, 'nk_glfw3_new_frame');
  nk_glfw3_render := GetProcAddress(aDLLHandle, 'nk_glfw3_render');
  nk_glfw3_shutdown := GetProcAddress(aDLLHandle, 'nk_glfw3_shutdown');
  nk_group_begin := GetProcAddress(aDLLHandle, 'nk_group_begin');
  nk_group_begin_titled := GetProcAddress(aDLLHandle, 'nk_group_begin_titled');
  nk_group_end := GetProcAddress(aDLLHandle, 'nk_group_end');
  nk_group_get_scroll := GetProcAddress(aDLLHandle, 'nk_group_get_scroll');
  nk_group_scrolled_begin := GetProcAddress(aDLLHandle, 'nk_group_scrolled_begin');
  nk_group_scrolled_end := GetProcAddress(aDLLHandle, 'nk_group_scrolled_end');
  nk_group_scrolled_offset_begin := GetProcAddress(aDLLHandle, 'nk_group_scrolled_offset_begin');
  nk_group_set_scroll := GetProcAddress(aDLLHandle, 'nk_group_set_scroll');
  nk_handle_id := GetProcAddress(aDLLHandle, 'nk_handle_id');
  nk_handle_ptr := GetProcAddress(aDLLHandle, 'nk_handle_ptr');
  nk_hsv := GetProcAddress(aDLLHandle, 'nk_hsv');
  nk_hsv_bv := GetProcAddress(aDLLHandle, 'nk_hsv_bv');
  nk_hsv_f := GetProcAddress(aDLLHandle, 'nk_hsv_f');
  nk_hsv_fv := GetProcAddress(aDLLHandle, 'nk_hsv_fv');
  nk_hsv_iv := GetProcAddress(aDLLHandle, 'nk_hsv_iv');
  nk_hsva := GetProcAddress(aDLLHandle, 'nk_hsva');
  nk_hsva_bv := GetProcAddress(aDLLHandle, 'nk_hsva_bv');
  nk_hsva_colorf := GetProcAddress(aDLLHandle, 'nk_hsva_colorf');
  nk_hsva_colorfv := GetProcAddress(aDLLHandle, 'nk_hsva_colorfv');
  nk_hsva_f := GetProcAddress(aDLLHandle, 'nk_hsva_f');
  nk_hsva_fv := GetProcAddress(aDLLHandle, 'nk_hsva_fv');
  nk_hsva_iv := GetProcAddress(aDLLHandle, 'nk_hsva_iv');
  nk_image_color := GetProcAddress(aDLLHandle, 'nk_image_color');
  nk_image_handle := GetProcAddress(aDLLHandle, 'nk_image_handle');
  nk_image_id := GetProcAddress(aDLLHandle, 'nk_image_id');
  nk_image_is_subimage := GetProcAddress(aDLLHandle, 'nk_image_is_subimage');
  nk_image_ptr := GetProcAddress(aDLLHandle, 'nk_image_ptr');
  nk_image_rtn := GetProcAddress(aDLLHandle, 'nk_image');
  nk_init := GetProcAddress(aDLLHandle, 'nk_init');
  nk_init_custom := GetProcAddress(aDLLHandle, 'nk_init_custom');
  nk_init_default := GetProcAddress(aDLLHandle, 'nk_init_default');
  nk_init_fixed := GetProcAddress(aDLLHandle, 'nk_init_fixed');
  nk_input_any_mouse_click_in_rect := GetProcAddress(aDLLHandle, 'nk_input_any_mouse_click_in_rect');
  nk_input_begin := GetProcAddress(aDLLHandle, 'nk_input_begin');
  nk_input_button := GetProcAddress(aDLLHandle, 'nk_input_button');
  nk_input_char := GetProcAddress(aDLLHandle, 'nk_input_char');
  nk_input_end := GetProcAddress(aDLLHandle, 'nk_input_end');
  nk_input_glyph := GetProcAddress(aDLLHandle, 'nk_input_glyph');
  nk_input_has_mouse_click := GetProcAddress(aDLLHandle, 'nk_input_has_mouse_click');
  nk_input_has_mouse_click_down_in_rect := GetProcAddress(aDLLHandle, 'nk_input_has_mouse_click_down_in_rect');
  nk_input_has_mouse_click_in_button_rect := GetProcAddress(aDLLHandle, 'nk_input_has_mouse_click_in_button_rect');
  nk_input_has_mouse_click_in_rect := GetProcAddress(aDLLHandle, 'nk_input_has_mouse_click_in_rect');
  nk_input_is_key_down := GetProcAddress(aDLLHandle, 'nk_input_is_key_down');
  nk_input_is_key_pressed := GetProcAddress(aDLLHandle, 'nk_input_is_key_pressed');
  nk_input_is_key_released := GetProcAddress(aDLLHandle, 'nk_input_is_key_released');
  nk_input_is_mouse_click_down_in_rect := GetProcAddress(aDLLHandle, 'nk_input_is_mouse_click_down_in_rect');
  nk_input_is_mouse_click_in_rect := GetProcAddress(aDLLHandle, 'nk_input_is_mouse_click_in_rect');
  nk_input_is_mouse_down := GetProcAddress(aDLLHandle, 'nk_input_is_mouse_down');
  nk_input_is_mouse_hovering_rect := GetProcAddress(aDLLHandle, 'nk_input_is_mouse_hovering_rect');
  nk_input_is_mouse_pressed := GetProcAddress(aDLLHandle, 'nk_input_is_mouse_pressed');
  nk_input_is_mouse_prev_hovering_rect := GetProcAddress(aDLLHandle, 'nk_input_is_mouse_prev_hovering_rect');
  nk_input_is_mouse_released := GetProcAddress(aDLLHandle, 'nk_input_is_mouse_released');
  nk_input_key := GetProcAddress(aDLLHandle, 'nk_input_key');
  nk_input_motion := GetProcAddress(aDLLHandle, 'nk_input_motion');
  nk_input_mouse_clicked := GetProcAddress(aDLLHandle, 'nk_input_mouse_clicked');
  nk_input_scroll := GetProcAddress(aDLLHandle, 'nk_input_scroll');
  nk_input_unicode := GetProcAddress(aDLLHandle, 'nk_input_unicode');
  nk_item_is_any_active := GetProcAddress(aDLLHandle, 'nk_item_is_any_active');
  nk_label := GetProcAddress(aDLLHandle, 'nk_label');
  nk_label_colored := GetProcAddress(aDLLHandle, 'nk_label_colored');
  nk_label_colored_wrap := GetProcAddress(aDLLHandle, 'nk_label_colored_wrap');
  nk_label_wrap := GetProcAddress(aDLLHandle, 'nk_label_wrap');
  nk_labelf := GetProcAddress(aDLLHandle, 'nk_labelf');
  nk_labelf_colored := GetProcAddress(aDLLHandle, 'nk_labelf_colored');
  nk_labelf_colored_wrap := GetProcAddress(aDLLHandle, 'nk_labelf_colored_wrap');
  nk_labelf_wrap := GetProcAddress(aDLLHandle, 'nk_labelf_wrap');
  nk_labelfv := GetProcAddress(aDLLHandle, 'nk_labelfv');
  nk_labelfv_colored := GetProcAddress(aDLLHandle, 'nk_labelfv_colored');
  nk_labelfv_colored_wrap := GetProcAddress(aDLLHandle, 'nk_labelfv_colored_wrap');
  nk_labelfv_wrap := GetProcAddress(aDLLHandle, 'nk_labelfv_wrap');
  nk_layout_ratio_from_pixel := GetProcAddress(aDLLHandle, 'nk_layout_ratio_from_pixel');
  nk_layout_reset_min_row_height := GetProcAddress(aDLLHandle, 'nk_layout_reset_min_row_height');
  nk_layout_row := GetProcAddress(aDLLHandle, 'nk_layout_row');
  nk_layout_row_begin := GetProcAddress(aDLLHandle, 'nk_layout_row_begin');
  nk_layout_row_dynamic := GetProcAddress(aDLLHandle, 'nk_layout_row_dynamic');
  nk_layout_row_end := GetProcAddress(aDLLHandle, 'nk_layout_row_end');
  nk_layout_row_push := GetProcAddress(aDLLHandle, 'nk_layout_row_push');
  nk_layout_row_static := GetProcAddress(aDLLHandle, 'nk_layout_row_static');
  nk_layout_row_template_begin := GetProcAddress(aDLLHandle, 'nk_layout_row_template_begin');
  nk_layout_row_template_end := GetProcAddress(aDLLHandle, 'nk_layout_row_template_end');
  nk_layout_row_template_push_dynamic := GetProcAddress(aDLLHandle, 'nk_layout_row_template_push_dynamic');
  nk_layout_row_template_push_static := GetProcAddress(aDLLHandle, 'nk_layout_row_template_push_static');
  nk_layout_row_template_push_variable := GetProcAddress(aDLLHandle, 'nk_layout_row_template_push_variable');
  nk_layout_set_min_row_height := GetProcAddress(aDLLHandle, 'nk_layout_set_min_row_height');
  nk_layout_space_begin := GetProcAddress(aDLLHandle, 'nk_layout_space_begin');
  nk_layout_space_bounds := GetProcAddress(aDLLHandle, 'nk_layout_space_bounds');
  nk_layout_space_end := GetProcAddress(aDLLHandle, 'nk_layout_space_end');
  nk_layout_space_push := GetProcAddress(aDLLHandle, 'nk_layout_space_push');
  nk_layout_space_rect_to_local := GetProcAddress(aDLLHandle, 'nk_layout_space_rect_to_local');
  nk_layout_space_rect_to_screen := GetProcAddress(aDLLHandle, 'nk_layout_space_rect_to_screen');
  nk_layout_space_to_local := GetProcAddress(aDLLHandle, 'nk_layout_space_to_local');
  nk_layout_space_to_screen := GetProcAddress(aDLLHandle, 'nk_layout_space_to_screen');
  nk_layout_widget_bounds := GetProcAddress(aDLLHandle, 'nk_layout_widget_bounds');
  nk_list_view_begin := GetProcAddress(aDLLHandle, 'nk_list_view_begin');
  nk_list_view_end := GetProcAddress(aDLLHandle, 'nk_list_view_end');
  nk_menu_begin_image := GetProcAddress(aDLLHandle, 'nk_menu_begin_image');
  nk_menu_begin_image_label := GetProcAddress(aDLLHandle, 'nk_menu_begin_image_label');
  nk_menu_begin_image_text := GetProcAddress(aDLLHandle, 'nk_menu_begin_image_text');
  nk_menu_begin_label := GetProcAddress(aDLLHandle, 'nk_menu_begin_label');
  nk_menu_begin_symbol := GetProcAddress(aDLLHandle, 'nk_menu_begin_symbol');
  nk_menu_begin_symbol_label := GetProcAddress(aDLLHandle, 'nk_menu_begin_symbol_label');
  nk_menu_begin_symbol_text := GetProcAddress(aDLLHandle, 'nk_menu_begin_symbol_text');
  nk_menu_begin_text := GetProcAddress(aDLLHandle, 'nk_menu_begin_text');
  nk_menu_close := GetProcAddress(aDLLHandle, 'nk_menu_close');
  nk_menu_end := GetProcAddress(aDLLHandle, 'nk_menu_end');
  nk_menu_item_image_label := GetProcAddress(aDLLHandle, 'nk_menu_item_image_label');
  nk_menu_item_image_text := GetProcAddress(aDLLHandle, 'nk_menu_item_image_text');
  nk_menu_item_label := GetProcAddress(aDLLHandle, 'nk_menu_item_label');
  nk_menu_item_symbol_label := GetProcAddress(aDLLHandle, 'nk_menu_item_symbol_label');
  nk_menu_item_symbol_text := GetProcAddress(aDLLHandle, 'nk_menu_item_symbol_text');
  nk_menu_item_text := GetProcAddress(aDLLHandle, 'nk_menu_item_text');
  nk_menubar_begin := GetProcAddress(aDLLHandle, 'nk_menubar_begin');
  nk_menubar_end := GetProcAddress(aDLLHandle, 'nk_menubar_end');
  nk_murmur_hash := GetProcAddress(aDLLHandle, 'nk_murmur_hash');
  nk_nine_slice_handle := GetProcAddress(aDLLHandle, 'nk_nine_slice_handle');
  nk_nine_slice_id := GetProcAddress(aDLLHandle, 'nk_nine_slice_id');
  nk_nine_slice_is_sub9slice := GetProcAddress(aDLLHandle, 'nk_nine_slice_is_sub9slice');
  nk_nine_slice_ptr := GetProcAddress(aDLLHandle, 'nk_nine_slice_ptr');
  nk_option_label := GetProcAddress(aDLLHandle, 'nk_option_label');
  nk_option_text := GetProcAddress(aDLLHandle, 'nk_option_text');
  nk_plot := GetProcAddress(aDLLHandle, 'nk_plot');
  nk_plot_function := GetProcAddress(aDLLHandle, 'nk_plot_function');
  nk_popup_begin := GetProcAddress(aDLLHandle, 'nk_popup_begin');
  nk_popup_close := GetProcAddress(aDLLHandle, 'nk_popup_close');
  nk_popup_end := GetProcAddress(aDLLHandle, 'nk_popup_end');
  nk_popup_get_scroll := GetProcAddress(aDLLHandle, 'nk_popup_get_scroll');
  nk_popup_set_scroll := GetProcAddress(aDLLHandle, 'nk_popup_set_scroll');
  nk_prog := GetProcAddress(aDLLHandle, 'nk_prog');
  nk_progress := GetProcAddress(aDLLHandle, 'nk_progress');
  nk_property_double := GetProcAddress(aDLLHandle, 'nk_property_double');
  nk_property_float := GetProcAddress(aDLLHandle, 'nk_property_float');
  nk_property_int := GetProcAddress(aDLLHandle, 'nk_property_int');
  nk_propertyd := GetProcAddress(aDLLHandle, 'nk_propertyd');
  nk_propertyf := GetProcAddress(aDLLHandle, 'nk_propertyf');
  nk_propertyi := GetProcAddress(aDLLHandle, 'nk_propertyi');
  nk_push_custom := GetProcAddress(aDLLHandle, 'nk_push_custom');
  nk_push_scissor := GetProcAddress(aDLLHandle, 'nk_push_scissor');
  nk_radio_label := GetProcAddress(aDLLHandle, 'nk_radio_label');
  nk_radio_text := GetProcAddress(aDLLHandle, 'nk_radio_text');
  nk_rect_pos := GetProcAddress(aDLLHandle, 'nk_rect_pos');
  nk_rect_rtn := GetProcAddress(aDLLHandle, 'nk_rect');
  nk_rect_size := GetProcAddress(aDLLHandle, 'nk_rect_size');
  nk_recta := GetProcAddress(aDLLHandle, 'nk_recta');
  nk_recti_rtn := GetProcAddress(aDLLHandle, 'nk_recti');
  nk_rectiv := GetProcAddress(aDLLHandle, 'nk_rectiv');
  nk_rectv := GetProcAddress(aDLLHandle, 'nk_rectv');
  nk_rgb_bv := GetProcAddress(aDLLHandle, 'nk_rgb_bv');
  nk_rgb_cf := GetProcAddress(aDLLHandle, 'nk_rgb_cf');
  nk_rgb_f := GetProcAddress(aDLLHandle, 'nk_rgb_f');
  nk_rgb_fv := GetProcAddress(aDLLHandle, 'nk_rgb_fv');
  nk_rgb_hex := GetProcAddress(aDLLHandle, 'nk_rgb_hex');
  nk_rgb_iv := GetProcAddress(aDLLHandle, 'nk_rgb_iv');
  nk_rgb_rtn := GetProcAddress(aDLLHandle, 'nk_rgb');
  nk_rgba_bv := GetProcAddress(aDLLHandle, 'nk_rgba_bv');
  nk_rgba_cf := GetProcAddress(aDLLHandle, 'nk_rgba_cf');
  nk_rgba_f := GetProcAddress(aDLLHandle, 'nk_rgba_f');
  nk_rgba_fv := GetProcAddress(aDLLHandle, 'nk_rgba_fv');
  nk_rgba_hex := GetProcAddress(aDLLHandle, 'nk_rgba_hex');
  nk_rgba_iv := GetProcAddress(aDLLHandle, 'nk_rgba_iv');
  nk_rgba_rtn := GetProcAddress(aDLLHandle, 'nk_rgba');
  nk_rgba_u32 := GetProcAddress(aDLLHandle, 'nk_rgba_u32');
  nk_select_image_label := GetProcAddress(aDLLHandle, 'nk_select_image_label');
  nk_select_image_text := GetProcAddress(aDLLHandle, 'nk_select_image_text');
  nk_select_label := GetProcAddress(aDLLHandle, 'nk_select_label');
  nk_select_symbol_label := GetProcAddress(aDLLHandle, 'nk_select_symbol_label');
  nk_select_symbol_text := GetProcAddress(aDLLHandle, 'nk_select_symbol_text');
  nk_select_text := GetProcAddress(aDLLHandle, 'nk_select_text');
  nk_selectable_image_label := GetProcAddress(aDLLHandle, 'nk_selectable_image_label');
  nk_selectable_image_text := GetProcAddress(aDLLHandle, 'nk_selectable_image_text');
  nk_selectable_label := GetProcAddress(aDLLHandle, 'nk_selectable_label');
  nk_selectable_symbol_label := GetProcAddress(aDLLHandle, 'nk_selectable_symbol_label');
  nk_selectable_symbol_text := GetProcAddress(aDLLHandle, 'nk_selectable_symbol_text');
  nk_selectable_text := GetProcAddress(aDLLHandle, 'nk_selectable_text');
  nk_slide_float := GetProcAddress(aDLLHandle, 'nk_slide_float');
  nk_slide_int := GetProcAddress(aDLLHandle, 'nk_slide_int');
  nk_slider_float := GetProcAddress(aDLLHandle, 'nk_slider_float');
  nk_slider_int := GetProcAddress(aDLLHandle, 'nk_slider_int');
  nk_spacer := GetProcAddress(aDLLHandle, 'nk_spacer');
  nk_spacing := GetProcAddress(aDLLHandle, 'nk_spacing');
  nk_str_append_str_char := GetProcAddress(aDLLHandle, 'nk_str_append_str_char');
  nk_str_append_str_runes := GetProcAddress(aDLLHandle, 'nk_str_append_str_runes');
  nk_str_append_str_utf8 := GetProcAddress(aDLLHandle, 'nk_str_append_str_utf8');
  nk_str_append_text_char := GetProcAddress(aDLLHandle, 'nk_str_append_text_char');
  nk_str_append_text_runes := GetProcAddress(aDLLHandle, 'nk_str_append_text_runes');
  nk_str_append_text_utf8 := GetProcAddress(aDLLHandle, 'nk_str_append_text_utf8');
  nk_str_at_char := GetProcAddress(aDLLHandle, 'nk_str_at_char');
  nk_str_at_char_const := GetProcAddress(aDLLHandle, 'nk_str_at_char_const');
  nk_str_at_const := GetProcAddress(aDLLHandle, 'nk_str_at_const');
  nk_str_at_rune := GetProcAddress(aDLLHandle, 'nk_str_at_rune');
  nk_str_clear := GetProcAddress(aDLLHandle, 'nk_str_clear');
  nk_str_delete_chars := GetProcAddress(aDLLHandle, 'nk_str_delete_chars');
  nk_str_delete_runes := GetProcAddress(aDLLHandle, 'nk_str_delete_runes');
  nk_str_free := GetProcAddress(aDLLHandle, 'nk_str_free');
  nk_str_get := GetProcAddress(aDLLHandle, 'nk_str_get');
  nk_str_get_const := GetProcAddress(aDLLHandle, 'nk_str_get_const');
  nk_str_init := GetProcAddress(aDLLHandle, 'nk_str_init');
  nk_str_init_default := GetProcAddress(aDLLHandle, 'nk_str_init_default');
  nk_str_init_fixed := GetProcAddress(aDLLHandle, 'nk_str_init_fixed');
  nk_str_insert_at_char := GetProcAddress(aDLLHandle, 'nk_str_insert_at_char');
  nk_str_insert_at_rune := GetProcAddress(aDLLHandle, 'nk_str_insert_at_rune');
  nk_str_insert_str_char := GetProcAddress(aDLLHandle, 'nk_str_insert_str_char');
  nk_str_insert_str_runes := GetProcAddress(aDLLHandle, 'nk_str_insert_str_runes');
  nk_str_insert_str_utf8 := GetProcAddress(aDLLHandle, 'nk_str_insert_str_utf8');
  nk_str_insert_text_char := GetProcAddress(aDLLHandle, 'nk_str_insert_text_char');
  nk_str_insert_text_runes := GetProcAddress(aDLLHandle, 'nk_str_insert_text_runes');
  nk_str_insert_text_utf8 := GetProcAddress(aDLLHandle, 'nk_str_insert_text_utf8');
  nk_str_len := GetProcAddress(aDLLHandle, 'nk_str_len');
  nk_str_len_char := GetProcAddress(aDLLHandle, 'nk_str_len_char');
  nk_str_remove_chars := GetProcAddress(aDLLHandle, 'nk_str_remove_chars');
  nk_str_remove_runes := GetProcAddress(aDLLHandle, 'nk_str_remove_runes');
  nk_str_rune_at := GetProcAddress(aDLLHandle, 'nk_str_rune_at');
  nk_strfilter := GetProcAddress(aDLLHandle, 'nk_strfilter');
  nk_stricmp := GetProcAddress(aDLLHandle, 'nk_stricmp');
  nk_stricmpn := GetProcAddress(aDLLHandle, 'nk_stricmpn');
  nk_strlen := GetProcAddress(aDLLHandle, 'nk_strlen');
  nk_strmatch_fuzzy_string := GetProcAddress(aDLLHandle, 'nk_strmatch_fuzzy_string');
  nk_strmatch_fuzzy_text := GetProcAddress(aDLLHandle, 'nk_strmatch_fuzzy_text');
  nk_stroke_arc := GetProcAddress(aDLLHandle, 'nk_stroke_arc');
  nk_stroke_circle := GetProcAddress(aDLLHandle, 'nk_stroke_circle');
  nk_stroke_curve := GetProcAddress(aDLLHandle, 'nk_stroke_curve');
  nk_stroke_line := GetProcAddress(aDLLHandle, 'nk_stroke_line');
  nk_stroke_polygon := GetProcAddress(aDLLHandle, 'nk_stroke_polygon');
  nk_stroke_polyline := GetProcAddress(aDLLHandle, 'nk_stroke_polyline');
  nk_stroke_rect := GetProcAddress(aDLLHandle, 'nk_stroke_rect');
  nk_stroke_triangle := GetProcAddress(aDLLHandle, 'nk_stroke_triangle');
  nk_strtod := GetProcAddress(aDLLHandle, 'nk_strtod');
  nk_strtof := GetProcAddress(aDLLHandle, 'nk_strtof');
  nk_strtoi := GetProcAddress(aDLLHandle, 'nk_strtoi');
  nk_style_default := GetProcAddress(aDLLHandle, 'nk_style_default');
  nk_style_from_table := GetProcAddress(aDLLHandle, 'nk_style_from_table');
  nk_style_get_color_by_name := GetProcAddress(aDLLHandle, 'nk_style_get_color_by_name');
  nk_style_hide_cursor := GetProcAddress(aDLLHandle, 'nk_style_hide_cursor');
  nk_style_item_color_rtn := GetProcAddress(aDLLHandle, 'nk_style_item_color');
  nk_style_item_hide := GetProcAddress(aDLLHandle, 'nk_style_item_hide');
  nk_style_item_image_rtn := GetProcAddress(aDLLHandle, 'nk_style_item_image');
  nk_style_item_nine_slice_rtn := GetProcAddress(aDLLHandle, 'nk_style_item_nine_slice');
  nk_style_load_all_cursors := GetProcAddress(aDLLHandle, 'nk_style_load_all_cursors');
  nk_style_load_cursor := GetProcAddress(aDLLHandle, 'nk_style_load_cursor');
  nk_style_pop_color := GetProcAddress(aDLLHandle, 'nk_style_pop_color');
  nk_style_pop_flags := GetProcAddress(aDLLHandle, 'nk_style_pop_flags');
  nk_style_pop_float := GetProcAddress(aDLLHandle, 'nk_style_pop_float');
  nk_style_pop_font := GetProcAddress(aDLLHandle, 'nk_style_pop_font');
  nk_style_pop_style_item := GetProcAddress(aDLLHandle, 'nk_style_pop_style_item');
  nk_style_pop_vec2 := GetProcAddress(aDLLHandle, 'nk_style_pop_vec2');
  nk_style_push_color := GetProcAddress(aDLLHandle, 'nk_style_push_color');
  nk_style_push_flags := GetProcAddress(aDLLHandle, 'nk_style_push_flags');
  nk_style_push_float := GetProcAddress(aDLLHandle, 'nk_style_push_float');
  nk_style_push_font := GetProcAddress(aDLLHandle, 'nk_style_push_font');
  nk_style_push_style_item := GetProcAddress(aDLLHandle, 'nk_style_push_style_item');
  nk_style_push_vec2 := GetProcAddress(aDLLHandle, 'nk_style_push_vec2');
  nk_style_set_cursor := GetProcAddress(aDLLHandle, 'nk_style_set_cursor');
  nk_style_set_font := GetProcAddress(aDLLHandle, 'nk_style_set_font');
  nk_style_show_cursor := GetProcAddress(aDLLHandle, 'nk_style_show_cursor');
  nk_sub9slice_handle := GetProcAddress(aDLLHandle, 'nk_sub9slice_handle');
  nk_sub9slice_id := GetProcAddress(aDLLHandle, 'nk_sub9slice_id');
  nk_sub9slice_ptr := GetProcAddress(aDLLHandle, 'nk_sub9slice_ptr');
  nk_subimage_handle := GetProcAddress(aDLLHandle, 'nk_subimage_handle');
  nk_subimage_id := GetProcAddress(aDLLHandle, 'nk_subimage_id');
  nk_subimage_ptr := GetProcAddress(aDLLHandle, 'nk_subimage_ptr');
  nk_text := GetProcAddress(aDLLHandle, 'nk_text');
  nk_text_colored := GetProcAddress(aDLLHandle, 'nk_text_colored');
  nk_text_wrap := GetProcAddress(aDLLHandle, 'nk_text_wrap');
  nk_text_wrap_colored := GetProcAddress(aDLLHandle, 'nk_text_wrap_colored');
  nk_textedit_cut := GetProcAddress(aDLLHandle, 'nk_textedit_cut');
  nk_textedit_delete := GetProcAddress(aDLLHandle, 'nk_textedit_delete');
  nk_textedit_delete_selection := GetProcAddress(aDLLHandle, 'nk_textedit_delete_selection');
  nk_textedit_free := GetProcAddress(aDLLHandle, 'nk_textedit_free');
  nk_textedit_init := GetProcAddress(aDLLHandle, 'nk_textedit_init');
  nk_textedit_init_default := GetProcAddress(aDLLHandle, 'nk_textedit_init_default');
  nk_textedit_init_fixed := GetProcAddress(aDLLHandle, 'nk_textedit_init_fixed');
  nk_textedit_paste := GetProcAddress(aDLLHandle, 'nk_textedit_paste');
  nk_textedit_redo := GetProcAddress(aDLLHandle, 'nk_textedit_redo');
  nk_textedit_select_all := GetProcAddress(aDLLHandle, 'nk_textedit_select_all');
  nk_textedit_text := GetProcAddress(aDLLHandle, 'nk_textedit_text');
  nk_textedit_undo := GetProcAddress(aDLLHandle, 'nk_textedit_undo');
  nk_tooltip := GetProcAddress(aDLLHandle, 'nk_tooltip');
  nk_tooltip_begin := GetProcAddress(aDLLHandle, 'nk_tooltip_begin');
  nk_tooltip_end := GetProcAddress(aDLLHandle, 'nk_tooltip_end');
  nk_tooltipf := GetProcAddress(aDLLHandle, 'nk_tooltipf');
  nk_tooltipfv := GetProcAddress(aDLLHandle, 'nk_tooltipfv');
  nk_tree_element_image_push_hashed := GetProcAddress(aDLLHandle, 'nk_tree_element_image_push_hashed');
  nk_tree_element_pop := GetProcAddress(aDLLHandle, 'nk_tree_element_pop');
  nk_tree_element_push_hashed := GetProcAddress(aDLLHandle, 'nk_tree_element_push_hashed');
  nk_tree_image_push_hashed := GetProcAddress(aDLLHandle, 'nk_tree_image_push_hashed');
  nk_tree_pop := GetProcAddress(aDLLHandle, 'nk_tree_pop');
  nk_tree_push_hashed := GetProcAddress(aDLLHandle, 'nk_tree_push_hashed');
  nk_tree_state_image_push := GetProcAddress(aDLLHandle, 'nk_tree_state_image_push');
  nk_tree_state_pop := GetProcAddress(aDLLHandle, 'nk_tree_state_pop');
  nk_tree_state_push := GetProcAddress(aDLLHandle, 'nk_tree_state_push');
  nk_triangle_from_direction := GetProcAddress(aDLLHandle, 'nk_triangle_from_direction');
  nk_utf_at := GetProcAddress(aDLLHandle, 'nk_utf_at');
  nk_utf_decode := GetProcAddress(aDLLHandle, 'nk_utf_decode');
  nk_utf_encode := GetProcAddress(aDLLHandle, 'nk_utf_encode');
  nk_utf_len := GetProcAddress(aDLLHandle, 'nk_utf_len');
  nk_value_bool := GetProcAddress(aDLLHandle, 'nk_value_bool');
  nk_value_color_byte := GetProcAddress(aDLLHandle, 'nk_value_color_byte');
  nk_value_color_float := GetProcAddress(aDLLHandle, 'nk_value_color_float');
  nk_value_color_hex := GetProcAddress(aDLLHandle, 'nk_value_color_hex');
  nk_value_float := GetProcAddress(aDLLHandle, 'nk_value_float');
  nk_value_int := GetProcAddress(aDLLHandle, 'nk_value_int');
  nk_value_uint := GetProcAddress(aDLLHandle, 'nk_value_uint');
  nk_vec2_rtn := GetProcAddress(aDLLHandle, 'nk_vec2');
  nk_vec2i_rtn := GetProcAddress(aDLLHandle, 'nk_vec2i');
  nk_vec2iv := GetProcAddress(aDLLHandle, 'nk_vec2iv');
  nk_vec2v := GetProcAddress(aDLLHandle, 'nk_vec2v');
  nk_widget := GetProcAddress(aDLLHandle, 'nk_widget');
  nk_widget_bounds := GetProcAddress(aDLLHandle, 'nk_widget_bounds');
  nk_widget_fitting := GetProcAddress(aDLLHandle, 'nk_widget_fitting');
  nk_widget_has_mouse_click_down := GetProcAddress(aDLLHandle, 'nk_widget_has_mouse_click_down');
  nk_widget_height := GetProcAddress(aDLLHandle, 'nk_widget_height');
  nk_widget_is_hovered := GetProcAddress(aDLLHandle, 'nk_widget_is_hovered');
  nk_widget_is_mouse_clicked := GetProcAddress(aDLLHandle, 'nk_widget_is_mouse_clicked');
  nk_widget_position := GetProcAddress(aDLLHandle, 'nk_widget_position');
  nk_widget_size := GetProcAddress(aDLLHandle, 'nk_widget_size');
  nk_widget_width := GetProcAddress(aDLLHandle, 'nk_widget_width');
  nk_window_close := GetProcAddress(aDLLHandle, 'nk_window_close');
  nk_window_collapse := GetProcAddress(aDLLHandle, 'nk_window_collapse');
  nk_window_collapse_if := GetProcAddress(aDLLHandle, 'nk_window_collapse_if');
  nk_window_find := GetProcAddress(aDLLHandle, 'nk_window_find');
  nk_window_get_bounds := GetProcAddress(aDLLHandle, 'nk_window_get_bounds');
  nk_window_get_canvas := GetProcAddress(aDLLHandle, 'nk_window_get_canvas');
  nk_window_get_content_region := GetProcAddress(aDLLHandle, 'nk_window_get_content_region');
  nk_window_get_content_region_max := GetProcAddress(aDLLHandle, 'nk_window_get_content_region_max');
  nk_window_get_content_region_min := GetProcAddress(aDLLHandle, 'nk_window_get_content_region_min');
  nk_window_get_content_region_size := GetProcAddress(aDLLHandle, 'nk_window_get_content_region_size');
  nk_window_get_height := GetProcAddress(aDLLHandle, 'nk_window_get_height');
  nk_window_get_panel := GetProcAddress(aDLLHandle, 'nk_window_get_panel');
  nk_window_get_position := GetProcAddress(aDLLHandle, 'nk_window_get_position');
  nk_window_get_scroll := GetProcAddress(aDLLHandle, 'nk_window_get_scroll');
  nk_window_get_size := GetProcAddress(aDLLHandle, 'nk_window_get_size');
  nk_window_get_width := GetProcAddress(aDLLHandle, 'nk_window_get_width');
  nk_window_has_focus := GetProcAddress(aDLLHandle, 'nk_window_has_focus');
  nk_window_is_active := GetProcAddress(aDLLHandle, 'nk_window_is_active');
  nk_window_is_any_hovered := GetProcAddress(aDLLHandle, 'nk_window_is_any_hovered');
  nk_window_is_closed := GetProcAddress(aDLLHandle, 'nk_window_is_closed');
  nk_window_is_collapsed := GetProcAddress(aDLLHandle, 'nk_window_is_collapsed');
  nk_window_is_hidden := GetProcAddress(aDLLHandle, 'nk_window_is_hidden');
  nk_window_is_hovered := GetProcAddress(aDLLHandle, 'nk_window_is_hovered');
  nk_window_set_bounds := GetProcAddress(aDLLHandle, 'nk_window_set_bounds');
  nk_window_set_focus := GetProcAddress(aDLLHandle, 'nk_window_set_focus');
  nk_window_set_position := GetProcAddress(aDLLHandle, 'nk_window_set_position');
  nk_window_set_scroll := GetProcAddress(aDLLHandle, 'nk_window_set_scroll');
  nk_window_set_size := GetProcAddress(aDLLHandle, 'nk_window_set_size');
  nk_window_show := GetProcAddress(aDLLHandle, 'nk_window_show');
  nk_window_show_if := GetProcAddress(aDLLHandle, 'nk_window_show_if');
  ov_bitrate := GetProcAddress(aDLLHandle, 'ov_bitrate');
  ov_bitrate_instant := GetProcAddress(aDLLHandle, 'ov_bitrate_instant');
  ov_clear := GetProcAddress(aDLLHandle, 'ov_clear');
  ov_comment := GetProcAddress(aDLLHandle, 'ov_comment');
  ov_crosslap := GetProcAddress(aDLLHandle, 'ov_crosslap');
  ov_fopen := GetProcAddress(aDLLHandle, 'ov_fopen');
  ov_halfrate := GetProcAddress(aDLLHandle, 'ov_halfrate');
  ov_halfrate_p := GetProcAddress(aDLLHandle, 'ov_halfrate_p');
  ov_info := GetProcAddress(aDLLHandle, 'ov_info');
  ov_open_callbacks := GetProcAddress(aDLLHandle, 'ov_open_callbacks');
  ov_pcm_seek := GetProcAddress(aDLLHandle, 'ov_pcm_seek');
  ov_pcm_seek_lap := GetProcAddress(aDLLHandle, 'ov_pcm_seek_lap');
  ov_pcm_seek_page := GetProcAddress(aDLLHandle, 'ov_pcm_seek_page');
  ov_pcm_seek_page_lap := GetProcAddress(aDLLHandle, 'ov_pcm_seek_page_lap');
  ov_pcm_tell := GetProcAddress(aDLLHandle, 'ov_pcm_tell');
  ov_pcm_total := GetProcAddress(aDLLHandle, 'ov_pcm_total');
  ov_raw_seek := GetProcAddress(aDLLHandle, 'ov_raw_seek');
  ov_raw_seek_lap := GetProcAddress(aDLLHandle, 'ov_raw_seek_lap');
  ov_raw_tell := GetProcAddress(aDLLHandle, 'ov_raw_tell');
  ov_raw_total := GetProcAddress(aDLLHandle, 'ov_raw_total');
  ov_read := GetProcAddress(aDLLHandle, 'ov_read');
  ov_read_filter := GetProcAddress(aDLLHandle, 'ov_read_filter');
  ov_read_float := GetProcAddress(aDLLHandle, 'ov_read_float');
  ov_seekable := GetProcAddress(aDLLHandle, 'ov_seekable');
  ov_serialnumber := GetProcAddress(aDLLHandle, 'ov_serialnumber');
  ov_streams := GetProcAddress(aDLLHandle, 'ov_streams');
  ov_test_callbacks := GetProcAddress(aDLLHandle, 'ov_test_callbacks');
  ov_test_open := GetProcAddress(aDLLHandle, 'ov_test_open');
  ov_time_seek := GetProcAddress(aDLLHandle, 'ov_time_seek');
  ov_time_seek_lap := GetProcAddress(aDLLHandle, 'ov_time_seek_lap');
  ov_time_seek_page := GetProcAddress(aDLLHandle, 'ov_time_seek_page');
  ov_time_seek_page_lap := GetProcAddress(aDLLHandle, 'ov_time_seek_page_lap');
  ov_time_tell := GetProcAddress(aDLLHandle, 'ov_time_tell');
  ov_time_total := GetProcAddress(aDLLHandle, 'ov_time_total');
  plm_audio_create_with_buffer := GetProcAddress(aDLLHandle, 'plm_audio_create_with_buffer');
  plm_audio_decode := GetProcAddress(aDLLHandle, 'plm_audio_decode');
  plm_audio_destroy := GetProcAddress(aDLLHandle, 'plm_audio_destroy');
  plm_audio_get_samplerate := GetProcAddress(aDLLHandle, 'plm_audio_get_samplerate');
  plm_audio_get_time := GetProcAddress(aDLLHandle, 'plm_audio_get_time');
  plm_audio_has_ended := GetProcAddress(aDLLHandle, 'plm_audio_has_ended');
  plm_audio_has_header := GetProcAddress(aDLLHandle, 'plm_audio_has_header');
  plm_audio_rewind := GetProcAddress(aDLLHandle, 'plm_audio_rewind');
  plm_audio_set_time := GetProcAddress(aDLLHandle, 'plm_audio_set_time');
  plm_buffer_create_for_appending := GetProcAddress(aDLLHandle, 'plm_buffer_create_for_appending');
  plm_buffer_create_with_capacity := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_capacity');
  plm_buffer_create_with_file := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_file');
  plm_buffer_create_with_filename := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_filename');
  plm_buffer_create_with_memory := GetProcAddress(aDLLHandle, 'plm_buffer_create_with_memory');
  plm_buffer_destroy := GetProcAddress(aDLLHandle, 'plm_buffer_destroy');
  plm_buffer_get_remaining := GetProcAddress(aDLLHandle, 'plm_buffer_get_remaining');
  plm_buffer_get_size := GetProcAddress(aDLLHandle, 'plm_buffer_get_size');
  plm_buffer_has_ended := GetProcAddress(aDLLHandle, 'plm_buffer_has_ended');
  plm_buffer_rewind := GetProcAddress(aDLLHandle, 'plm_buffer_rewind');
  plm_buffer_set_load_callback := GetProcAddress(aDLLHandle, 'plm_buffer_set_load_callback');
  plm_buffer_signal_end := GetProcAddress(aDLLHandle, 'plm_buffer_signal_end');
  plm_buffer_write := GetProcAddress(aDLLHandle, 'plm_buffer_write');
  plm_create_with_buffer := GetProcAddress(aDLLHandle, 'plm_create_with_buffer');
  plm_create_with_file := GetProcAddress(aDLLHandle, 'plm_create_with_file');
  plm_create_with_filename := GetProcAddress(aDLLHandle, 'plm_create_with_filename');
  plm_create_with_memory := GetProcAddress(aDLLHandle, 'plm_create_with_memory');
  plm_decode := GetProcAddress(aDLLHandle, 'plm_decode');
  plm_decode_audio := GetProcAddress(aDLLHandle, 'plm_decode_audio');
  plm_decode_video := GetProcAddress(aDLLHandle, 'plm_decode_video');
  plm_demux_create := GetProcAddress(aDLLHandle, 'plm_demux_create');
  plm_demux_decode := GetProcAddress(aDLLHandle, 'plm_demux_decode');
  plm_demux_destroy := GetProcAddress(aDLLHandle, 'plm_demux_destroy');
  plm_demux_get_duration := GetProcAddress(aDLLHandle, 'plm_demux_get_duration');
  plm_demux_get_num_audio_streams := GetProcAddress(aDLLHandle, 'plm_demux_get_num_audio_streams');
  plm_demux_get_num_video_streams := GetProcAddress(aDLLHandle, 'plm_demux_get_num_video_streams');
  plm_demux_get_start_time := GetProcAddress(aDLLHandle, 'plm_demux_get_start_time');
  plm_demux_has_ended := GetProcAddress(aDLLHandle, 'plm_demux_has_ended');
  plm_demux_has_headers := GetProcAddress(aDLLHandle, 'plm_demux_has_headers');
  plm_demux_rewind := GetProcAddress(aDLLHandle, 'plm_demux_rewind');
  plm_demux_seek := GetProcAddress(aDLLHandle, 'plm_demux_seek');
  plm_destroy := GetProcAddress(aDLLHandle, 'plm_destroy');
  plm_frame_to_abgr := GetProcAddress(aDLLHandle, 'plm_frame_to_abgr');
  plm_frame_to_argb := GetProcAddress(aDLLHandle, 'plm_frame_to_argb');
  plm_frame_to_bgr := GetProcAddress(aDLLHandle, 'plm_frame_to_bgr');
  plm_frame_to_bgra := GetProcAddress(aDLLHandle, 'plm_frame_to_bgra');
  plm_frame_to_rgb := GetProcAddress(aDLLHandle, 'plm_frame_to_rgb');
  plm_frame_to_rgba := GetProcAddress(aDLLHandle, 'plm_frame_to_rgba');
  plm_get_audio_enabled := GetProcAddress(aDLLHandle, 'plm_get_audio_enabled');
  plm_get_audio_lead_time := GetProcAddress(aDLLHandle, 'plm_get_audio_lead_time');
  plm_get_duration := GetProcAddress(aDLLHandle, 'plm_get_duration');
  plm_get_framerate := GetProcAddress(aDLLHandle, 'plm_get_framerate');
  plm_get_height := GetProcAddress(aDLLHandle, 'plm_get_height');
  plm_get_loop := GetProcAddress(aDLLHandle, 'plm_get_loop');
  plm_get_num_audio_streams := GetProcAddress(aDLLHandle, 'plm_get_num_audio_streams');
  plm_get_num_video_streams := GetProcAddress(aDLLHandle, 'plm_get_num_video_streams');
  plm_get_samplerate := GetProcAddress(aDLLHandle, 'plm_get_samplerate');
  plm_get_time := GetProcAddress(aDLLHandle, 'plm_get_time');
  plm_get_video_enabled := GetProcAddress(aDLLHandle, 'plm_get_video_enabled');
  plm_get_width := GetProcAddress(aDLLHandle, 'plm_get_width');
  plm_has_ended := GetProcAddress(aDLLHandle, 'plm_has_ended');
  plm_has_headers := GetProcAddress(aDLLHandle, 'plm_has_headers');
  plm_rewind := GetProcAddress(aDLLHandle, 'plm_rewind');
  plm_seek := GetProcAddress(aDLLHandle, 'plm_seek');
  plm_seek_frame := GetProcAddress(aDLLHandle, 'plm_seek_frame');
  plm_set_audio_decode_callback := GetProcAddress(aDLLHandle, 'plm_set_audio_decode_callback');
  plm_set_audio_enabled := GetProcAddress(aDLLHandle, 'plm_set_audio_enabled');
  plm_set_audio_lead_time := GetProcAddress(aDLLHandle, 'plm_set_audio_lead_time');
  plm_set_audio_stream := GetProcAddress(aDLLHandle, 'plm_set_audio_stream');
  plm_set_loop := GetProcAddress(aDLLHandle, 'plm_set_loop');
  plm_set_video_decode_callback := GetProcAddress(aDLLHandle, 'plm_set_video_decode_callback');
  plm_set_video_enabled := GetProcAddress(aDLLHandle, 'plm_set_video_enabled');
  plm_video_create_with_buffer := GetProcAddress(aDLLHandle, 'plm_video_create_with_buffer');
  plm_video_decode := GetProcAddress(aDLLHandle, 'plm_video_decode');
  plm_video_destroy := GetProcAddress(aDLLHandle, 'plm_video_destroy');
  plm_video_get_framerate := GetProcAddress(aDLLHandle, 'plm_video_get_framerate');
  plm_video_get_height := GetProcAddress(aDLLHandle, 'plm_video_get_height');
  plm_video_get_time := GetProcAddress(aDLLHandle, 'plm_video_get_time');
  plm_video_get_width := GetProcAddress(aDLLHandle, 'plm_video_get_width');
  plm_video_has_ended := GetProcAddress(aDLLHandle, 'plm_video_has_ended');
  plm_video_has_header := GetProcAddress(aDLLHandle, 'plm_video_has_header');
  plm_video_rewind := GetProcAddress(aDLLHandle, 'plm_video_rewind');
  plm_video_set_no_delay := GetProcAddress(aDLLHandle, 'plm_video_set_no_delay');
  plm_video_set_time := GetProcAddress(aDLLHandle, 'plm_video_set_time');
  stbi_convert_iphone_png_to_rgb := GetProcAddress(aDLLHandle, 'stbi_convert_iphone_png_to_rgb');
  stbi_convert_iphone_png_to_rgb_thread := GetProcAddress(aDLLHandle, 'stbi_convert_iphone_png_to_rgb_thread');
  stbi_failure_reason := GetProcAddress(aDLLHandle, 'stbi_failure_reason');
  stbi_flip_vertically_on_write := GetProcAddress(aDLLHandle, 'stbi_flip_vertically_on_write');
  stbi_hdr_to_ldr_gamma := GetProcAddress(aDLLHandle, 'stbi_hdr_to_ldr_gamma');
  stbi_hdr_to_ldr_scale := GetProcAddress(aDLLHandle, 'stbi_hdr_to_ldr_scale');
  stbi_image_free := GetProcAddress(aDLLHandle, 'stbi_image_free');
  stbi_info := GetProcAddress(aDLLHandle, 'stbi_info');
  stbi_info_from_callbacks := GetProcAddress(aDLLHandle, 'stbi_info_from_callbacks');
  stbi_info_from_file := GetProcAddress(aDLLHandle, 'stbi_info_from_file');
  stbi_info_from_memory := GetProcAddress(aDLLHandle, 'stbi_info_from_memory');
  stbi_is_16_bit := GetProcAddress(aDLLHandle, 'stbi_is_16_bit');
  stbi_is_16_bit_from_callbacks := GetProcAddress(aDLLHandle, 'stbi_is_16_bit_from_callbacks');
  stbi_is_16_bit_from_file := GetProcAddress(aDLLHandle, 'stbi_is_16_bit_from_file');
  stbi_is_16_bit_from_memory := GetProcAddress(aDLLHandle, 'stbi_is_16_bit_from_memory');
  stbi_is_hdr := GetProcAddress(aDLLHandle, 'stbi_is_hdr');
  stbi_is_hdr_from_callbacks := GetProcAddress(aDLLHandle, 'stbi_is_hdr_from_callbacks');
  stbi_is_hdr_from_file := GetProcAddress(aDLLHandle, 'stbi_is_hdr_from_file');
  stbi_is_hdr_from_memory := GetProcAddress(aDLLHandle, 'stbi_is_hdr_from_memory');
  stbi_ldr_to_hdr_gamma := GetProcAddress(aDLLHandle, 'stbi_ldr_to_hdr_gamma');
  stbi_ldr_to_hdr_scale := GetProcAddress(aDLLHandle, 'stbi_ldr_to_hdr_scale');
  stbi_load := GetProcAddress(aDLLHandle, 'stbi_load');
  stbi_load_16 := GetProcAddress(aDLLHandle, 'stbi_load_16');
  stbi_load_16_from_callbacks := GetProcAddress(aDLLHandle, 'stbi_load_16_from_callbacks');
  stbi_load_16_from_memory := GetProcAddress(aDLLHandle, 'stbi_load_16_from_memory');
  stbi_load_from_callbacks := GetProcAddress(aDLLHandle, 'stbi_load_from_callbacks');
  stbi_load_from_file := GetProcAddress(aDLLHandle, 'stbi_load_from_file');
  stbi_load_from_file_16 := GetProcAddress(aDLLHandle, 'stbi_load_from_file_16');
  stbi_load_from_memory := GetProcAddress(aDLLHandle, 'stbi_load_from_memory');
  stbi_load_gif_from_memory := GetProcAddress(aDLLHandle, 'stbi_load_gif_from_memory');
  stbi_loadf := GetProcAddress(aDLLHandle, 'stbi_loadf');
  stbi_loadf_from_callbacks := GetProcAddress(aDLLHandle, 'stbi_loadf_from_callbacks');
  stbi_loadf_from_file := GetProcAddress(aDLLHandle, 'stbi_loadf_from_file');
  stbi_loadf_from_memory := GetProcAddress(aDLLHandle, 'stbi_loadf_from_memory');
  stbi_set_flip_vertically_on_load := GetProcAddress(aDLLHandle, 'stbi_set_flip_vertically_on_load');
  stbi_set_flip_vertically_on_load_thread := GetProcAddress(aDLLHandle, 'stbi_set_flip_vertically_on_load_thread');
  stbi_set_unpremultiply_on_load := GetProcAddress(aDLLHandle, 'stbi_set_unpremultiply_on_load');
  stbi_set_unpremultiply_on_load_thread := GetProcAddress(aDLLHandle, 'stbi_set_unpremultiply_on_load_thread');
  stbi_write_bmp := GetProcAddress(aDLLHandle, 'stbi_write_bmp');
  stbi_write_bmp_to_func := GetProcAddress(aDLLHandle, 'stbi_write_bmp_to_func');
  stbi_write_hdr := GetProcAddress(aDLLHandle, 'stbi_write_hdr');
  stbi_write_hdr_to_func := GetProcAddress(aDLLHandle, 'stbi_write_hdr_to_func');
  stbi_write_jpg := GetProcAddress(aDLLHandle, 'stbi_write_jpg');
  stbi_write_jpg_to_func := GetProcAddress(aDLLHandle, 'stbi_write_jpg_to_func');
  stbi_write_png := GetProcAddress(aDLLHandle, 'stbi_write_png');
  stbi_write_png_to_func := GetProcAddress(aDLLHandle, 'stbi_write_png_to_func');
  stbi_write_tga := GetProcAddress(aDLLHandle, 'stbi_write_tga');
  stbi_write_tga_to_func := GetProcAddress(aDLLHandle, 'stbi_write_tga_to_func');
  stbi_zlib_decode_buffer := GetProcAddress(aDLLHandle, 'stbi_zlib_decode_buffer');
  stbi_zlib_decode_malloc := GetProcAddress(aDLLHandle, 'stbi_zlib_decode_malloc');
  stbi_zlib_decode_malloc_guesssize := GetProcAddress(aDLLHandle, 'stbi_zlib_decode_malloc_guesssize');
  stbi_zlib_decode_malloc_guesssize_headerflag := GetProcAddress(aDLLHandle, 'stbi_zlib_decode_malloc_guesssize_headerflag');
  stbi_zlib_decode_noheader_buffer := GetProcAddress(aDLLHandle, 'stbi_zlib_decode_noheader_buffer');
  stbi_zlib_decode_noheader_malloc := GetProcAddress(aDLLHandle, 'stbi_zlib_decode_noheader_malloc');
  stbtt_BakeFontBitmap := GetProcAddress(aDLLHandle, 'stbtt_BakeFontBitmap');
  stbtt_CompareUTF8toUTF16_bigendian := GetProcAddress(aDLLHandle, 'stbtt_CompareUTF8toUTF16_bigendian');
  stbtt_FindGlyphIndex := GetProcAddress(aDLLHandle, 'stbtt_FindGlyphIndex');
  stbtt_FindMatchingFont := GetProcAddress(aDLLHandle, 'stbtt_FindMatchingFont');
  stbtt_FindSVGDoc := GetProcAddress(aDLLHandle, 'stbtt_FindSVGDoc');
  stbtt_FreeBitmap := GetProcAddress(aDLLHandle, 'stbtt_FreeBitmap');
  stbtt_FreeSDF := GetProcAddress(aDLLHandle, 'stbtt_FreeSDF');
  stbtt_FreeShape := GetProcAddress(aDLLHandle, 'stbtt_FreeShape');
  stbtt_GetBakedQuad := GetProcAddress(aDLLHandle, 'stbtt_GetBakedQuad');
  stbtt_GetCodepointBitmap := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointBitmap');
  stbtt_GetCodepointBitmapBox := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointBitmapBox');
  stbtt_GetCodepointBitmapBoxSubpixel := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointBitmapBoxSubpixel');
  stbtt_GetCodepointBitmapSubpixel := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointBitmapSubpixel');
  stbtt_GetCodepointBox := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointBox');
  stbtt_GetCodepointHMetrics := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointHMetrics');
  stbtt_GetCodepointKernAdvance := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointKernAdvance');
  stbtt_GetCodepointSDF := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointSDF');
  stbtt_GetCodepointShape := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointShape');
  stbtt_GetCodepointSVG := GetProcAddress(aDLLHandle, 'stbtt_GetCodepointSVG');
  stbtt_GetFontBoundingBox := GetProcAddress(aDLLHandle, 'stbtt_GetFontBoundingBox');
  stbtt_GetFontNameString := GetProcAddress(aDLLHandle, 'stbtt_GetFontNameString');
  stbtt_GetFontOffsetForIndex := GetProcAddress(aDLLHandle, 'stbtt_GetFontOffsetForIndex');
  stbtt_GetFontVMetrics := GetProcAddress(aDLLHandle, 'stbtt_GetFontVMetrics');
  stbtt_GetFontVMetricsOS2 := GetProcAddress(aDLLHandle, 'stbtt_GetFontVMetricsOS2');
  stbtt_GetGlyphBitmap := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphBitmap');
  stbtt_GetGlyphBitmapBox := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphBitmapBox');
  stbtt_GetGlyphBitmapBoxSubpixel := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphBitmapBoxSubpixel');
  stbtt_GetGlyphBitmapSubpixel := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphBitmapSubpixel');
  stbtt_GetGlyphBox := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphBox');
  stbtt_GetGlyphHMetrics := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphHMetrics');
  stbtt_GetGlyphKernAdvance := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphKernAdvance');
  stbtt_GetGlyphSDF := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphSDF');
  stbtt_GetGlyphShape := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphShape');
  stbtt_GetGlyphSVG := GetProcAddress(aDLLHandle, 'stbtt_GetGlyphSVG');
  stbtt_GetKerningTable := GetProcAddress(aDLLHandle, 'stbtt_GetKerningTable');
  stbtt_GetKerningTableLength := GetProcAddress(aDLLHandle, 'stbtt_GetKerningTableLength');
  stbtt_GetNumberOfFonts := GetProcAddress(aDLLHandle, 'stbtt_GetNumberOfFonts');
  stbtt_GetPackedQuad := GetProcAddress(aDLLHandle, 'stbtt_GetPackedQuad');
  stbtt_GetScaledFontVMetrics := GetProcAddress(aDLLHandle, 'stbtt_GetScaledFontVMetrics');
  stbtt_InitFont := GetProcAddress(aDLLHandle, 'stbtt_InitFont');
  stbtt_IsGlyphEmpty := GetProcAddress(aDLLHandle, 'stbtt_IsGlyphEmpty');
  stbtt_MakeCodepointBitmap := GetProcAddress(aDLLHandle, 'stbtt_MakeCodepointBitmap');
  stbtt_MakeCodepointBitmapSubpixel := GetProcAddress(aDLLHandle, 'stbtt_MakeCodepointBitmapSubpixel');
  stbtt_MakeCodepointBitmapSubpixelPrefilter := GetProcAddress(aDLLHandle, 'stbtt_MakeCodepointBitmapSubpixelPrefilter');
  stbtt_MakeGlyphBitmap := GetProcAddress(aDLLHandle, 'stbtt_MakeGlyphBitmap');
  stbtt_MakeGlyphBitmapSubpixel := GetProcAddress(aDLLHandle, 'stbtt_MakeGlyphBitmapSubpixel');
  stbtt_MakeGlyphBitmapSubpixelPrefilter := GetProcAddress(aDLLHandle, 'stbtt_MakeGlyphBitmapSubpixelPrefilter');
  stbtt_PackBegin := GetProcAddress(aDLLHandle, 'stbtt_PackBegin');
  stbtt_PackEnd := GetProcAddress(aDLLHandle, 'stbtt_PackEnd');
  stbtt_PackFontRange := GetProcAddress(aDLLHandle, 'stbtt_PackFontRange');
  stbtt_PackFontRanges := GetProcAddress(aDLLHandle, 'stbtt_PackFontRanges');
  stbtt_PackFontRangesGatherRects := GetProcAddress(aDLLHandle, 'stbtt_PackFontRangesGatherRects');
  stbtt_PackFontRangesPackRects := GetProcAddress(aDLLHandle, 'stbtt_PackFontRangesPackRects');
  stbtt_PackFontRangesRenderIntoRects := GetProcAddress(aDLLHandle, 'stbtt_PackFontRangesRenderIntoRects');
  stbtt_PackSetOversampling := GetProcAddress(aDLLHandle, 'stbtt_PackSetOversampling');
  stbtt_PackSetSkipMissingCodepoints := GetProcAddress(aDLLHandle, 'stbtt_PackSetSkipMissingCodepoints');
  stbtt_Rasterize := GetProcAddress(aDLLHandle, 'stbtt_Rasterize');
  stbtt_ScaleForMappingEmToPixels := GetProcAddress(aDLLHandle, 'stbtt_ScaleForMappingEmToPixels');
  stbtt_ScaleForPixelHeight := GetProcAddress(aDLLHandle, 'stbtt_ScaleForPixelHeight');
  unzClose := GetProcAddress(aDLLHandle, 'unzClose');
  unzCloseCurrentFile := GetProcAddress(aDLLHandle, 'unzCloseCurrentFile');
  unzGetCurrentFileInfo64 := GetProcAddress(aDLLHandle, 'unzGetCurrentFileInfo64');
  unzLocateFile := GetProcAddress(aDLLHandle, 'unzLocateFile');
  unzOpen64 := GetProcAddress(aDLLHandle, 'unzOpen64');
  unzOpenCurrentFilePassword := GetProcAddress(aDLLHandle, 'unzOpenCurrentFilePassword');
  unzReadCurrentFile := GetProcAddress(aDLLHandle, 'unzReadCurrentFile');
  unztell64 := GetProcAddress(aDLLHandle, 'unztell64');
  zipClose := GetProcAddress(aDLLHandle, 'zipClose');
  zipCloseFileInZip := GetProcAddress(aDLLHandle, 'zipCloseFileInZip');
  zipOpen64 := GetProcAddress(aDLLHandle, 'zipOpen64');
  zipOpenNewFileInZip3_64 := GetProcAddress(aDLLHandle, 'zipOpenNewFileInZip3_64');
  zipWriteInFileInZip := GetProcAddress(aDLLHandle, 'zipWriteInFileInZip');
end;

end.
