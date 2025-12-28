workspace "Solution"
	architecture "x64"
	staticruntime "On"
	systemversion "latest"
	
	startproject "Application"

	configurations
	{
		"Debug",
		"Release"
	}

	buildoptions { "/utf-8" }

outputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}/"

IncludeDirs = {}

project "Core"
	location "Core"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"

	targetdir(".bin/" .. outputDir .. "%{prj.name}/")
	objdir(".bin-int/" .. outputDir .. "%{prj.name}/")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src"
	}

	defines
	{
	}

	filter "configurations:Debug"
		defines "SLN_DEBUG"
		symbols "On"
		runtime "Debug"

	filter "configurations:Release"
		defines "SLN_RELEASE"
		optimize "Speed"
		runtime "Release"

project "Application"
	location "Application"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"

	targetdir(".bin/" .. outputDir .. "%{prj.name}/")
	objdir(".bin-int/" .. outputDir .. "%{prj.name}/")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"Core/src"
	}

	links
	{
		"Core"
	}

	filter "configurations:Debug"
		defines "SLN_DEBUG"
		symbols "On"
		runtime "Debug"

	filter "configurations:Release"
		defines "SLN_RELEASE"
		optimize "Speed"
		runtime "Release"
