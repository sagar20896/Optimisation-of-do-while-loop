%{
	#include"3ac.h"
	#include"y.tab.h"
	int Offset=0;
	int TempVariableCount=-1;
	SymbolTable ST[50];
	int STTop=-1;
	Quadraple QP[50];
	int line=1;
%}


%%
[ \t]				;
[\n]				{line++;};
int				{return INT;};
float				{return FLOAT;};
char				{return CHAR;};
void				{return VOID;};
main				{return MAIN;};
while				{return WHILE;};
[a-zA-Z]+[a-zA-Z0-9\_]*		{
					int location =searchSymbolTable(yytext);
					if(location==-1)
					{
						insertSymbolTable(yytext);
						yylval=STTop;
					}
					else
						yylval=location;				
					return IDENTIFIER;
				};
[0-9]+				{
					yylval=atoi(yytext);	
					return(NUM);
				};
[\(\)\{\}\;\,\=\+\-\*\/\<\>]	{return yytext[0];};
%%


int searchSymbolTable(char searchSymbol[])
{
	int i=0;
	for(;i<=STTop;i++)
	{
		if(strcmp(ST[i].symbol,searchSymbol)==0)
		{
			return i;
		}
	}
	return -1;
}

void insertSymbolTable(char insertSymbol[])
{
	STTop++;
	strcpy(ST[STTop].symbol,insertSymbol);
}

void printSymbolTable()
{
	int i=0;	
	printf("===== Symbol Table Printing =====");
	for(;i<=STTop;i++)
	{
		printf("\n[%s]-[%d]-[%s]",ST[i].symbol,ST[i].value,ST[i].datatype);
	}
	printf("\n===== Symbol Table Printed =====");
}

//data function for QUADRAPLE
void printQuadraple()
{
	int i=0;	
	printf("\n===== Quadraple Printing =====");
	printf("\noffset\tLable\topd1\topd2\toprt\tresult\n");
	for(;i<=Offset+1;i++)
	{
		printf("\n%d\t%s\t%s\t%s\t%s\t%s",i,QP[i].label,QP[i].operand1,QP[i].operand2,QP[i].op,QP[i].result);
	}
	printf("\n===== Quadraple Printed =====\n");
}

void addoperator(char addoperator[])
{
	strcpy(QP[Offset].op,addoperator);
}


void addoperands()
{
	if(strcmp(QP[Offset].operand2,"")==0)
	{
		if(strcmp(QP[Offset].operand1,"")==0)
		{
			strcpy(QP[Offset].operand1,QP[Offset-2].result);
		}
		strcpy(QP[Offset].operand2,QP[Offset-1].result);
	}
	char temp[10];
	sprintf(temp,"%d_xT",++TempVariableCount);
	strcpy(QP[Offset].result,temp);
	Offset++;
}

