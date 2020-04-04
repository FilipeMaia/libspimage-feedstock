setlocal EnableDelayedExpansion
:: Remove -GL from CXXFLAGS as this causes a fatal error when combined with WINDOWS_EXPORT_ALL_SYMBOLS
set "CXXFLAGS=%CXXFLAGS:-GL=%"
:: Remove -GL from CFLAGS as this causes a fatal error when combined with WINDOWS_EXPORT_ALL_SYMBOLS
set "CFLAGS=%CFLAGS:-GL=%"

:: Make a build folder and change to it.
mkdir build
cd build

:: Configure using the CMakeFiles
cmake -G "NMake Makefiles" ^
      -DUSE_CUDA=OFF ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      ..
if errorlevel 1 exit 1

:: Build!
nmake
if errorlevel 1 exit 1

:: Install!
nmake install
if errorlevel 1 exit 1

