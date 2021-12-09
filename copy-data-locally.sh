runlist=${1:-run.list}
out=${2:-curl.config.txt}
checksums=${3:-checksums.txt}

command -v md5 > /dev/null && MD5COMMAND=md5 || MD5COMMAND=md5sum

rm -f $out
mkdir -p data

for run in $(cat $runlist | tr "," " "); do
  src="https://cernbox.cern.ch/index.php/s/r7VFXonK39smzKP/download?path=${run}/AnalysisResults.root"
  dest="data/run${run}.data.root"
  transfert="yes"
  if test -f $dest; then
    # file already there. check its checksum
    ref_checksum=$(grep $dest $checksums | cut -d ' ' -f 1)
    checksum=$(${MD5COMMAND} $dest | cut -d ' ' -f 1)
    if [ "$ref_checksum" == "$checksum" ]; then
       transfert="no"
    fi
  fi
  if [ "$transfert" = "yes" ]; then
    echo url = \"$src\" >> $out
    echo output = \"$dest\" >> $out
  fi
done

test -f $out && time curl -Z -# -K $out

rm -f $out
