%{
#include <stdio.h>
#include<string.h>
#include "y.tab.h"
#include "mywrapper.h"
char* prev = "";
//global scope -1
int scope = -1;//local scope
int parent_scope = -2;
extern int lineno;
%}
WHILE			  			"while"
BREAK			  			"break"
INT				  			"int"
DOUBLE						"double"
RETURN						"return"
VOID			  			"void"
FLOAT			  			"float"
CHAR			  			"char"

ID					    [_a-zA-Z][_a-zA-Z0-9]*
INTEGER_CONST			([1-9][0-9]*)|"0"
FLOAT_CONST				(((([0-9]+)?\.[0-9]+)|([0-9]+\.))([eE][+-]?[0-9]+)?)|([0-9]+[eE][+-]?[0-9]+)
CHAR_CONST				\'(([^\'\\\n]|[\\a\\b\\f\\n\\r\\t\\v\\\'\\\"\\?\\\\])+)\'
STRING				  	\"(([^\"\\\n]|[\\a\\b\\f\\n\\r\\t\\v\\\'\\\"\\?\\\\])*)\"
MULTICOMMENT			\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/|\/\/.*
SINGLECOMMENT			"//".*


%%
{SINGLECOMMENT}				{return SINGLE_COMMENT;}
{MULTICOMMENT}		{return MULTI_COMMENT;}
{BREAK}						{Initialize_id(yytext,"KW",0,NULL,lineno,"",scope);  return BREAK_KEYWORD;}
{RETURN}					{ Initialize_id(yytext,"KW",0,NULL,lineno,"",scope); return RETURN_KEYWORD;}
{VOID}						{ Initialize_id(yytext,"KW",0,NULL,lineno,"",scope); return VOID_KEYWORD;}
{FLOAT}						{ prev = "float";Initialize_id(yytext,"KW",0,NULL,lineno,"",scope); return FLOAT_KEYWORD;}
{CHAR}						{ prev = "char";Initialize_id(yytext,"KW",0,NULL,lineno,"",scope); return CHAR_KEYWORD;}
{WHILE}						{ Initialize_id(yytext,"KW",0,NULL,lineno,"",scope); return WHILE_KEYWORD;}
{INT}						{ prev = "int";Initialize_id(yytext,"KW",0,NULL,lineno,"",scope); return INT_KEYWORD;}
{DOUBLE}				{ prev = "double";Initialize_id(yytext,"KW",0,NULL,lineno,"",scope); return DOUBLE_KEYWORD;}
{ID}						{  
                                if(installID(yytext))
                                 {
                                    Initialize_id(yytext,"KW",0,NULL,lineno,prev,scope);
									//printf("type:%s\n",prev);
                                 }
                
                                 else
                                 {  
                                    Initialize_id(yytext,"ID",0,NULL,lineno,prev,scope);
									//printf("type:%s\n",prev);
                                 }
                                return IDENTIFIER;
                                
                                
                                
                            }
[ \t\v]					;/* Ignore blank spaces */
(\n)                    { ++lineno; }
{INTEGER_CONST}				{ Initialize_num(yytext,"INTEGER_CONST",lineno);  return INTEGER_CONSTANT;}
{FLOAT_CONST}				{ Initialize_num(yytext,"FLOAT_CONST",lineno); return FLOAT_CONSTANT;}
{CHAR_CONST}				{ Initialize_num(yytext,"CHAR_CONST",lineno); return CHAR_CONSTANT;}
{STRING}					{ Initialize_num(yytext,"STRING_LITERAL",lineno); return STRING_LITERAL;}
"++"						{ Initialize_op(yytext,"INC",lineno); return PLUS_PLUS;}
"--"						{ Initialize_op(yytext,"DEC",lineno); return MINUS_MINUS;}
"<="						{ Initialize_op(yytext,"LE",lineno); return LESS_EQUAL;}
">="						{ Initialize_op(yytext,"GE",lineno); return GREATER_EQUAL;}
"=="						{ Initialize_op(yytext,"EQ",lineno); return EQUAL_EQUAL;}
"!="						{ Initialize_op(yytext,"NE",lineno); return NOT_EQUAL;}
"&&"						{ Initialize_op(yytext,"AND",lineno); return LOGICAL_AND;}
"||"						{ Initialize_op(yytext,"OR",lineno); return LOGICAL_OR;}
"*="						{ Initialize_op(yytext,"SH_MUL",lineno); return STAR_EQUAL;}
"/="						{ Initialize_op(yytext,"SH_DIV",lineno); return BY_EQUAL;}
"%="						{ Initialize_op(yytext,"SH_REM",lineno); return PERCENT_EQUAL;}
"+="						{ Initialize_op(yytext,"SH_PLUS",lineno); return PLUS_EQUAL;}
"-="						{ Initialize_op(yytext,"SH_MINUS",lineno); return MINUS_EQUAL;}
"("							{ Initialize_sym(yytext,"O_BRACE",lineno);  return yytext[0];}
")"							{ Initialize_sym(yytext,"C_BRACE",lineno); return yytext[0];}
"{"							{ parent_scope = scope;++scope;Initialize_sym(yytext,"O_CURLY",lineno); return yytext[0];}
"}"							{ --scope;parent_scope = scope - 1; Initialize_sym(yytext,"C_CURLY",lineno); return yytext[0];}
"&"							{ Initialize_op(yytext,"BIT_AND",lineno); return yytext[0];}
"*"							{ Initialize_op(yytext,"MUL",lineno); return yytext[0];}
"+"							{ Initialize_op(yytext,"PLUS",lineno); return yytext[0];}
"-"							{ Initialize_op(yytext,"MINUS",lineno); return yytext[0];}
"/"							{ Initialize_op(yytext,"INC",lineno); return yytext[0];}
"%"							{ Initialize_op(yytext,"REMAINDER",lineno); return yytext[0];}
"<"							{ Initialize_op(yytext,"LT",lineno); return yytext[0];}
">"							{ Initialize_op(yytext,"GT",lineno); return yytext[0];}
"|"							{ Initialize_op(yytext,"BIT_OR",lineno);return yytext[0];}
";"							{ return yytext[0];}
"="							{ Initialize_op(yytext,"ASSIGN",lineno); return yytext[0];}
","							{return yytext[0];}
%%
/*
int main()
{
	yylex();
cout<<"--------------------------------------------------"<<"\n";
cout<<"|name|"<<"\t\t"<<"|tokenname|"<<"\t\t"<<"| lineno |"<<"\n";
cout<<"--------------------------------------------------"<<"\n";
display(begin(st),end(st));
}*/

