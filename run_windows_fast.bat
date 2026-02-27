@echo off

cd /D "%~dp0"

if not exist "compiler\zig\zig.exe" (
	echo Local Zig compiler not found at compiler\zig\zig.exe.
	echo Run .\run_windows.bat once to install the compiler, then use this script.
	exit /b 1
)

set "BUILD_ARGS=-Doptimize=ReleaseFast"
if not "%~1"=="" (
	set "BUILD_ARGS=%*"
)

echo Building Zig Cubyz (%BUILD_ARGS%) from source. This uses existing cached artifacts.
compiler\zig\zig build --error-style minimal %BUILD_ARGS%

if errorlevel 1 (
	exit /b 1
)

echo Cubyz successfully built.
echo Launching Cubyz.
zig-out\bin\Cubyz

