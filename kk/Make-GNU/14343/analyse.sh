rm -f hist_data.data
rm -f line_data.data
rm -f data_*.data

for i in $(cat params.txt)
do
    echo -n "$i" >> hist_data.data 
    echo -n "$i" >> line_data.data 
    for j in $(cat threads.txt)
    do
        echo "Analysing param = $i and threads = $j"
        x=0
        v=0
        count=0
        for k in $(cat output_${i}_${j}.data | cut -d\  -f4)
        do
            echo "$i $k" >> data_${j}.data
            x=$(($x+$k))
            count=$(($count+1))
        done
        y=`echo "$x/$count" | bc -l`
        echo -n " $y" >> line_data.data

        sum=0
        for k in $(cat output_${i}_${j}.data | cut -d\  -f4)
        do
            v=`echo "$y - $k" | bc -l`
            v=`echo "$v * $v" | bc -l`
            sum=`echo "$sum + $v" | bc -l`
        done
        var=`echo "$sum/$count" | bc -l`

        if [ $j -eq 1 ]; then
          divisor=$y  
        fi
        y1=`echo "$y/$divisor" | bc -l`
        echo -n " $y1" >> hist_data.data 
        #echo -n " $var" >> hist_data.data 
    done
    echo "" >> hist_data.data
    echo "" >> line_data.data
done
