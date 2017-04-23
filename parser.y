%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int sym[1000];
%}

%token EQ
%token START END
%token NUMBER
%token ADD SUB MUL DIV
%token SCOL
%token EOL
%token VAR
%token IDEN
%token FUNC_CALL
%token LEFT_PARAN
%token RIGHT_PARAN
%token COMMA

%%

program: START stmt_list END
;

stmt_list: /* nothing */
	| stmt_list stmt
;

stmt: expr SCOL { printf("= %d\n", $1); }
	| FUNC_CALL LEFT_PARAN IDEN RIGHT_PARAN SCOL { printf("= %d\n", sym[$3]); }
	| assignment SCOL
;

assignment: VAR IDEN EQ expr { $$ = sym[$2] = $4; }
	| IDEN EQ expr { $$ = sym[$1] = $3; }
	| assignment COMMA IDEN EQ expr { $$ = sym[$3] = $5; }
;

expr: factor
	| expr ADD factor { $$ = $1 + $3; }
	| expr SUB factor { $$ = $1 - $3; }
;

factor: term
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
;

term: NUMBER
	| IDEN { $$ = sym[$1]; }
	| LEFT_PARAN expr RIGHT_PARAN { $$ = $2; }
;

%%

int main(int argc, char **argv)
{
	yyparse();
}

int yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}