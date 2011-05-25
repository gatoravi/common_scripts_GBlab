/* Avinash Ramu, University of Florida
   Program to sort the seeds based on their frequencies  
   Sample usage = ./executable seeds_file 
   
*/




#include<iostream>
#include<string>
#include<cstring>
#include<cstdlib>
#include<fstream>

#define MAXSEEDS 100000
using namespace std;

int main(int argc, char* argv[])
{
  if(argc != 2) {
    cout<<"Incorrect Arguments ! Exiting !\n";
    exit(1);
  }
  char* seed_file = argv[1];
  char frequency_file[200];
  strcpy(frequency_file, seed_file);
  strcat(frequency_file, "_frequencies");
   
  cout<<"Sorting"<<seed_file<<" ";
  cout<<frequency_file<<endl; 
  
  string line;
  string seed[MAXSEEDS];
  int frequency[MAXSEEDS];
  
  //cout<<"\n\nSEED FILES \n";
  ifstream fin1 ( seed_file);
  if (fin1.is_open()) {  
    getline (fin1,line);
    int j=0;
    while ( fin1.good() ){      
      //cout << line << endl;
      seed[j++] = line;
      getline (fin1,line);
    }
    fin1.close();
  }
  
  int k=0;
  //cout<<"\n\nFREQUENCY FILES \n";
  ifstream fin2( frequency_file);
  if (fin2.is_open()) {  
    getline (fin2,line);    
    while ( fin2.good() ){      
      //cout << line;
      frequency[k++] = atoi(line.c_str());
      //cout<<" "<<frequency[k-1]<< endl;
      getline (fin2,line);
    }
    fin2.close();
  }
  
  int seedcount = k;
  //cout<<"\nThe number of seeds is "<<seedcount;
  
  for(int i = 0; i<seedcount; i++) {
    for(int j = 0; j<seedcount-i-1; j++) {    
      if(frequency[j]<frequency[j+1]) {
      
        int temp = frequency[j];           
	frequency[j] = frequency[j+1];
	frequency[j+1] = temp;
	
	string temp2 = seed[j];           
	seed[j] = seed[j+1];
	seed[j+1] = temp2;
      }
    }
  }
  
  ofstream fout1( seed_file);
  ofstream fout2( frequency_file);
  
  for(int i = 0; i<seedcount; i++) {
    //cout<<seed[i]<<" "<<frequency[i]<<endl;
    fout1<<seed[i]<<endl;
    fout2<<frequency[i]<<endl;
    
  }
  
  fout1.close();
  fout2.close();
  

  //cout<<"\n";
  exit(0);

}
