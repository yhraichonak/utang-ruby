while read p; do
  mkdir -p "features_run/$(dirname $p)" && cp $p "features_run/$p"
done <tr_exec_candidates.txt
