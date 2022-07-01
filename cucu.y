%{
#include<stdlib.h>
#include<stdio.h>
#include<string.h>

int yyLex();

FILE *out;
void yyerror(char *s) {fprintf(out,"ERROr\n");}
int yywrap(void) {
 return 1;
}
%}

%union{
int number;
char *string;
}

%token<string> Id If Els Wle Lp Rp Assn Sc Pls Minus Star Div Dst Lb Rb Lsb Rsb Ge Le Lt Gt Eq Ne And Or Typ Coma Rtrn Mn Dq Md
%token<number> NUM

%%

prog : prog stmt
       | stmt
     ;

stmt  :  var_dec  
        | fun_dec 
        | Fn_def
        | fun_call
        | if_stmt 
        | Wle_stmt 
        | statement
        | fun_call
        ;

Fn_def :   Typ Id Lp fn_arg Rp Lb fn_body Rb {fprintf(out,"Identifier-%s\n",$2);}
            | Typ Id Lp Rp Lb fn_body Rb {fprintf(out,"Identifier-%s\n",$2);}
            | Typ Mn Lp fn_arg Rp Lb fn_body Rb {fprintf(out,"Identifier-main\n");}
            ; 

fun_dec : Typ Id Lp fn_arg Rp Sc {fprintf(out,"VariabLe- %s ",$1);
          fprintf(out,"Function Declaration: %s \n",$2);}
          ;
                           
statement: | Id Assn exp Sc                      {fprintf(out,"VariabLe: %s  ",$1);}
           | Id Lsb exp Rsb Assn exp Sc         {fprintf(out,"VariabLe: %s  ",$1);}
           | Id Minus Minus Sc                      {fprintf(out,"VariabLe: %s  ",$1);}    
           | Id Pls Pls Sc                        {fprintf(out,"VariabLe: %s  ",$1);} 
           ;
fun_call : Id Lp call_args Rp Sc {fprintf(out,"Var- %s ",$1);fprintf(out,"\nFUN ends\nFUN-CALL\n");}
           | Id Lp Rp Sc {fprintf(out,"Var- %s ",$1);fprintf(out,"\nFUN ends\nFUN-CALL\n");}
           | Rtrn exp Sc               {fprintf(out," RET\n");}  
           | Rtrn Lp exp Rp Sc  {fprintf(out," RET\n");}
          ;

call_args : 
          | exp {fprintf(out,"FUN-ARG\n");}
          | call_args Coma exp {fprintf(out,"FUN-ARG\n");}                 
          ;
                     
var_dec : Typ Id  Sc {fprintf(out,"local variabLe %s\n",$2);}
        | Typ Id Assn exp Sc {fprintf(out,":= \nlocal variabLe: %s\n",$2);}
        | Typ Id Lsb exp Rsb Sc {fprintf(out,"local variabLe: %s\n",$2);}
        | Typ Id Lsb exp Rsb Assn exp Sc   {fprintf(out,":= \nLocal variabLe- %s  ",$2);}
        ;
                   
fn_body : stmt
          | fn_body stmt 
          ;   
        
fn_arg : Typ Id {fprintf(out,"Identifier-main\n");fprintf(out,"function argument: %s\n",$2);}
         | exp
         | exp Coma fn_arg
         | Typ Id Coma fn_arg {fprintf(out,"function argument: %s\nFunction body\n",$2);}
         ;
               

if_stmt : If Lp exp Rp Lb fn_body Rb {fprintf(out," Identifier-if\n");}
         |If Lp exp Rp Lb fn_body Rb Els Lb fn_body Rb{fprintf(out,"  Identifier-if "); 
         fprintf(out," Identifier-ELSE \n");}
         ;
        
Wle_stmt : Wle Lp exp Rp Lb fn_body Rb {fprintf(out," Identifier-WHILE\n");}
           ; 

exp : Id                  {fprintf(out," variabLe- %s  ",$1);}
     | NUM                 {fprintf(out," Const: %d  ",$1);}
     | exp opr exp        
     | Lp exp Rp 
     | Lsb exp Rsb
     | exp Coma exp
     | Id exp 
     ;
     

          
opr :   Lt {fprintf(out,"< ");}
        |Gt {fprintf(out,"> ");}
        |Ge {fprintf(out,">= ");}
        |Le {fprintf(out,"<= ");}
        |Pls {fprintf(out,"+ ");}
        |Minus {fprintf(out,"- ");}
        |Star {fprintf(out,"* ");}
        |Div {fprintf(out,"/ ");}
        |And  {fprintf(out,"And ");}
        |Or  {fprintf(out,"Or ");}
        |Eq {fprintf(out,"== ");}
        |Ne {fprintf(out,"!= ");} 
        | Md {fprintf(out,"% ");}
        ;
        


%%



int main(int argc[],char *argv[]){
extern FILE *yyin,*yyout;
yyin=fopen(argv[1],"r");
yyout=fopen("Lexer.txt","w");
out=fopen("Parser.txt","w");
yyparse();

return 0;
}


