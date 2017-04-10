//headers
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

//data defination
typedef struct SymbolTable
{
	int value;
	char symbol[50];
	char datatype[10];
}SymbolTable;
typedef struct Quadraple
{
	char label[10];
	char operand1[50],operand2[50];
	char op[10];
	char result[50];
}Quadraple;


int searchSymbolTable(char searchSymbol[]);
void insertSymbolTable(char insertSymbol[]);
void printSymbolTable();
void printQuadraple();

