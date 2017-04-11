%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* initQuadrple(char* operator,char* arg1,char* arg2);
int line=0;
int eflag=0;
int dflag=0;
int sflag=0;
int rcount=0;
int tcount=0;
int tempq = 0;
int temp_line = 0;
extern FILE *yyin;
typedef struct{
	char* operator;
	char* arg1;
	char* arg2;
	char* result;
} quadrple;
quadrple q[50];
int qcount=0;
%}

%token ID NUM WHILE LE GE EQ NE OR AND TYPE STRING PRINTF	NEWLINE DO
%right "="
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'
%error-verbose
%start S
%union{
	char* st;
}
%type<st> E	ID	NUM	E2	LE	GE	NE	EQ	OR	AND	error	ST	S
%%

S         : ST {if(eflag==0){printf("Input accepted\n");}}
		;
ST       : DO DEF WHILE '(' E ')' ';'  NEWLINE{$$=initQuadrple("if-false",$5,"-");$$=initQuadrple("",$5,"-");}
		 | DO DEF WHILE '(' E2 ')' ';'  NEWLINE{$$=initQuadrple("if-false",$5,"-");$$=initQuadrple("",$5,"-");}
         ;
DEF    : '{' BODY '}'
           | E ';'
           | ST
	   	   | NEWLINE {line+=1;}
           ;
BODY  : BODY BODY
           | E ';'
           | ST
	   	   | NEWLINE {line+=1;}
           |  error ';'
		   |
           ;

E        : ID '=' E {$$=initQuadrple("=",$1,$3);dflag=0;}
          | E '+' E {$$=initQuadrple("+",$1,$3);dflag=0;}
          | E '-' E {$$=initQuadrple("-",$1,$3);dflag=0;}
          | E '*' E {$$=initQuadrple("*",$1,$3);dflag=0;}
          | E '/' E {$$=initQuadrple("/",$1,$3);dflag=0;}
          | E '+' '+' {$$=initQuadrple("++",$1,"-");}
          | E '-' '-' {$$=initQuadrple("--",$1,"-");}
		  | '(' E ')'{$$=$2;}
          | ID  {$$=$1;}
          | NUM {$$=$1;dflag++;}
          | error ';'
          ;


E2     : E'<'E {$$=initQuadrple("<",$1,$3);}
         | E'>'E {$$=initQuadrple(">",$1,$3);}
         | E LE E {$$=initQuadrple($2,$1,$3);}
         | E GE E {$$=initQuadrple($2,$1,$3);}
         | E EQ E {$$=initQuadrple($2,$1,$3);}
         | E NE E {$$=initQuadrple($2,$1,$3);}
         | E OR E {$$=initQuadrple($2,$1,$3);}
         | E AND E {$$=initQuadrple($2,$1,$3);}
         ;

%%

int yyerror(char* s){
	eflag=1;

	printf("Error in %d:%s\n",line+1,s);

	return 0;
}
char* initQuadrple(char* operator,char* arg1,char* arg2){

	char* r=(char*)calloc(10,sizeof(char));
	//printf("IN func %s %s %s %d\n",operator,arg1,arg2,dflag);
	if(dflag==2){
		dflag=0;
		int sarg1=0;
		int stack[10];
		int top=-1;
		int i = 0;
		for(i=0;i<strlen(arg1);i++){
			sarg1*=10;
			sarg1+=(int)(arg1[i])-48;
		}
		int sarg2=0;
		for(i=0;i<strlen(arg2);i++){
			sarg2*=10;
			sarg2+=(int)(arg2[i])-48;
		}
		int sum=sarg1+sarg2;
		do{
			stack[++top]=sum%10;
			sum/=10;
		}while(sum!=0);
		for(i=top;i>=0;i--){
			r[top-i]=(char)(stack[i]+48);
		}
		r[top+1]='\0';
		return r;
	}
	else if(strcmp(operator,"=")==0){
	q[qcount].operator="=";
	q[qcount].arg1=arg2;

	q[qcount].result=arg1;
	q[qcount].arg2="-";

	qcount++;
	return q[qcount-1].result;
	}
	else if(strcmp("++",operator)==0){
	q[qcount].operator="+";
	q[qcount].arg1=arg1;
	q[qcount].arg2="1";
	r[0]='t';
	r[1]=(char)rcount+48;
	r[2]='\0';
	q[qcount].result=r;
	qcount++;
	rcount++;
	q[qcount].operator="=";
	q[qcount].arg1=r;
	q[qcount].arg2="-";

	q[qcount].result=arg1;
	qcount++;
	return q[qcount-1].result;
	}
	else if(strcmp("if-false",operator)==0){
		tempq = qcount;
		char* temp=(char*)calloc(10,sizeof(char));
		sprintf(temp,"%d",line+2);
		q[qcount].operator=operator;
		q[qcount].arg1=temp;
		q[qcount].arg2="-";
		q[qcount].result="goto";
		qcount++;
		return q[qcount-1].result;
	}
	else if(strcmp("",operator)==0){
		temp_line = line+2;
		char* temp=(char*)calloc(10,sizeof(char));
		sprintf(temp,"%d",1);
		q[qcount].operator=operator;
		q[qcount].arg1=temp;
		q[qcount].arg2="-";
		q[qcount].result="goto";
		qcount++;
		return q[qcount-1].result;
	}
	q[qcount].operator=operator;
	q[qcount].arg1=arg1;
	q[qcount].arg2=arg2;
	r[0]='t';
	r[1]=(char)rcount+48;
	r[2]='\0';
	q[qcount].result=r;
	qcount++;
	rcount++;
	dflag=0;



	return r;


}


int main(){

	//printf("Enter the expression:\n");
	yyin = fopen("input.c", "r");
	yyparse();
	sprintf(q[tempq].arg1,"%d",temp_line);
	printf("operator\targ1\t\targ2\t\tresult\n");
	int i=0;
	for(i=0;i<qcount;i++){
			printf("%s\t\t%s\t\t%s\t\t%s\t\t\n",q[i].operator,q[i].arg1,q[i].arg2,q[i].result);
		}
	return 0;

}
