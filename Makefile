
all:
	( tail -n +2 paciens_szemantikus.csv ; tail -n +2 kontroll_szemantikus.csv ) | sed "s/ /_/g" | wordperline | sed "s/_$$//;s/^_//" | grep -v "^$$" | sstat | sstat2tsv > animals_fluency_freqlist.csv
	cat animals_fluency_freqlist.csv | cols 2 | tr '\n' '|' | sed "s/|$$//;s/^|//" > animals_fluency_freqlist.egrep_pattern
	scpo animals_fluency_freqlist.egrep_pattern
	ssh oliphant.nytud.hu 'PTN=`cat tmp/animals_fluency_freqlist.egrep_pattern` ; zcat /store/share/resources/freqs/hnc1.3/lemmafreq/hnc-1.3-region-sum-lemmafreq.txt.gz | recode l2..u8 | grep "	N	" | cols 1,8 | egrep -x "($$PTN)	[0-9]*"' > animals_mnsz_freqlist.csv

