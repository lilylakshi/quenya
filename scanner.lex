%{
#include "calculator.tab.h"
%}

%%

"="			{ return(EQ); }
"+"			{ return(ADD); }
"-"			{ return(SUB); }
"*"			{ return(MUL); }
"/"			{ return (DIV); }
[0-9]+		{ yylval = atoi(yytext); return(NUMBER); }
"Begin"		{ return(START); }
"End"		{ return(END); }
"Var"		{ return(VAR); }
";"			{ return(SCOL); }
"\n"		{ /* ignore carriage return */ }
[ \t]		{ /* ignore whitespace */ }
[a-zA-Z]	{ yylval = yytext[0]; return(IDEN); }
"disp"		{ return(FUNC_CALL); }
"("			{ return(LEFT_PARAN); }
")"			{ return(RIGHT_PARAN); }
","			{ return(COMMA); }
.			{ printf("UNKNOWN_CHAR %s\n", yytext); }

%%