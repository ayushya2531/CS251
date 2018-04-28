all:
	make application
	make run_app
	make data
	make plot
	make report

application:
	gcc -I. prog.c thread_function.c -o Application -lm -lpthread

run_app:
	python runtest.py

data:
	python data_structuring.py

plot:
	python plotting.py

report:
	pdflatex rep.tex 

clean:
	rm -f Application
	rm -f *.out
	rm -f *.eps
	rm -f op*.txt
	rm -f *.pdf
	rm -f *.aux
	rm -f *.log
