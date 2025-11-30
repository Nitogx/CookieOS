# CookieOS
An operating system written in ASM!

>[!WARNING]
>Proceed with caution. To build the os you must be an expert or follow a tutorial! I'm serious!!

> [!CAUTION]
> If you wanna make a fork of the os make sure to give me credits and not redistribute it as a dangerous os! Assembly can let you do dangerous things!

> [!IMPORTANT]
> The opreratiing system is still in a state of development wich means it's not full and maybe has bugs! Please report them in the Issues tab.


## About this yes... this
It's an os written in Assembly or machine code in bare metal <img src="https://s1.ezgif.com/tmp/ezgif-15d3c2575b5eedac.gif" width="50px">
that is based off nothing lol and will support  up to 16GB of ram (i hope paging will accept that <img src="https://github.com/Nitogx/CookieOS/blob/main/ReadMe-Icons/pensive.png" width="20px">) and will have a custom window manager n stuff.

## Is it open-source??
Obviously duhh just go to the [main](CookieOS) directory and you have all the os files!

## When release????
For now im working on the desktop interface because i finally
fixed the problem of kernel crashing

## How to build?
- Download the whole repo
- Download NASM
- Add nasm to your PATH
- Grab MSYS2
- Add the MinGW64 bin folder to your path
- Run MSYS2 (the MinGW64 app) and paste this ```pacman -S mingw-w64-x86_64-binutils```
- Next, run the .bat file in Command Prompt
- And run the cookieos.img in your virtualization software! (QEMU recommended)

>[!TIP]
>***YOU MIGHT NEED TO RESTART YOUR COMPUTER IF YOU SEE THAT NASM OR LD IS NOT RECOGNIZED AS A EXTERNAL COMMAND OR APPLICATION.***
