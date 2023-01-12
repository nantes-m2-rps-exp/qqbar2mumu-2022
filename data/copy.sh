type=${1:-data}
runlist=${2:-run.list}
out=${3:-curl.config.${type}.txt}
checksums_template=${4:-checksums.${type}.txt.ini}
dest_dir=${5:-/home/jimushoko/Documents/Cours/Projet_Expérimental/qqbar2mumu-2022/data_dl}

command -v md5 > /dev/null && MD5COMMAND=md5 || MD5COMMAND=md5sum

rm -f $out
mkdir -p $dest_dir || exit

rm -f checksums.${type}.txt
cat ${checksums_template} | sed s+DESTDIR+${dest_dir}+ > checksums.${type}.txt

baselink="https://cernbox.cern.ch/remote.php/dav/public-files/JIjQaAYEQnmRDkX"
if [ "$type" == "mc" ]; then
	baselink="https://cernbox.cern.ch/remote.php/dav/public-files/nbPmKbcsJvZrjjx"
fi

for run in $(cat $runlist | tr "," " "); do
  src="${baselink}/${run}/AnalysisResults.root"
  dest="${dest_dir}/run${run}.${type}.root"
  transfert="yes"
  if test -f $dest; then
    # file already there. check its checksum
    ref_checksum=$(grep $dest checksums.${type}.txt | cut -d ' ' -f 1)
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
