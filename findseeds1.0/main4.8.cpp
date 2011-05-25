//MFAST Algorithm
//Sriram and Avinash, University of Florida
//ver 4.6 - integrated with shell script
//Sample Usage: ./MFAST treesfile k a freq%

/*
  ->  Input File has a number of trees.
  ->  Each tree is in Newick Format.
  ->  The trees are delimited by a ';' followed by a New Line Character '\n'
  ->  Preprocessing remove all '\r' - Convert from Windows to Unix

*/

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <cstring>
#include <cstdlib>
#include <math.h>
#include <vector>
#include <time.h>


#define max_leaf_no 1000
#define DEBUG

using namespace std;

/*
  Global Declarations
*/

ifstream fin;

ofstream fout;

char filename[50];
char previous_seeds_file[30];
char* knfglobal;

int n,m,k,a,freq,freq_count;
//char k_n_f_seeds_txt[100];

int seed_count = 0;

/*
  Function Declarations
*/

void compute_parameters();

void find_seeds();

void process_pot_seed(char*, int, int, int);

void extract_all_k_subtrees(char *pot_seed, int com_count, int pos, int treecount);

void delete_taxa(char * pot_seed_temp, int i);

void write_to_seeds(char *pot_seed);
void delete_rec(char *str, int a_curr,int i,int com_count,int ncon);
void stringcopy(char*,char*);
void freq_check(char* tree_file, char* seed_file, int, int, int, int ,int);
void freq_pass(char* tree_file, string seed, int frequency1, int frequency2, int frequency3, int frequency4, int frequency5, int& seed_frequency);
bool filter_check(char* tree, char* seed);


  

int main(int argc, char** argv)
{
  
  if(argc != 6 )
    {
      cout<<"\nMain function arguments incorrect! Exiting program!\n";
      cout<<"\nSample Usage: ./a.out treesfile k a freqpc outputfile \n  k = size of seed, a = number of contractions, freq = percentage criterion";
      cout<<endl;
      exit(0);
    }
      
  /*copy command line arguments*/
  strcpy(filename, argv[1]);
  k    = atoi(argv[2]);
  a    = atoi(argv[3]);
  freq = atoi(argv[4]);
  
  fin.open(filename);
  if(!fin)
    {
      cout<<"\nPlease check if the file is present. Error Opening Input File.";
      return 1;
    }

  fin.close();
  clock_t start = clock();
  compute_parameters();
  char* k_n_f_seeds_txt = argv[5];
  knfglobal = k_n_f_seeds_txt;
  //char dummy[10];
  //strcat(k_n_f_seeds_txt, argv[1]);
  //sprintf(dummy,"%d",k);
  //strcat(k_n_f_seeds_txt,dummy);
  //strcat(k_n_f_seeds_txt,"_");
  //sprintf(dummy,"%d",a);
  //strcat(k_n_f_seeds_txt,dummy);
  //strcat(k_n_f_seeds_txt,"_");
  //strcat(k_n_f_seeds_txt,"seeds.txt");
  cout<<"\n\nExtracting Seeds...";
  find_seeds();  
  clock_t end = clock();
  cout<<"\nDone!";
  cout<<"\n\nNumber of Seeds\t"<<seed_count;
  cout<<"\nSeeds file\t"<<k_n_f_seeds_txt;
  double seconds = (double)(end - start )/CLOCKS_PER_SEC;
  cout<<"\nTotal time taken "<<seconds<<" seconds\n";
  return 0;
}

/*
  Function Definitions
*/

void compute_parameters()
{
  ifstream fin_c(filename);
  char ch;
  int coma_count=0;

  while(!fin_c.eof())
    {
      fin_c.get(ch);
      if(ch==';')
	break;
      else if(ch==',')
	coma_count++;
    }

  n=coma_count+1;

  fin_c.close();

  fin_c.open(filename);
  char ch1;
  int semicolon_count=0;
  while(!fin_c.eof())
    {
      fin_c.get(ch1);
      if(ch1==';' && !fin_c.eof())
	semicolon_count++;
    }

  m=semicolon_count;

  cout<<endl<<"Trees\t"<<m;
  cout<<endl<<"Taxa\t"<<n;
  fin_c.close();
}


