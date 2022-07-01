%{
#include<stdio.h>
#include<stdlib.h>
#include "cucu.tab.h"

void yyerror(char *s);

%}

%%    
main         {fprintf(yyout,"MAIN: %s\n",yytext);return Mn;}
while        {fprintf(yyout,"WHILE: %s\n",yytext);return Wle;}
if           {fprintf(yyout,"IF: %s\n",yytext);return If;}
else          {fprintf(yyout,"ELSE: %s\n",yytext);return Els;}

int           {fprintf(yyout,"TYPE: %s\n",yytext);return Typ;}
char          {fprintf(yyout,"TYPE: %s\n",yytext);return Typ;}

"char *"          {fprintf(yyout,"TYPE: %s\n",yytext);return Typ;}
"char **"          {fprintf(yyout,"TYPE: %s\n",yytext);return Typ;}
"int*"            {fprintf(yyout,"TYPE: %s\n",yytext);return Typ;}

[,]             {fprintf(yyout,"COMMA: %s\n",yytext);return Coma;}
"return"        {fprintf(yyout,"RETURN: %s\n",yytext);return Rtrn;}   
[&]             {fprintf(yyout,"AND: %s\n",yytext);return And;}
[|]             {fprintf(yyout,"OR: %s\n",yytext);return Or;}
[-]             {fprintf(yyout,"MINUS: %s\n",yytext);return Minus;}
[+]             {fprintf(yyout,"PLUS: %s\n",yytext);return Pls;}
[=]            {fprintf(yyout,"ASSIGN: %s\n",yytext);return Assn;}
[(]             {fprintf(yyout,"LEFT_PAREN: %s\n",yytext);return Lp;}
[)]             {fprintf(yyout,"RIGHT_PAREN: %s\n",yytext);return Rp;}
[<]             {fprintf(yyout,"LESS_THAN: %s\n",yytext);return Lt;}
[>]             {fprintf(yyout,"GREATER_THAN: %s\n",yytext);return Gt;}
[\d*\d]             {fprintf(yyout,"MULT: %s\n",yytext);return Star;}
[*]{2}            {fprintf(yyout,"ASTS: %s\n",yytext);return Dst;}
[/]             {fprintf(yyout,"DIVIDE: %s\n",yytext);return Div;}
[%]             {fprintf(yyout,"MOD: %s\n",yytext);return Md;}
[;]           {fprintf(yyout,"SEMICOL: %s\n",yytext);return Sc;}
[{]             {fprintf(yyout,"LEFT_BRACE: %s\n",yytext);return Lb;}
[}]             {fprintf(yyout,"RIGHT_BRACE: %s\n",yytext);return Rb;}
[\[]            {fprintf(yyout,"LEFT_SQ: %s\n",yytext);return Lsb;}
[\]]             {fprintf(yyout,"RIGHT_SQ: %s\n",yytext);return Rsb;}
[>][=]            {fprintf(yyout,"GT_EQUAL: %s\n",yytext);return Ge;}
[<][=]            {fprintf(yyout,"LT_EQUAL: %s\n",yytext);return Le;}
[=]{2}            {fprintf(yyout,"EQUALS: %s\n",yytext);return Eq;}
[!][=]            {fprintf(yyout,"NOT_EQUAL: %s\n",yytext);return Ne;}
["]               {fprintf(yyout,"D_QUOTES: %s\n",yytext);return Dq;}


[a-zA-Z_][a-zA-Z0-9_]*   { 
        yylval.string=strdup(yytext);
              fprintf(yyout,"ID : %s\n",yytext);
               return Id;};
[0-9][0-9]* {
        yylval.number=atoi(yytext);
 fprintf(yyout,"NUM : %d\n",atoi(yytext));
 return NUM;
 };          

[ \t\n]+       ; 
.            {yyerror("");};
%%








