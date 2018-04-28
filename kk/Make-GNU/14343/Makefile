all:
	make app
	make runtest
	make analyse
	make plot
	make report

app:
	gcc -I. prog.c thread_function.c -o App -lm -lpthread

runtest:
	chmod +x runtest.sh
	./runtest.sh App

analyse:
	chmod +x analyse.sh
	./analyse.sh

plot:
	chmod +x plot.sh
	./plot.sh

report:
	pdflatex report.tex > /dev/null

clean:
	rm -f App
	rm -f *.data
	rm -f *.eps
	rm -f *.pdf
	rm -f *.aux
	rm -f *.log