void find_seeds()
{
  
  
  fout.open(knfglobal);
  fin.open(filename);
  fout<<m<<endl;
  for(int treecount=0;treecount<m;treecount++)
    {
      char *tree=(char *)malloc(10000 * sizeof(char));
      fin.getline(tree,10000);

      for(int pos=0;pos<strlen(tree);pos++)
        {
	  char *pot_seed=(char*)malloc(10000 * sizeof(char));

	  int br_count=0, j=0, flag=0, com_count=0;

	  for(int current_pos=pos;current_pos<strlen(tree);current_pos++)
            {
	      if(tree[current_pos]=='(')
		br_count++;
	      else if(tree[current_pos]==')')
		br_count--;
	      else if(br_count==0 || br_count<0)
		break;

	      if(br_count>=k+a)
                {
		  flag=1;
		  break;
                }

	      if(tree[current_pos]!=' ')
                {
		  if(tree[current_pos]==',')
		    com_count++;

		  pot_seed[j]=tree[current_pos];
		  j++;
                }

	      if(br_count==0)
                {
		  flag=2;
		  break;
                }
            }

	  if(flag==2 && com_count>k-2 && com_count<k+a)
            {
	      pot_seed[j]='\0';
	      process_pot_seed(pot_seed,com_count,pos,treecount);
            }

	  free(pot_seed);

        }

      free(tree);
    }

  fout.close();
  fin.close();
}

void process_pot_seed(char *pot_seed,int com_count, int pos, int treecount)
{
  if(com_count>k-1)
    extract_all_k_subtrees(pot_seed, com_count, pos, treecount);
  else
    write_to_seeds(pot_seed);
}

void extract_all_k_subtrees(char *pot_seed, int com_count, int pos, int treecount)
{
  int ncon=com_count+1-k;

  char *pot_seed_temp=(char*)malloc(10000 * sizeof(char));
  strcpy(pot_seed_temp,pot_seed);

  if(ncon==1)                                                                 // a=1
    {
      for(int i=0;i<com_count+1;i++)
        {
	  strcpy(pot_seed_temp,pot_seed);
	  delete_taxa(pot_seed_temp,i);
	  write_to_seeds(pot_seed_temp);

        }
    }

  else
    {
      int a_curr;
      for(int i=0;i<=(com_count+1-ncon);i++)
        {
	  a_curr=1;
	  strcpy(pot_seed_temp,pot_seed);
	  delete_taxa(pot_seed_temp,i);
	  delete_rec(pot_seed_temp,a_curr,i,com_count,ncon);
        }
    }



  free(pot_seed_temp);
}

void write_to_seeds(char *pot_seed)
{

  static long int seed_no=1;
  ifstream fcheckin(knfglobal);
  int len=strlen(pot_seed);
  pot_seed[len]=';';
  len++;
  pot_seed[len]='\0';
  int present=0;

  while(!(fcheckin.eof()==1))
    {
      char extract[10000];
      fcheckin>>extract;
      if(strcmp(extract,pot_seed)==0)
        {
	  present=1;
	  break;
        }
    }

  if(present==0)
    {
      fout<<pot_seed<<endl;
      seed_count++;
    }

  fcheckin.close();
}

