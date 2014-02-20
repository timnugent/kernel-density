// Kernel density estimation by Tim Nugent (c) 2014

#include <stdlib.h>
#include <stdint.h>
#include <iostream>
#include <vector> 
#include <string> 
#include <sstream> 
#include <fstream>
#include <kde.hpp>

using namespace std;

void usage(const char* prog){

   cout << "Read data from a csv file then perform kernel density estimation:\nUsage:\n" << prog << " [options] <csv_file>" << endl << endl;
   cout << "Options:" << endl;   
   cout << "-k <int>   Kernel type:" << endl;    
   cout << "           1 = Gaussian (default)" << endl;   
   cout << "           2 = Box" << endl;  
   cout << "           3 = Epanechnikov" << endl;     
   cout << "-b <int>   Bandwidth optimisation (Gaussian only):" << endl;   
   cout << "           1 = Default" << endl; 
   cout << "           2 = AMISE optimal, secant method" << endl;    
   cout << "           3 = AMISE optimal, bisection method" << endl; 
   cout << "-p <int>   Calculate:" << endl;
   cout << "           1 = PDF (default)" << endl; 
   cout << "           2 = CDF" << endl;    
   cout << endl; 
 
}

vector<double> split(const string &s, char delim, vector<double> &elems) {
    stringstream ss(s);
    string item;
    while (getline(ss, item, delim)) {
        elems.push_back(atof(item.c_str()));
    }
    return elems;
}

vector<double> split(const string &s, char delim) {
    vector<double> elems;
    split(s, delim, elems);
    return elems;
}

int main(int argc, const char* argv[]){

	KDE* kde = new KDE();
	string output, line;
	int pdf = 1;

    if(argc < 2){
        usage(argv[0]);
        delete kde;
        return(1);
    }else{
        cout << "# called with:       ";
        for(int i = 0; i < argc; i++){
            cout << argv[i] << " ";
            if(string(argv[i]) == "-k" && i < argc-1){
            	kde->set_kernel_type(atoi(argv[i+1]));
            }
            if(string(argv[i]) == "-b" && i < argc-1){
            	kde->set_bandwidth_opt_type(atoi(argv[i+1]));
            }
            if(string(argv[i]) == "-o" && i < argc-1){
            	output = argv[i+1];
            }
            if(string(argv[i]) == "-p" && i < argc-1){
            	pdf = atoi(argv[i+1]);
            }
        }
        cout << endl;
    }    

	ifstream file(argv[argc-1]);
	while(getline(file, line)){
		vector<double> data = split(line,',');
		kde->add_data(data);
	}
	file.close();

	if(kde->get_vars_count() == 1){

		double min_x = kde->get_min(0);
		double max_x = kde->get_max(0);
		double x_increment = (max_x-min_x)/1000.0;
		cout << "# bandwidth var 1: " << kde->get_bandwidth(0) << endl;
		for(double x = min_x; x <= max_x; x += x_increment){
			if(pdf == 1){
				printf("%2.6F,%2.6F\n",x,kde->pdf(x));
			}else{
				printf("%2.6F,%2.6F\n",x,kde->cdf(x));
			}
		}

	}else{

		int nd = 200;
		double min_x = kde->get_min(0);
		double max_x = kde->get_max(0);
		double min_y = kde->get_min(1);
		double max_y = kde->get_max(1);
		double x_increment = (max_x-min_x)/nd;
		double y_increment = (max_y-min_y)/nd;
		double y = min_y;
		double x = min_x;
		cout << "# bandwidth var 1: " << kde->get_bandwidth(0) << endl;
		cout << "# bandwidth var 2: " << kde->get_bandwidth(1) << endl;
		cout << ",";
		for(int i = 0; i < nd; i++, y += y_increment){
			cout << y;
			if(i < nd-1) cout << ",";
		}
		cout << endl;
		for(int i = 0; i < nd; i++, x += x_increment){
			cout << x << ",";
			y = min_y;
			for(int j = 0; j < nd; j++, y += y_increment){
				if(pdf == 1){
					printf("%2.6F",kde->pdf(x,y));
				}else{
					printf("%2.6F",kde->cdf(x,y));
				}
				if(j < nd-1) cout << ",";
			}
			cout << endl;
		}
	}
	delete kde;

	return(0);
}

