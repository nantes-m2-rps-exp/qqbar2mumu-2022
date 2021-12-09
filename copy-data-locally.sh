runlist=${1:-run.list}
out=${2:-curl.config.txt}

rm $out
mkdir -p data

for run in $(cat $runlist | tr "," " "); do
  src="https://cernbox.cern.ch/index.php/s/r7VFXonK39smzKP/download?path=${run}/AnalysisResults.root"
  dest="data/run${run}.data.root"
  echo url = \"$src\" >> $out
  echo output = \"$dest\" >> $out
done

time curl -Z -# -K $out

rm $out
