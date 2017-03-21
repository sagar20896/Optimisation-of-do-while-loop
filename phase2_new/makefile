a.out:	y.tab.c
		gcc y.tab.c -ll -ly
lex.yy.c:	myfile.l 
			lex myfile.l
y.tab.h:	myfile1.y
			yacc -dy myfile.y
