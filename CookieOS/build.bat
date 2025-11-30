@echo off
echo ===================================
echo Building CookieOS...
===================================

echo.
echo [1/5] Assembling bootloader...
nasm -f bin BOOT.asm -o boot.bin
if errorlevel 1 goto error

echo [2/5] Assembling PAGING.asm...
nasm -f elf64 PAGING.asm -o paging.o
if errorlevel 1 goto error

echo [3/5] Assembling KERNEL.asm...
nasm -f elf64 KERNEL.asm -o kernel.o
if errorlevel 1 goto error

echo [4/5] Assembling DESKTOP.asm...
nasm -f elf64 DESKTOP.asm -o desktop.o
if errorlevel 1 goto error

echo [5/5] Linking kernel...
ld -nostdlib -T linker.ld -o kernel.elf paging.o kernel.o desktop.o
if errorlevel 1 goto error

echo [6/6] Converting to binary...
objcopy -O binary kernel.elf kernel.bin
if errorlevel 1 goto error

echo.
echo [*] Creating bootable image...
copy /b boot.bin+kernel.bin cookieos.img
if errorlevel 1 goto error

echo.
echo ===================================
echo CookieOS built successfully!
echo Image: cookieos.img
echo Size:
dir cookieos.img | find "cookieos.img"
echo ===================================
echo.
echo To test in QEMU, run:
echo qemu-system-x86_64 -drive format=raw,file=cookieos.img -m 512M
echo.
goto end

:error
echo.
echo ===================================
echo BUILD FAILED!
echo ===================================
pause
exit /b 1

:end
pause