if "x%~1"=="x" goto :EOF

pushd "%~dp0"
call %1
goto :DONE

:BEFORE_WIM_MOUNT
rem ===================================
rem set Enviroment
rem BUILD_NUMBER
for /f "tokens=3 delims=." %%v in ("%WB_PE_VER%") do set VER[3]=%%v
rem ===================================
rem SYSTEM_PATH
set X=X
set X_WIN=%X%\Windows
set X_SYS=%X_WIN%\System32
rem ===================================
rem reduce the wim file before mounting it
cd /d za-Slim
call SlimWim.bat
rem ===================================
goto :EOF

:BEFORE_HIVE_LOAD
if "x%opt[build.registry.software]%"=="xfull" (
  call AddFiles \Windows\System32\config\SOFTWARE
  set REGCOPY_SKIP_SOFTWARE=1
)
goto :EOF

:DONE
popd
