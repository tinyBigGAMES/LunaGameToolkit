#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#define GLAD_GL_IMPLEMENTATION
#include <glad/GL.h>

#define NK_INCLUDE_FIXED_TYPES
#define NK_INCLUDE_STANDARD_IO
#define NK_INCLUDE_STANDARD_VARARGS
#define NK_INCLUDE_DEFAULT_ALLOCATOR
#define NK_INCLUDE_VERTEX_BUFFER_OUTPUT
#define NK_INCLUDE_FONT_BAKING
#define NK_INCLUDE_DEFAULT_FONT
#define NK_IMPLEMENTATION
#define NK_KEYSTATE_BASED_INPUT
#define STBTT_STATIC
#define NK_API __declspec( dllexport )
#include "nuklear.h"
#define NK_GLFW_GL2_IMPLEMENTATION
#include "nuklear_glfw_gl2.h"