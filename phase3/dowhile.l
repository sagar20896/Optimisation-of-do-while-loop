%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "y.tab.h"
typedef struct {
	char* symbol;
	void* value;
	int lines[1000];
	int lcount;
	int lflag;

} entry;
int count=0;
entry* symbolTable[1000];
char* getLexeme(int len,char* text);
entry* getEntry(char* lex);
int lineNumber=1;
int flag=0;
%}
alpha [A-Za-z]
digit [0-9]

%%
"\/\/"	{if(flag==0) flag=1;} ;
"\/\*" {if(flag==0) flag=1;};
"\*\/" {if(flag==1) flag=0;};
\".[a-zA-z]+.\" { yylval.st=yytext; return STRING;};
"printf" { return PRINTF; }
"int"|"char"|"float"|"double" {return TYPE;}
do         {if(flag==0){entry* e=getEntry("do"); e->symbol="do"; e->lcount=yyleng; e->lines[(e->lcount)++]=lineNumber; if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;} } return DO;}    ;
while         {if(flag==0){entry* e=getEntry("while"); e->symbol="while"; e->lcount=yyleng; e->lines[(e->lcount)++]=lineNumber; if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;} } return WHILE;}    ;
{digit}+    { if(flag==0){entry* e=getEntry(getLexeme(yyleng,yytext)); e->symbol="Num"; e->lines[(e->lcount)++]=lineNumber;  if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;}  return NUM;};
{alpha}({alpha}|{digit})* {if(flag==0){entry* e=getEntry(getLexeme(yyleng,yytext)); e->symbol="ID";e->lines[(e->lcount)++]=lineNumber;  if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;} return ID;};
"<="         {if(flag==0){entry* e=getEntry("<="); e->symbol="relop";e->lines[(e->lcount)++]=lineNumber;if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;} return LE;};
">="         {if(flag==0){entry* e=getEntry(">="); e->symbol="relop"; e->lines[(e->lcount)++]=lineNumber;if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;} return GE;};
"=="         {if(flag==0){entry* e=getEntry("=="); e->symbol="relop";e->lines[(e->lcount)++]=lineNumber;if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;} return EQ;};
"!="          {if(flag==0){entry* e=getEntry("!="); e->symbol="relop"; e->lines[(e->lcount)++]=lineNumber;if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;} return NE;};
"||"           {if(flag==0){entry* e=getEntry("||"); e->symbol="relop";e->lines[(e->lcount)++]=lineNumber;if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;}return OR;};
"&&"          {if(flag==0){entry* e=getEntry("&&"); e->symbol="relop";e->lines[(e->lcount)++]=lineNumber;if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}yylval.st=e->value;} return AND;};
[\t ]		;
[\n]	{if(flag==1) flag=0;lineNumber+=1; return NEWLINE;};
.              {if(flag==0){entry* e=getEntry(getLexeme(yyleng,yytext)); e->symbol=(char*)e->value;e->lines[(e->lcount)++]=lineNumber;  if(e->lflag==0){symbolTable[count++]=e; e->lflag=1;}} return yytext[0];};

%%
int yywrap(){
	return 1;
}
char* getLexeme(int len,char* text){
	char* a=malloc((len+1)*sizeof(char));
	int i = 0;
	for(i=0;i<len;i++){
		a[i]=text[i];
	}
	a[len]='\0';
	return a;

}
entry* getEntry(char* lex){
	int i=0;
	while(i<count && strcmp(lex,symbolTable[i]->value)!=0)
		i++;
	if(i!=count)
		return symbolTable[i];


	entry* e=malloc(sizeof(entry));
	e->value=(char*)lex;
	return e;


}
