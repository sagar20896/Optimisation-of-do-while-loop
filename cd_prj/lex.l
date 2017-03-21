%{
#include <stdio.h>
#include "y.tab.h"
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
{SINGLECOMMENT}				{printf("%s\n",yytext);return SINGLE_COMMENT;}
{MULTICOMMENT}				{printf("%s\n",yytext);return MULTI_COMMENT;}
{BREAK}						{return BREAK_KEYWORD;}
{RETURN}					{return RETURN_KEYWORD;}
{VOID}						{return VOID_KEYWORD;}
{FLOAT}						{return FLOAT_KEYWORD;}
{CHAR}						{return CHAR_KEYWORD;}
{WHILE}						{return WHILE_KEYWORD;}
{INT}						{return INT_KEYWORD;}
{DOUBLE}					{return DOUBLE_KEYWORD;}
{ID}						{return IDENTIFIER;}
[ \t\n\v]					;/* Ignore blank spaces */
{INTEGER_CONST}				{return INTEGER_CONSTANT;}
{FLOAT_CONST}				{return FLOAT_CONSTANT;}
{CHAR_CONST}				{return CHAR_CONSTANT;}
{STRING}					{return STRING_LITERAL;}
"++"						{return PLUS_PLUS;}
"--"						{return MINUS_MINUS;}
"<="						{return LESS_EQUAL;}
">="						{return GREATER_EQUAL;}
"=="						{return EQUAL_EQUAL;}
"!="						{return NOT_EQUAL;}
"&&"						{return LOGICAL_AND;}
"||"						{return LOGICAL_OR;}
"*="						{return STAR_EQUAL;}
"/="						{return BY_EQUAL;}
"%="						{return PERCENT_EQUAL;}
"+="						{return PLUS_EQUAL;}
"-="						{return MINUS_EQUAL;}
"("							{return yytext[0];}
")"							{return yytext[0];}
"{"							{return yytext[0];}
"}"							{return yytext[0];}
"&"							{return yytext[0];}
"*"							{return yytext[0];}
"+"							{return yytext[0];}
"-"							{return yytext[0];}
"/"							{return yytext[0];}
"%"							{return yytext[0];}
"<"							{return yytext[0];}
">"							{return yytext[0];}
"|"							{return yytext[0];}
";"							{return yytext[0];}
"="							{return yytext[0];}
","							{return yytext[0];}
%%

