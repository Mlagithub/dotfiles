@echo off
chcp 65001 >nul
title 移除 Neovim 资源管理器右键菜单

echo ========================================================
echo        移除 Neovim 资源管理器右键菜单
echo ========================================================
echo.

reg delete "HKCU\Software\Classes\*\shell\OpenWithNeovim" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Directory\shell\OpenWithNeovim" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Directory\Background\shell\OpenWithNeovim" /f >nul 2>&1

echo [成功] 已清理所有 Neovim 右键菜单注册表项。
echo.
pause