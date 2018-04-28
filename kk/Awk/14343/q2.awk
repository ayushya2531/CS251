BEGIN {
    FS=","
    CN=1
}
{
    split($1, IP_DATA, " ")
    t = IP_DATA[1]
    s = IP_DATA[3]
    r = substr(IP_DATA[5], 1, length(IP_DATA[5])-1)

    split(t, time, ":")
    T = time[1]*3600+time[2]*60+time[3]

    if(!TCP[s,r] && !TCP[r,s]) {
        TCP[s,r]=CN
        A[CN]=s
        B[CN]=r
        A[CN+1]=r
        B[CN+1]=s
        TCP[r,s]=CN+1
        apcount[CN]=0
        apcount[CN+1]=0
        dpcount[CN]=0
        dpcount[CN+1]=0
        len[CN]=0
        len[CN+1]=0
        retrans[CN]=0
        retrans[CN+1]=0
        stime[TCP[s,r]]=T
        CN=CN+2
    }

    active_tcp = TCP[s,r]
    apcount[active_tcp]=apcount[active_tcp]+1

    etime[active_tcp] = T

    split($NF, x, " ")
    if(x[2] != 0) {
        dpcount[active_tcp]=dpcount[active_tcp]+1
        len[active_tcp]=len[active_tcp]+x[2]

        #split($2, temp, " ")
        #seq = temp[2]
        #split(seq, seqdata, ":")
        #seq1 = seqdata[1]
        #seq2 = seqdata[2]
    }
}
END {
    for(i=1;i<CN;i=i+2){
        split(A[i], a1, ".")
        split(B[i], b1, ".")
        print "Connection (A=" a1[1]"."a1[2]"."a1[3]"."a1[4]":"a1[5] " B=" b1[1]"."b1[2]"."b1[3]"."b1[4]":"b1[5] ")"
        tp1 = len[i]/(etime[i]-stime[i])
        print "A-->B" " #packets=" apcount[i] ", #datapackets=" dpcount[i] ", #bytes=" len[i] ", #retrans=" retrans[i] " xput=" tp1 " bytes/sec"
        tp2 = len[i+1]/(etime[i+1]-stime[i+1])
        print "B-->A" " #packets=" apcount[i+1] ", #datapackets=" dpcount[i+1] ", #bytes=" len[i+1] ", #retrans=" retrans[i+1] " xput=" tp2 " bytes/sec"
        print ""
    }
}
