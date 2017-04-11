#include <stdio.h>
#include<iostream>
#include <ctype.h>
#include<stdlib.h>
#include<map>
#include<string.h>
#include<algorithm>
#include "mywrapper.h"
#include"y.tab.h"
using namespace std;
int keywords=13;
int lineno=1;
char *keyword[]={"main","int","double","float","for","while","do","if","else","char","void","return","break"};
map<string,Input> st;

int installID(char * in)
{
             int i=0;
             for(i=0;i<keywords;i++)
                {
                if(strcmp(keyword[i],in)==0)
                        return 1;
     
                 }
         return 0;
}
        
       
void Initialize_id(char* name,char* token_name,int value,char* type,int line_no,char*data_type,int scope)//CHAR* data_type  
{  
    Input first;  
    first.type = tokentype::ID;  
    first.id ={token_name,value,type,line_no,data_type,scope};//data_type
    st.insert(pair<string,Input>(name,first));
  
    
}  

void Initialize_op(char* name,char* token_name,int line_no)  
{  
    Input first;  
    first.type = tokentype::OP;  
    first.op ={token_name,line_no};
    st.insert(pair<string,Input>(name,first)); 
}  

void Initialize_sym(char* name,char* token_name,int line_no)  
{  
    Input first;  
    first.type = tokentype::SYM;  
    first.sym ={token_name,line_no};
    st.insert(pair<string,Input>(name,first)); 
}  

void Initialize_num(char* name,char* token_name,int line_no)  
{  
    Input first;  
    first.type = tokentype::NUM;  
    first.num ={token_name,line_no};
    st.insert(pair<string,Input>(name,first)); 
}  

template<typename t>
void disp(t a)
{
   cout<<a.token_name<<"\t\t"<<a.line_no<<"\t\t"<<"\n";
   cout<<"-------------------------------------------------------------------"<<"\n";
}

template<typename t>
void dis_id(t a)
{
   cout<<a.token_name<<"\t\t"<<a.line_no<<"\t\t"<<a.scope<<"\t\t"<<a.data_type<<"\n";
   cout<<"------------------------------------------------------------------"<<"\n";
}

template<typename ptr_t>
void display(ptr_t first, ptr_t last)
{
	while(first != last)
	{   string s=first->first;
	    cout<<first->first<<"\t\t";
		switch ((first->second).type)  
        {  
        case tokentype::ID:  
          //  disp(st[s].id);
		    dis_id(st[s].id);
            break;  
        case tokentype::OP:  
            disp(st[s].op);   
            break; 
        case tokentype::SYM:  
            disp(st[s].sym);  
            break;
        case tokentype::NUM:  
            disp(st[s].num);  
            break;  
        default:  
            break;  
        }  
		++first;
	}
}

int main()
{

	yyparse();
cout<<"-----------------------------------------------------------------------------------------------"<<"\n";
cout<<"|name|"<<"\t\t"<<"|tokenname|"<<"\t\t"<<"| lineno |"<<"\t\t"<<"| scope |""\t\t"<<"| data type |"<<"\n";
cout<<"-----------------------------------------------------------------------------------------------"<<"\n";
display(begin(st),end(st));
	return 0;
}
