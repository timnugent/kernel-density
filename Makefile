all:
	g++ -Wall -O3 -std=c++11 main.cpp -I. kde.cpp -o kerndens 

clean:
	rm kerndens *.png *.csv

test:
	./kerndens data/univariate.csv > uni_pdf.csv
	./kerndens -p 2 data/univariate.csv > uni_cdf.csv
	./kerndens -b 1 data/multivariate.csv > matrix_default.csv
	./kerndens -b 2 data/multivariate.csv > matrix_optimal.csv
	./kerndens -b 3 data/multivariate.csv > matrix_optimal_safe.csv
	./kerndens -k 2 data/multivariate.csv > matrix_default_box.csv
	./kerndens -k 3 data/multivariate.csv > matrix_default_epa.csv
	./plot.R

