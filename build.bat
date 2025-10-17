@echo off

setlocal EnableDelayedExpansion

set vendor_dir=freetype
set binaries_dir=objs\.libs\

if not exist %vendor_dir%\NUL (
    git clone --recurse-submodules https://github.com/freetype/freetype --depth=1 %vendor_dir%
    pushd %vendor_dir%
)

echo Configuring build...
make
REM make setup visualc

echo Building project...
make CC=clang

copy /y %binaries_dir%\freetype.lib ..\

echo Build completed successfully!
popd
