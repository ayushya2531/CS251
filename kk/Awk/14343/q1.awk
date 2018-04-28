BEGIN {
    FS = "\""

    comments = 0
    strings = 0

    in_multi_comment = 0
}
{
    #print $0
    in_string = 0
    multi_comment_end_in_line = 0
    i = 1
    while (i <= NF) {
        str = $i
        i = i + 1
        if (!in_multi_comment && !in_string && match(str, "//")) {
            #print "single comment"
            #print NR
            if (!multi_comment_end_in_line) {
                comments = comments + 1
            }
            break
        }
        if (!in_string && !in_multi_comment && match(str, "/(*)")) {
            #print "multi comment start"
            #print NR
            in_multi_comment = 1
            lastNR = NR
        }
        if (!in_string && in_multi_comment && match(str, "(*)/")) {
            #print "multi comment end"
            #print NR
            in_multi_comment = 0
            if (!multi_comment_end_in_line) {
                comments = comments + NR - lastNR + 1
            }
            #print "count: "comments
            multi_comment_end_in_line = 1
            #print match(str, "(*)/")
            str = substr(str, match(str, "(*)/")+2, length(str))
            str = gensub("(/(*).*(*)/)*", "", "g", str)
            #print str
            if (!in_multi_comment && !in_string && match(str, "//")) {
                #print "single comment"
                #print NR
                break
            }
            if (!in_string && !in_multi_comment && match(str, "/(*)")) {
                in_multi_comment = 1
                lastNR = NR + 1
                #print "multi comment start"
                #print NR
            }
        }
        if (!in_multi_comment && in_string && substr(str, length(str), length(str)) == "\\") {
            continue
        }
        if (!in_string && !in_multi_comment) {
            #print "string start"
            #print NR
            in_string = 1
        }
        else if (in_string && !in_multi_comment) {
            #print "string end"
            #print NR
            in_string = 0
            strings = strings + 1
        }
    }
    #print ""
}
END {
    print comments " " strings
}
