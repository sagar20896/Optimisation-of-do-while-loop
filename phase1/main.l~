%{
#include <stdio.h>
#include <string.h>
#define TYPE_COMMENT 0
#define TYPE_STRING_CONST 1
#define TYPE_KEYWORD 2
#define TYPE_IDENTIFIER 3
#define TYPE_OPERATOR 4
#define TYPE_DIGIT 5
FILE *fd2;

int line_number = 0;
int sym_table_length = 0;
struct sym_table {
	char name[20];
	char value[50];
	int line_number;
}table[100];
%}
%%
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/|\/\/.* {;}
\".*\" {fprintf(yyout,"%s",yytext); installID(TYPE_STRING_CONST, yytext);}
auto|double|if|static|break|else|int|struct|case|enum|long|switch|char|extern|near|typedef|const|float|continue|register|union|unsigned|void|while|default|do|goto|signed|while|signed|unsigned  { fprintf(yyout,"%s",yytext); installID(TYPE_KEYWORD, yytext);}
[a-zA-Z_][a-zA-Z0-9_]* {fprintf(yyout,"%s",yytext); installID(TYPE_IDENTIFIER, yytext);}
\+|=|-|\*|\/|<|>|==|<=|>=|&&|\|\|\(|\)|\{|\}|; {fprintf(yyout,"%s",yytext); installID(TYPE_OPERATOR, yytext);}
[0-9]+[.]?[0-9]* {fprintf(yyout,"%s",yytext); installID(0, yytext); installID(TYPE_DIGIT, yytext);}
\n {++line_number;fprintf(yyout,"%s",yytext);}
. {fprintf(yyout,"%s",yytext);}
%%
int installID (int type, char* tmp_yytext){
	switch (type) {
		case 1:
			strcpy (table[sym_table_length].name, "STRING CONSTANT");		
			strcpy (table[sym_table_length].value, tmp_yytext);
			table[sym_table_length].line_number = line_number;							 
			break;
		case 2:
			strcpy (table[sym_table_length].name, "KEYWORD");		
			strcpy (table[sym_table_length].value, tmp_yytext);
			table[sym_table_length].line_number = line_number;
			break;
		case 3:
			strcpy (table[sym_table_length].name, "IDENTIFIER");		
			strcpy (table[sym_table_length].value, tmp_yytext);
			table[sym_table_length].line_number = line_number;
			break;
		case 4:
			strcpy (table[sym_table_length].name, "OPERATOR");		
			strcpy (table[sym_table_length].value, tmp_yytext);
			table[sym_table_length].line_number = line_number;
			break;
		case 5:
			strcpy (table[sym_table_length].name, "DIGIT");		
			strcpy (table[sym_table_length].value, tmp_yytext);
			table[sym_table_length].line_number = line_number;
			break;
	}
	sym_table_length++;
}
int main(int argc, char *argv[10])
{
	sym_table_length = 0;
	line_number = 1;
	
	yyin = fopen(argv[1],"r");

	yyout = fopen(argv[2],"w");
	//{ fprintf(myfd, "%s: is a verb", yytext); }

	yylex();

	fclose(yyout);

	int i = 0;
	/*printf("Sr. num\t\t\tName\t\t\tValue\t\t\tLine number");
	printf("\n");
	for (i = 0; i < sym_table_length; ++i) {
		printf("%d\t\t\t%s\t\t\t%s\t\t\t%d", (i+1), table[i].name, table[i].value, table[i].line_number);
		printf("\n");
	}*/
	printf("Sr. num,Name,Value,Line number");
	printf("\n");
	for (i = 0; i < sym_table_length; ++i) {
		printf("%d,%s,%s,%d", (i+1), table[i].name, table[i].value, table[i].line_number);
		printf("\n");
	}	
	return 0;

}
int yywrap()
{
return 1;
}
