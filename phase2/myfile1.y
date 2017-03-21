%{
#include <stdio.h>
#include <stdlib.h>
%}
%token ID NUM DO WHILE LE GE EQ NE OR AND STR_CONST KEYWORD
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'
%%
S : ST1 {printf("Input accepted.\n");exit(0);};
ST1    :    DO '{' ST '}' WHILE'(' E2 ')'';';
ST      :     ST ST
          | E';'
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

#include "lex.yy.c"

main()
{
   printf("Enter the exp: ");
   yyparse();

   printf("Sr. num\t\t\tName\t\t\tValue\t\t\tLine number");
   printf("\n");
   int i = 0;
   for (i = 0; i < sym_table_length; ++i) {
       printf("%d\t\t\t%s\t\t\t%s\t\t\t%d", (i+1), table[i].name, table[i].value, table[i].line_number);
       printf("\n");
   }
}
