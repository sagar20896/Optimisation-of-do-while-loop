%{
#include <stdio.h>
#define TYPE_COMMENT 0
#define TYPE_STRING_CONST 1
#define TYPE_KEYWORD 2
#define TYPE_IDENTIFIER 3
#define TYPE_OPERATORS 4
#define TYPE_DIGIT 5
FILE *fd2;
int flag = 0;

struct sym_table {
	char type[20];
	char name[20];
	char value[50];
	int line_number;
}table[100];
%}
%%
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/|\/\/.* {fprintf(yyout,"%s","");}
\".*\" {printf("string = %s\n", yytext);fprintf(yyout,"%s",yytext);}
auto|double|if|static|break|else|int|struct|case|enum|long|switch|char|extern|near|typedef|const|float|continue|register|union|unsigned|void|while|default|do|goto|signed|while|signed|unsigned  {printf("keyword : %s\n", yytext); fprintf(yyout,"%s",yytext); fprintf(yyout,"%s","");}
[a-zA-Z_][a-zA-Z0-9_]* {printf("identifier: %s\n", yytext); fprintf(yyout,"%s",yytext);}
\+|=|-|\*|\/|<|>|==|<=|>=|&&|\|\|\(|\)|\{|\}|; {printf("operators: %s\n", yytext); fprintf(yyout,"%s",yytext);}
[0-9]+[.]?[0-9]* {printf("digit: %s\n", yytext); fprintf(yyout,"%s",yytext); installID(0, yytext);}
. {fprintf(yyout,"%s",yytext);}
%%
int installID (int type, char* tmp_yytext){
	printf("****%s***",tmp_yytext);
}
int main(int argc, char *argv[10])
{

	yyin = fopen(argv[1],"r");

	yyout = fopen(argv[2],"w");
	//{ fprintf(myfd, "%s: is a verb", yytext); }

	yylex();

	fclose(yyout);

	return 0;

}
int yywrap()
{
return 1;
}
