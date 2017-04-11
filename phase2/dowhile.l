%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

int line_number = 1;
char printf_str[100];
char identifier_name[50];
int symbol_table_length = 0;
int i = 0;
int j = 0;
char type[30][10];
char name[30][10];
char value[30][100];
int line_num[30];
char for_spe[30];
%}
alpha [A-Za-z]
digit [0-9]
id [a-zA-Z][a-zA-Z0-9]*
a "%d "|"%f "|"%c "|"%s "
%%
[ \t]
[' ']   return SPACE;
do    return DO;
while    return WHILE;
int[' '][a-zA-Z][a-zA-Z0-9]*['=']{digit}*; {
                            strcpy(type[symbol_table_length], "int");
                            //strcpy(name[symbol_table_length], yytext);
                            for(i = 4; yytext[i]!='='; ++i)
                                name[symbol_table_length][j++] = yytext[i];
                            while(yytext[i]!='\0') {
                                if(yytext[i] == '='){
                                    j = 0;
                                    i++;
                                    for(;yytext[i]!=';'; ++i)
                                        value[symbol_table_length][j++] = yytext[i];
                                    break;
                                }
                            }
                            for_spe[symbol_table_length] = 'd';
                            line_num[symbol_table_length] = line_number;
                            symbol_table_length++;}
float[' '][a-zA-Z][a-zA-Z0-9]*['=']{digit}*\.{digit}*; {
                            strcpy(type[symbol_table_length], "float");
                            //strcpy(name[symbol_table_length], yytext);
                            j = 0;
                            for(i = 6; yytext[i]!='='; ++i)
                                name[symbol_table_length][j++] = yytext[i];
                                while(yytext[i]!='\0') {
                                    if(yytext[i] == '='){
                                        j = 0;
                                        i++;
                                        for(;yytext[i]!=';'; ++i)
                                            value[symbol_table_length][j++] = yytext[i];
                                        break;
                                    }
                                }
                                for_spe[symbol_table_length]= 'f';
                            line_num[symbol_table_length] = line_number;
                            symbol_table_length++;}
char[' '][a-zA-Z][a-zA-Z0-9]*['=']['\''][a-zA-z]['\'']; {
                            strcpy(type[symbol_table_length], "char");
                            //strcpy(name[symbol_table_length], yytext);
                            j = 0;
                            for(i = 5; yytext[i]!='='; ++i)
                                name[symbol_table_length][j++] = yytext[i];
                                while(yytext[i]!='\0') {
                                    if(yytext[i] == '='){
                                        j = 0;
                                        i++;
                                        for(;yytext[i]!=';'; ++i)
                                            value[symbol_table_length][j++] = yytext[i];
                                        break;
                                    }
                                }
                                for_spe[symbol_table_length] = 'c';
                            line_num[symbol_table_length] = line_number;
                            symbol_table_length++;}
float return FLOAT;
char return CHAR;
printf\(\"{a}*\"(,{id})*\);  { strcpy(printf_str, yytext); /*printf("%s", printf_str);*/ return PRINTF;}
if return IF;
else return ELSE;
{digit}+    {yylval=atoi(yytext);return NUM;}
{alpha}({alpha}|{digit})*    { strcpy(identifier_name, yytext); return ID;}
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
"||"    return OR;
"&&"    return AND;
\n {++line_number;}
.    return yytext[0];
%%
