%{
#include"3ac.h"
extern FILE *yyin;
extern int Offset;
extern int TempVariableCount;
extern SymbolTable ST[50];
extern int STTop;
extern Quadraple QP[50];
extern int line;
int Datatypevalue=0;
int LabelStack[50];
int LabelCount=-1;
int LabelStackTop=-1;
void pushStack(int LabelToPush);
int popStack();
%}
%token INT FLOAT CHAR VOID MAIN WHILE IDENTIFIER NUM
%left '+' '-'
%left '*' '/'
%%
START:START STARTDASH;
	|STARTDASH;
	
STARTDASH: VOID MAIN'('')''{'BLOCK'}'		{printf("\nSyntax is Correct\n");printSymbolTable();printQuadraple();};

BLOCK:DECLARATION BLOCK				;
	|WHILEBLOCK BLOCK			;
	|					;

WHILEBLOCK:WHILE'('CONDITION')' 		{
							char temp[50];
							
							LabelCount++;
							sprintf(temp,"%d_xL",LabelCount);
							strcpy(QP[Offset-1].label,temp);	//JBL	//copying Label Count to Previous Result
							pushStack(LabelCount);
							
							addoperator("while");
							
							strcpy(QP[Offset].operand1,QP[Offset-1].result);
							strcpy(QP[Offset].operand2,"FALSE");
											
							LabelCount++;							
							sprintf(temp,"%d_xL",LabelCount);
							strcpy(QP[Offset].result,temp);
							pushStack(LabelCount);			//JOL	//Label count for Jumping out of Loop
							
							Offset++;
						}
						WHILEBLOCKDASH		;

WHILEBLOCKDASH:'{'BLOCK'}'			{
							
							int tempLabelJOL=popStack();	
							int tempLabelJBL=popStack();
							
							char temp[50];
							
							strcpy(QP[Offset].op,"GOTO");
							strcpy(QP[Offset].operand1,"LABEL");
								
							sprintf(temp,"%d_xL",tempLabelJBL);
							strcpy(QP[Offset].result,temp);
							Offset++;
														
							sprintf(temp,"%d_xL",tempLabelJOL);
							strcpy(QP[Offset].label,temp);
							Offset++;
									
						};
CONDITION:EXPRESSION '<' EXPRESSION		{addoperator("<");addoperands();};
	|EXPRESSION '>' EXPRESSION		{addoperator(">");addoperands();};


DECLARATION:DATATYPE IDENTIFIERS ';'		;

	
IDENTIFIERS:IDENTIFIER '=' EXPRESSION ','IDENTIFIERS	{
							ST[$1].value=$3;
							addoperator("=");
							strcpy(QP[Offset].result,ST[$1].symbol);
							if(strcmp(QP[Offset].operand1,"")==0)
							{
								strcpy(QP[Offset].operand1,QP[Offset-1].result);
							}
							Offset++;
						};
	|IDENTIFIER '=' EXPRESSION 		{
							ST[$1].value=$3;
							addoperator("=");
							strcpy(QP[Offset].result,ST[$1].symbol);
							if(strcmp(QP[Offset].operand1,"")==0)
							{
								strcpy(QP[Offset].operand1,QP[Offset-1].result);
							}
							Offset++;
						};

DATATYPE:INT					{Datatypevalue=0;};
	|FLOAT					{Datatypevalue=1;};
	|CHAR					{Datatypevalue=2;};
	
EXPRESSION:EXPRESSION '+' EXPRESSION		{addoperator("+");addoperands();};
	|EXPRESSION '-' EXPRESSION		{addoperator("-");addoperands();};
	|EXPRESSION '*' EXPRESSION		{addoperator("*");addoperands();};
	|EXPRESSION '/' EXPRESSION		{addoperator("/");addoperands();};
	|NUM					{
							if(strcmp(QP[Offset].operand1,"")==0)
							{
								char temp[10];
								sprintf(temp,"%d_xC",yylval);
								strcpy(QP[Offset].operand1,temp);
							}
							else if(strcmp(QP[Offset].operand2,"")==0)
							{
								char temp[10];
								sprintf(temp,"%d_xC",yylval);
								strcpy(QP[Offset].operand2,temp);
							}
						};
	|IDENTIFIER				{
							if(strcmp(QP[Offset].operand1,"")==0)
							{
								strcpy(QP[Offset].operand1,ST[$1].symbol);
							}
							else if(strcmp(QP[Offset].operand2,"")==0)
							{
								strcpy(QP[Offset].operand2,ST[$1].symbol);
							}
						};
%%

int main()
{
	yyin=fopen("input.c","r");
	yyparse();
}

yyerror()
{
printf("\nError at Line number %d\n",line);
}


void pushStack(int LabelToPush)
{
	LabelStackTop++;
	LabelStack[LabelStackTop]=LabelToPush;
}
int popStack()
{
	int temp=LabelStack[LabelStackTop];
	LabelStackTop--;
	return temp;
}
