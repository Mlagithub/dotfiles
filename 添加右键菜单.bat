@echo off
chcp 65001 >nul
title 添加 Neovim 到资源管理器右键菜单

echo ========================================================
echo        添加 Neovim 到 Windows 资源管理器右键菜单
echo ========================================================
echo.

set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

REM 智能寻找 nvim.exe 路径
REM 1. 优先使用当前离线包目录内的 nvim.exe
set "NVIM_EXE=%ROOT%\nvim-win64\bin\nvim.exe"

REM 2. 若当前目录没有，尝试系统常见安装路径
if not exist "%NVIM_EXE%" (
    if exist "D:\app\nvim-win64\bin\nvim.exe" (
        set "NVIM_EXE=D:\app\nvim-win64\bin\nvim.exe"
    )
)

REM 3. 尝试从 PATH 中寻找
if not exist "%NVIM_EXE%" (
    for /f "delims=" %%I in ('where nvim.exe 2^>nul') do (
        set "NVIM_EXE=%%I"
    )
)

if not exist "%NVIM_EXE%" (
    echo [错误] 未能找到 nvim.exe！
    echo 请确认本脚本是否存放在离线包根目录下，或者系统中已安装 Neovim。
    echo.
    pause
    exit /b 1
)

echo 检测到 Neovim 目标路径: "%NVIM_EXE%"
echo 正在写入当前用户注册表 (无需管理员权限)...
echo.

REM 1. 针对任意文件
reg add "HKCU\Software\Classes\*\shell\OpenWithNeovim" /f /ve /t REG_SZ /d "在 Neovim 中打开" >nul
reg add "HKCU\Software\Classes\*\shell\OpenWithNeovim" /f /v "Icon" /t REG_SZ /d "\"%NVIM_EXE%\",0" >nul
reg add "HKCU\Software\Classes\*\shell\OpenWithNeovim\command" /f /ve /t REG_SZ /d "\"%NVIM_EXE%\" \"%%1\"" >nul

REM 2. 针对文件夹图标
reg add "HKCU\Software\Classes\Directory\shell\OpenWithNeovim" /f /ve /t REG_SZ /d "在 Neovim 中打开" >nul
reg add "HKCU\Software\Classes\Directory\shell\OpenWithNeovim" /f /v "Icon" /t REG_SZ /d "\"%NVIM_EXE%\",0" >nul
reg add "HKCU\Software\Classes\Directory\shell\OpenWithNeovim\command" /f /ve /t REG_SZ /d "cmd.exe /s /c \"cd /d \"%%V\" ^&^& start \"\" \"%NVIM_EXE%\" .\"" >nul

REM 3. 针对文件夹内部空白处
reg add "HKCU\Software\Classes\Directory\Background\shell\OpenWithNeovim" /f /ve /t REG_SZ /d "在 Neovim 中打开" >nul
reg add "HKCU\Software\Classes\Directory\Background\shell\OpenWithNeovim" /f /v "Icon" /t REG_SZ /d "\"%NVIM_EXE%\",0" >nul
reg add "HKCU\Software\Classes\Directory\Background\shell\OpenWithNeovim\command" /f /ve /t REG_SZ /d "cmd.exe /s /c \"cd /d \"%%V\" ^&^& start \"\" \"%NVIM_EXE%\" .\"" >nul

if %errorlevel% equ 0 (
    echo [成功] 右键菜单注册完成！
    echo.
    echo 现在你可以在：
    echo   1. 任意文件上点击右键 -- 在 Neovim 中打开
    echo   2. 任意文件夹图标上点击右键 -- 在 Neovim 中打开
    echo   3. 任意文件夹内部空白处点击右键 -- 在 Neovim 中打开
) else (
    echo [失败] 注册表写入异常，请检查权限。
)

echo.
pause