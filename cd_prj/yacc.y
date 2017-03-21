%{
#include <stdio.h>
#include <string.h>
#include<stdlib.h>
extern int yylex();
void yyerror(char* s);
extern int lineno;
%}

%union {
  int intval;
  float floatval;
  char *charval;
}

%token BREAK_KEYWORD;
%token RETURN_KEYWORD;
%token VOID_KEYWORD;
%token FLOAT_KEYWORD;
%token CHAR_KEYWORD;
%token WHILE_KEYWORD;
%token INT_KEYWORD;
%token DOUBLE_KEYWORD;
%token <intval> IDENTIFIER;
%token <intval>  INTEGER_CONSTANT;
%token <floatval> FLOAT_CONSTANT;
%token <charval> CHAR_CONSTANT;
%token <charval> STRING_LITERAL;
%token PLUS_PLUS;
%token MINUS_MINUS;
%token LEFT_SHIFT;
%token RIGHT_SHIFT;
%token LESS_EQUAL;
%token GREATER_EQUAL;
%token EQUAL_EQUAL;
%token NOT_EQUAL;
%token LOGICAL_AND;
%token LOGICAL_OR;
%token STAR_EQUAL;
%token BY_EQUAL;
%token PERCENT_EQUAL;
%token PLUS_EQUAL;
%token MINUS_EQUAL;
%token SINGLE_COMMENT;
%token MULTI_COMMENT;

%%
S	:WHILE_KEYWORD open_p expression close_p statement {printf("String accepted\n");}
	;

expression:expression operator expression 
	{
		switch($2):{
			case '+': {$$ = $1 + $2;printf("hello\n");}
			case '-': $$ = $1 - $2;
			case '*': $$ = $1 - $2;
			case '%': $$ = $1 - $2;
			case '<': if($1 < $2){$$=1}else{$$=0};
			case '>': if($1 > $2){$$=1}else{$$=0};
			case LESS_EQUAL: if($1 <= $2){$$=1}else{$$=0};
			case GREATER_EQUAL: if($1 >= $2){$$=1}else{$$=0};
			case NOT_EQUAL: if($1 != $2){$$=1}else{$$=0};
			case LOGICAL_AND: if($1 && $2){$$=1}else{$$=0};
			case LOGICAL_OR: if($1 || $2){$$=1}else{$$=0};
			case EQUAL_EQUAL: if($1 == $2){$$=1}else{$$=0};
				
		} 	
	}
	| IDENTIFIER
	| constants
	;

constants:INTEGER_CONSTANT
	| FLOAT_CONSTANT
	| CHAR_CONSTANT
	| STRING_LITERAL
	;


operator:'+' {$$ = $1;printf("hello\n");}
	|'-' {$$ = $1}
	|'*' {$$ = $1}
	|'%' {$$ = $1}
	|'<' {$$ = $1}
	|'>' {$$ = $1}
	|LESS_EQUAL {$$ = $1}
	|GREATER_EQUAL {$$ = $1}
	|NOT_EQUAL {$$ = $1}
	|LOGICAL_AND {$$ = $1}
	|LOGICAL_OR {$$ = $1}
	|EQUAL_EQUAL {$$ = $1}
	;

statement:open_f  cmpd_statement close_f 
	| function_statement
	| IDENTIFIER assignment_operator expression semi_colon
	| type_specifier IDENTIFIER assignment_operator expression semi_colon
	;

cmpd_statement:IDENTIFIER assignment_operator expression semi_colon
	| IDENTIFIER assignment_operator expression semi_colon cmpd_statement
	| type_specifier IDENTIFIER assignment_operator expression semi_colon cmpd_statement
	| type_specifier IDENTIFIER assignment_operator expression semi_colon	
	;

type_specifier:CHAR_KEYWORD
	| INT_KEYWORD
	| FLOAT_KEYWORD
	| DOUBLE_KEYWORD
	| VOID_KEYWORD
	;

function_statement:IDENTIFIER open_p identifier_list close_p semi_colon
	;

identifier_list:IDENTIFIER ',' 
	|IDENTIFIER
	;


assignment_operator: '=' {$$ = $1}
	| STAR_EQUAL {$$ *= $1}
	| BY_EQUAL 	{$$ /= $1}
  	| PERCENT_EQUAL {$$ %= $1}
  	| PLUS_EQUAL {$$ += $1}
  	| MINUS_EQUAL {$$ -= $1}
 	;

open_p:'('
	|{printf("ERROR: ( is missing in %d\n",lineno-1);}
	;

open_f:'{'
	|{printf("ERROR: { is missing in %d\n",lineno-1);}
	;

close_p:')'
	|{printf("ERROR: ) is missing in %d\n",lineno-1);}
	;

close_f:'}'
	|{printf("ERROR: } is missing in %d\n",lineno-1);}
	;

semi_colon:';'
	|{printf("ERROR: ; is missing in %d\n",lineno-1);}
	;

%%

void yyerror(char* s) {
	printf("%s", s);
}


