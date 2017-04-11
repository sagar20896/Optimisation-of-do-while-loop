/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    BREAK_KEYWORD = 258,
    RETURN_KEYWORD = 259,
    VOID_KEYWORD = 260,
    FLOAT_KEYWORD = 261,
    CHAR_KEYWORD = 262,
    WHILE_KEYWORD = 263,
    INT_KEYWORD = 264,
    DOUBLE_KEYWORD = 265,
    IDENTIFIER = 266,
    INTEGER_CONSTANT = 267,
    FLOAT_CONSTANT = 268,
    CHAR_CONSTANT = 269,
    STRING_LITERAL = 270,
    PLUS_PLUS = 271,
    MINUS_MINUS = 272,
    LEFT_SHIFT = 273,
    RIGHT_SHIFT = 274,
    LESS_EQUAL = 275,
    GREATER_EQUAL = 276,
    EQUAL_EQUAL = 277,
    NOT_EQUAL = 278,
    LOGICAL_AND = 279,
    LOGICAL_OR = 280,
    STAR_EQUAL = 281,
    BY_EQUAL = 282,
    PERCENT_EQUAL = 283,
    PLUS_EQUAL = 284,
    MINUS_EQUAL = 285,
    SINGLE_COMMENT = 286,
    MULTI_COMMENT = 287
  };
#endif
/* Tokens.  */
#define BREAK_KEYWORD 258
#define RETURN_KEYWORD 259
#define VOID_KEYWORD 260
#define FLOAT_KEYWORD 261
#define CHAR_KEYWORD 262
#define WHILE_KEYWORD 263
#define INT_KEYWORD 264
#define DOUBLE_KEYWORD 265
#define IDENTIFIER 266
#define INTEGER_CONSTANT 267
#define FLOAT_CONSTANT 268
#define CHAR_CONSTANT 269
#define STRING_LITERAL 270
#define PLUS_PLUS 271
#define MINUS_MINUS 272
#define LEFT_SHIFT 273
#define RIGHT_SHIFT 274
#define LESS_EQUAL 275
#define GREATER_EQUAL 276
#define EQUAL_EQUAL 277
#define NOT_EQUAL 278
#define LOGICAL_AND 279
#define LOGICAL_OR 280
#define STAR_EQUAL 281
#define BY_EQUAL 282
#define PERCENT_EQUAL 283
#define PLUS_EQUAL 284
#define MINUS_EQUAL 285
#define SINGLE_COMMENT 286
#define MULTI_COMMENT 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 10 "yacc.y" /* yacc.c:1909  */

  int intval;
  float floatval;
  char *charval;

#line 124 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
