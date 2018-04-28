rm -f output_*.data
for i in $(cat params.txt)
do
	for j in $(cat threads.txt)
	do
		echo "Running test for params = $i and threads = $j"
		for k in `seq 1 100`
		do
			./$1 $i $j >> output_${i}_${j}.data
		done
	done
done
