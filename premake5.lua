workspace "HelloOpenGL"
	architecture "x64"
	startproject "OpenGL-Sandbox"

	configurations {
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

include "vendor/glfw"

project "OpenGL-Sandbox"
	location "OpenGL-Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir    ("bin-int/" .. outputdir .. "/%{prj.name}")

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/stb_image/**.h",
		"%{prj.name}/vendor/stb_image/**.cpp",
		"%{prj.name}/vendor/imgui/**.h",
		"%{prj.name}/vendor/imgui/**.cpp",
	}

	removefiles {
		"%{prj.name}/vendor/imgui/main.cpp",
	}

	defines {
		"GLEW_STATIC",
		"_WIN32"
	}

	includedirs {
		"%{prj.name}/src",
		"%{prj.name}/vendor",
		"vendor/glew/include",
		"vendor/glfw/include",
		"vendor"
	}

	libdirs {
		"vendor/glew/lib/Release/x64"
	}

	links { 
		"GLFW",
		"glew32s.lib",
		"opengl32.lib"
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "on"
		
	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "on"

		
