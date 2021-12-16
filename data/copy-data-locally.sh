runlist=${1:-run.list}
out=${2:-curl.config.txt}
checksums_template=${3:-checksums.txt.ini}
dest_dir=${4:-/data}

command -v md5 > /dev/null && MD5COMMAND=md5 || MD5COMMAND=md5sum

rm -f $out
mkdir -p $dest_dir || exit

rm -f checksums.txt
cat ${checksums_template} | sed s+DESTDIR+${dest_dir}+ > checksums.txt

for run in $(cat $runlist | tr "," " "); do
  src="https://cernbox.cern.ch/index.php/s/r7VFXonK39smzKP/download?path=${run}/AnalysisResults.root"
  dest="${dest_dir}/run${run}.data.root"
  transfert="yes"
  if test -f $dest; then
    # file already there. check its checksum
    ref_checksum=$(grep $dest checksums.txt | cut -d ' ' -f 1)
    checksum=$(${MD5COMMAND} $dest | cut -d ' ' -f 1)
    if [ "$ref_checksum" == "$checksum" ]; then
       echo "file:$dest already downloaded successfully"
       transfert="no"
    fi
  fi
  if [ "$transfert" = "yes" ]; then
    echo "file:$dest will need to be downloaded"
    echo url = \"$src\" >> $out
    echo output = \"$dest\" >> $out
  fi
done

test -f $out && time curl -Z -# -K $out

rm -f $out
