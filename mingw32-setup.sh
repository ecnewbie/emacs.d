#!/bin/bash

if [[ $1 == "-r" ]] ; then
	echo "regenerating"
	mkpasswd > /etc/passwd; mkgroup > /etc/group
	echo "Server = http://mirror.bit.edu.cn/msys2/REPOS/MSYS2/i686" > /etc/pacman.d/mirrorlist.msys
	echo "Server = http://mirror.bit.edu.cn/msys2/REPOS/MINGW/i686" > /etc/pacman.d/mirrorlist.mingw32
	echo "Server = http://mirror.bit.edu.cn/msys2/REPOS/MINGW/x86_64" > /etc/pacman.d/mirrorlist.mingw64
	pacman -Syuu
fi

function CheckCommand()
{
	ret=0
	for v in $*; do
		result=`command -v ${v} >/dev/null 2>&1 && echo 0`
		if [[ -z ${result} ]] ; then
			echo >&2 "CheckCommand: ${v} not found.";
			ret=1
		fi
	done
 	return ${ret}
}

install_command="pacman -S"

function MaybeInstall()
{
	for v in $*; do
		CheckCommand ${v} || ${install_command} ${v}
	done
}

MaybeInstall python make cmake clang emacs ctags etags global gdb w3m

CheckCommand emacs || ${install_command} mingw32/mingw-w64-i686-emacs

CheckCommand ag || ${install_command} mingw32/mingw-w64-i686-ag

CheckCommand lua || ${install_command} mingw32/mingw-w64-i686-lua

CheckCommand plink || ${install_command} mingw32/mingw-w64-i686-putty-ssh

CheckCommand git || ${install_command} msys/git

CheckCommand zsh || (echo "Warning: zsh is not need but also install it" && ${install_command} zsh)

# python setup.
CheckCommand pip || ${install_command} mingw32/mingw-w64-i686-python2-pip
