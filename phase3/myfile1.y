%{
#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.c"
#include<ctype.h>

#define KRED  "\x1B[31m"
#define KGRN  "\x1B[32m"
#define KBLU  "\x1B[34m"
#define KYEL  "\x1B[33m"
#define KNRM  "\x1B[0m"

extern line_number;
extern char printf_str[100];
extern char identifier_name[50];
extern int symbol_table_length;
extern char type[30][10];
extern char for_spe[30];
extern char value[30][100];
extern char name[30][10];
extern int line_num[30];
char type_spe_arr[20];
extern char* yytext;
int type_spe_arr_index = 0;
%}
%token ID NUM DO WHILE IF ELSE LE GE EQ NE OR AND PRINTF INT FLOAT CHAR SPACE
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'
%%
S : ST1 {/*printf("END\n");*/};

ST1    :    DO OCB ST CCB WHILE ONB E2 CNB TER_SEMI;

OCB : '{' {;}
	|  {printf("%s{\tmissing\tat line num: %d\n",KRED, line_number); printf("%s", KNRM);}
	;
CCB : '}' {;}
	|  {printf("%s}\tmissing\tat line num: %d\n",KRED, line_number);printf("%s", KNRM);}
	;
ONB : '(' {;}
	|  {printf("%s(\tmissing\tat line num: %d\n",KRED, line_number);printf("%s", KNRM);}
	;
CNB : ')' {;}
	|  {printf("%s)\tmissing\tat line num: %d\n",KRED, line_number);printf("%s", KNRM);}
	;
TER_SEMI : ';' {;}
		 |  {printf("%sterminating ;\tmissing\tat line num: %d\n",KRED, line_number-1);printf("%s", KNRM);}
		 ;

ST      :     ST ST
          | E';' {;}
		  | PRINTF	{
		  				//printf("**%s**", yytext);
		  				//printf("Yolo!");
		  				//printf("****%s***", printf_str);
						int i = 0;
						int j = 0;
						int sym_ind = 0;
						int arr_ind = 0;
						char temp_name[100];
						while(printf_str[i]!=',') {
							if(printf_str[i]=='%') {
								type_spe_arr[type_spe_arr_index++] = printf_str[i+1];
								i++;
							}
							i++;
						}
						//i = 0;
						while(printf_str[i]!=')') {
							if(printf_str[i] == ',') {
								i++;
								temp_name[0] = printf_str[i++];
								temp_name[1] = printf_str[i++];
								temp_name[2] = '\0';

								//printf("%s ", temp_name);
								for(sym_ind = 0; sym_ind < symbol_table_length; ++sym_ind){
									if(strcmp(temp_name, name[sym_ind]) == 0) {
										if(type_spe_arr[arr_ind] != for_spe[sym_ind]) {
										printf("%sFormat error expected %%%c in Line_numer = %d\n", KRED, for_spe[sym_ind], line_number);
										printf("%s", KNRM);
										}
									}
								}
								arr_ind++;
								i--;
							}
							else {
								//printf("%c", printf_str[i]);
								}
							i++;
						}
					}
          | E {printf("%smissing ;\tat line num: %d\n", KRED, line_number-1); printf("%s", KNRM);}
          ;
E       : ID'='E
         | E'+'E
         | E'-'E
         | E'*'E
         | E'/'E
         | E'<'E
         | E'>'E
         | E LE E
         | E GE E
         | E EQ E
         | E NE E
         | E OR E
         | E AND E
         | ID
         | NUM
         ;
E2     : E'<'E
         | E'>'E
         | E LE E
         | E GE E
         | E EQ E
         | E NE E
         | E OR E
         | E AND E
         | ID
         | NUM
         ;

%%


int main(int argc, char** argv)
{
	//printf("Enter the exp: \n");
	//printf("Yolo!\n");
	yyin=fopen("input.c","r");
	yyparse();
	printf("\nSymbol table: \n");
	for(i = 0; i< symbol_table_length; ++i){
		printf("%s%s\t\t%c\t\t%s\t\t%s\t\t%d\n",KYEL, type[i], for_spe[i],name[i], value[i], line_num[i] );
	}
	printf("%s", KNRM);
	return 0;
}
