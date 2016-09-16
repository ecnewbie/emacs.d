#!/bin/bash

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

CheckCommand git find grep ag python || echo -e "These should be installed.\n"

CheckCommand clang cmake rc rdm doxymacs_parser || echo -e "C++ not fully supported.\n"

CheckCommand global gdb w3m etags ctags lua || echo "Alternative: These may need."