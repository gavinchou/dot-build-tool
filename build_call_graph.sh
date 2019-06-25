#!/bin/bash
## @brief  build dot file to svg with js plugin embedded
## @email  gavineaglechou@gmail.com
## @date   2019-06-17-Mon

cwd=`pwd`

# check if symlink
file=`readlink $0`
if [ "x${file}" == "x" ]; then
  file=$0
fi
pushd "$(dirname ${file})" > /dev/null
attach=`pwd -P`/call_graph_highlight_plugin.xml
popd > /dev/null

src=$1
out=$2

if [ ! -f ${attach} ]; then
  echo "attachment: ${attach} not found, unable to continue"
  exit -1
fi

if [ "x${src}" == "x" ]; then
  echo "usage:"
  echo "  $0 "'${src} ${out}'
  exit -1
fi

if [ ! -f ${src} ]; then
  echo "src: ${src} not found, unable to continue"
  exit -1
fi

if [ "x${out}" == "x" ]; then
  out=${cwd}/a.svg
else
  if [[ "${out}" != "/*" ]] || [[ "${out}" != "~*" ]]; then
    out=${out}
  else
    out="${cwd}/${out}"
  fi
fi

# echo ${out}
which dot > /dev/null
if [ $? -ne 0 ]; then
	echo "no graphviz dot found"
	exit -1
fi

dot -Tsvg -o ${out} ${src} > /dev/null

sed -i.bak 's#</svg>##' ${out}
rm -f ${out}.bak

cat "${attach}" >> ${out}
echo "</svg>" >> ${out}