void delete_taxa(char *str, int i)
{
    int com_c=0;

    if(i==0)
    {
        int j;
        for(j=0;j<(strlen(str));j++)
        {
            if(str[j]==',')
            {
                com_c++;
                break;
            }
        }

        int k=j+1;

        for(;j>=0;j--)
        {
            if(str[j]=='(')
            {
                str[j]='`';
                break;
            }

            str[j]='`';
        }

        int bracket_c=-1,flag=0;

        for(;k<(strlen(str));k++)
        {
            if(str[k]=='(')
            {
                bracket_c++;
                flag=1;
            }

            else if(str[k]==')')
            {
                bracket_c--;
                flag=1;
            }

            if(bracket_c<-1 && flag==1)
                break;
        }

        str[k]='`';
    }
    
    else
    {
        int j;

        for(j=0;j<strlen(str);j++)
        {
            if(str[j]==',')
                com_c++;

            if(com_c==i)
                break;

        }

        int temp_j=j;

        if(str[j+1]!='(')
       {
        str[j]='`';
        j++;

        for(;j<strlen(str);j++)
        {
            if(str[j]!='(' && str[j]!=')' && str[j]!='`' && str[j]!=',')
                break;
        }

        int bracket_c=-1,flag=0;

        int k=j+1;
        int l=j-1;

        for(;j<strlen(str);j++)
        {
            if(str[j]==',' || str[j]==')')
                break;
            str[j]='`';
        }

        for(;k<(strlen(str));k++)
        {
            if(str[k]=='(')
            {
                bracket_c++;
                flag=1;
            }

            else if(str[k]==')')
            {
                bracket_c--;
                flag=1;
            }

            if(bracket_c<-1 && flag==1)

                break;
        }

        str[k]='`';

        bracket_c=-1;
        flag=0;

        for(;l>=0;l--)
        {
            if(str[l]==')')
            {
                bracket_c++;
                flag=1;
            }

            else if(str[l]=='(')
            {
                bracket_c--;
                flag=1;
            }

            if(bracket_c<-1 && flag==1)
                break;
        }

        str[l]='`';
       }
       else
       {
			j++;
			for(;j<strlen(str);j++)
				if(str[j]==',') break;
			
			int temp_j=j;
			
			str[j]='`';
			
			for(;j>=0;j--)
			{
				if(str[j]=='(')
					{
						str[j]='`';
						break;
					}
					
				str[j]='`';
			}
			
			int k=temp_j+1;
			
			int bracket_c=-1,flag=0;

			for(;k<(strlen(str));k++)
			{
				if(str[k]=='(')
				{
					bracket_c++;
					flag=1;
				}

				else if(str[k]==')')
				{
					bracket_c--;
					flag=1;
				}

				if(bracket_c<-1 && flag==1)
					break;
			}

			str[k]='`';
			          
       }
    }




//        if(pot_seed_temp[k]=='(')
//        {
//            pot_seed_temp[j]='`';
//            j++;
//            for(;j<strlen(pot_seed_temp);j++)
//            {
//                if(pot_seed_temp[j]==',')
//                {
//                    break;
//                }
//                pot_seed_temp[j]='`';
//            }
//
//            k=j+1;
//
//            int bracket_c=-1,flag=0;
//
//            for(;k<(strlen(pot_seed_temp));k++)
//            {
//                if(pot_seed_temp[k]=='(')
//                {
//                    bracket_c++;
//                    flag=1;
//                }
//
//                else if(pot_seed_temp[k]==')')
//                {
//                    bracket_c--;
//                    flag=1;
//                }
//
//                if(bracket_c<=-1 && flag==1)
//                    break;
//            }
//
//            pot_seed_temp[k]='`';
//        }
//
//        else
//        {
//
//            k=j-1;
//
//            for(;j<strlen(pot_seed_temp);j++)
//            {
//                if(pot_seed_temp[j]==')')
//                {
//                    pot_seed_temp[j]='`';
//                    break;
//                }
//                pot_seed_temp[j]='`';
//            }
//
//            for(;k>=0;k--)
//            {
//                if(pot_seed_temp[k]=='(')
//                {
//                    pot_seed_temp[k]='`';
//                    break;
//                }
//
//            }
//        }

//    }

    char *pot_seed_temp_temp=(char*)malloc(10000 * sizeof(char));

    int r=0;
    for(int q=0;q<strlen(str);q++)
    {
        if(str[q]!='`')
        {
            pot_seed_temp_temp[r]=str[q];
            r++;
        }
    }
    pot_seed_temp_temp[r]='\0';

    strcpy(str,pot_seed_temp_temp);
    

    free(pot_seed_temp_temp);
}



void delete_rec(char *str, int a_curr,int i,int com_count,int ncon)
{
  a_curr++;
  for(int j=0,k=i;k<=(com_count+1-ncon);j++,k++)
    {
      char *pot_seed_temp_1=(char*)malloc(10000 * sizeof(char));
      strcpy(pot_seed_temp_1,str);
      delete_taxa(pot_seed_temp_1,k);
      if(a_curr==ncon)
	write_to_seeds(pot_seed_temp_1);
      else
        {
	  delete_rec(pot_seed_temp_1,a_curr,k,com_count,ncon);
        }

      free(pot_seed_temp_1);
    }

}

