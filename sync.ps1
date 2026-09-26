param(
    [switch]$Link,
    [switch]$Push,
    [string]$Message = "chore: update dotfiles"
)

$dotfilesNvim = "$PSScriptRoot\nvim"
$appdataNvim = "$env:LOCALAPPDATA\nvim"

if ($Link) {
    if (Get-Process nvim -ErrorAction SilentlyContinue) {
        Write-Warning "请先退出所有正在运行的 Neovim 窗口后再执行软链接绑定！"
        return
    }
    if (Test-Path $appdataNvim) {
        $item = Get-Item $appdataNvim
        if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            Write-Host "已经是软链接/Junction，无需重复创建。" -ForegroundColor Green
            return
        }
        Remove-Item -Recurse -Force $appdataNvim
    }
    New-Item -ItemType Junction -Path $appdataNvim -Target $dotfilesNvim
    Write-Host "成功将 $appdataNvim 链接至 $dotfilesNvim！" -ForegroundColor Green
    return
}

# 检查是否已经是软链接，如果不是，先从 AppData 拷贝最新配置
if (Test-Path $appdataNvim) {
    $item = Get-Item $appdataNvim
    $isJunction = [bool]($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint)
    if (-not $isJunction) {
        Copy-Item -Recurse -Force "$appdataNvim\*" "$dotfilesNvim\"
    }
}

if ($Push) {
    Set-Location $PSScriptRoot
    git add .
    git commit -m $Message
    git push origin main
    Write-Host "已成功同步并推送到远程仓库！" -ForegroundColor Green
}
