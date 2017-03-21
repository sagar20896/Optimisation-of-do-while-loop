%{
#include <stdio.h>
#include <stdlib.h>
#define TYPE_COMMENT 0
#define TYPE_STRING_CONST 1
#define TYPE_KEYWORD 2
#define TYPE_IDENTIFIER 3
#define TYPE_OPERATOR 4
#define TYPE_DIGIT 5

int line_number = 0;
int sym_table_length = 0;
struct sym_table {
	char name[20];
	char value[50];
	int line_number;
}table[100];
%}
alpha [A-Za-z]
digit [0-9]
%%
do    {return DO;}
while    {return WHILE;}
"<="    {return LE;}
">="    {return GE;}
"=="    {return EQ;}
"!="    {return NE;}
"||"    {return OR;}
"&&"    {return AND;}
\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/|\/\/.* {;}
\".*\" {installID(TYPE_STRING_CONST, yytext); return STR_CONST;}
auto|double|if|static|break|else|int|struct|case|enum|long|switch|char|extern|near|typedef|const|float|continue|register|union|unsigned|void|default|goto|signed|while|signed|unsigned  { installID(TYPE_KEYWORD, yytext); return KEYWORD;}
[a-zA-Z_][a-zA-Z0-9_]* {installID(TYPE_IDENTIFIER, yytext); return ID;}
\+|=|-|\*|\/|<|>|==|<=|>=|&&|\|\|\(|\)|\{|\}|; {fprintf(yyout,"%s",yytext); installID(TYPE_OPERATOR, yytext);}
[0-9]+[.]?[0-9]* {installID(TYPE_DIGIT, yytext); return NUM;}
\n {++line_number;fprintf(yyout,"%s",yytext);}
.    {return yytext[0];}
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
