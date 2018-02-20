%{
/****************************************************************************
mylexer.l
ParserWizard generated Lex file.

Date: 2017??9??29??

****************************************************************************/
#ifndef YYSTYPE
#define YYSTYPE treenode*
#endif
#pragma once
#include "myparser.h"
#include "mylexer.h"
#include <cstdio>
#include <iostream>
#include <sstream>
#include "node.h"
#define max(a, b)  (((a) > (b)) ? (a) : (b))
using namespace std;
int idnum = 0;
int line = 1;
bool init=true;
string id[100];
vector<string>inittotal;
%}

/////////////////////////////////////////////////////////////////////////////
// declarations section

// lexical analyser name
%name mylexer

// class definition
{
	// place any extra class members here
}

// constructor
{
	// place any extra initialisation code here
}

// destructor
{
	// place any extra cleanup code here
}

// place any declarations here
integer  [0-9]([0-9]*)
float  ([0-9]*)(\.([0-9]*))?((E|e)([+-])?[0-9]([0-9]*))?
char  '(\\.|[^\\'])+'
if  if
while  while
for  for
INT int
id [A-Za-z_]([A-Za-z_]|[0-9])*
string  \"(\\.|[^\\"])*\"
comment    (\/\*(((\*)*[^\*\/]+(\/)*)*|(\*)*|(\/)*)\*\/)|(\/\/[^\n]*)

%%

/////////////////////////////////////////////////////////////////////////////
// rules section

%{
	// extract yylval for use later on in actions
	YYSTYPE YYFAR& yylval = *(YYSTYPE YYFAR*)yyparserptr->yylvalptr;
%}

// place your Lex rules here
"..."       {if(init) inittotal.push_back("...");
               return(MORE);}
"++"        {if(init) inittotal.push_back("++");
    return(DP);}            
"--"        {if(init) inittotal.push_back("--");
    return(DD);}           
//">>="     {return(DLE);}  /* double_RIGHT_EQUAL*/
//"<<="     {return(DRE);}   /* double_LEFT_EQUAL*/
"+="		{if(init) inittotal.push_back("+=");return(ADD_EQUAL);}
"-="		{if(init) inittotal.push_back("-=");return(SUB_EQUAL);}
"*="		{if(init) inittotal.push_back("*=");return(MUL_EQUAL);}
"/="		{if(init) inittotal.push_back("/=");return(DIV_EQUAL);}
"%="		{if(init) inittotal.push_back("%=");return(MOD_EQUAL);}
"&="		{if(init) inittotal.push_back("*=");return(AND_EQUAL);}/* */
"^="		{if(init) inittotal.push_back("^=");return(XOR_EQUAL);}/* */
"|="		{if(init) inittotal.push_back("|=");return(OR_EQUAL);}/* */
">>"        {if(init) inittotal.push_back(">>");return(DR);}                 
"<<"        {if(init) inittotal.push_back("<<");return(DL);}            
"&&"        {if(init) inittotal.push_back("&&");return(AND);}      
"||"        {if(init) inittotal.push_back("||");return(OR);}      
"<="        {if(init) inittotal.push_back("<=");return(LE);}     
">="        {if(init) inittotal.push_back(">=");return(RE);}     
"=="        {if(init) inittotal.push_back("==");return(EQ);}    
"!="        {if(init) inittotal.push_back("!=");return(NE);}     
//"->"      {return(ARROW);}  
//"::"      {return(DC);}
"-"		    {if(init) inittotal.push_back("-");return(SUB);}
"+"		    {if(init) inittotal.push_back("+");return(ADD);}
"*"		    {if(init) inittotal.push_back("*");return(MUL);}
"/"		    {if(init) inittotal.push_back("/");return(DIV);}
"%"         {if(init) inittotal.push_back("%");return('%');}
"?"         {if(init) inittotal.push_back("?");return('?');}
"\n"        {line++;}     
"<"         {if(init) inittotal.push_back("<");return('<');} 
">"         {if(init) inittotal.push_back(">");return('>');} 
"="         {if(init) inittotal.push_back("=");return('=');} 
";"         {if(init) inittotal.push_back(";");return (';');}
":"         {if(init) inittotal.push_back(":");return(':');} 
","         {if(init) inittotal.push_back(",");return(',');} 
"("		    {if(init) inittotal.push_back("(");return('(');}
")"         {if(init) inittotal.push_back(")");return(')');}
"["         {if(init) inittotal.push_back("[");return('[');}
"]"         {if(init) inittotal.push_back("]");return(']');}
"{"         {
                //cout<<"{"<<ifnum<<endl;
                //cout<<"current"<<" "<<current<<endl;
                if(init) inittotal.push_back("{");
                return('{');}
"true"     {
               treenode *temp=new treenode();
               temp->value_type=10;
               temp->value_bool="true";
               yylval=temp;
               yylval->booltofloat();
               if(init) inittotal.push_back("true");
               return(TRUE);
           }
"false"     {
               treenode *temp=new treenode();
               temp->value_type=10;
               temp->value_bool="false";
               yylval=temp;
               yylval->booltofloat();
               if(init) inittotal.push_back("false");
               return(FALSE);
           }
"}"         { if(init) inittotal.push_back("}");current=entrytable[current].parent;return('}');}
"."         {if(init) inittotal.push_back(".");return('.');}
"!"         {if(init) inittotal.push_back("!");return(NOT);}
"&"         {if(init) inittotal.push_back("&");return(LA);}
"|"         {if(init) inittotal.push_back("|");return('|');}
"~"         {if(init) inittotal.push_back("~");return('~');}
"^"         {if(init) inittotal.push_back("^");return('^');}
//"|"         {yylval=new treenode();yylval->value_type=6;yylval->node_name="|";return('|');} 
//"#"         {yylval=new treenode();yylval->value_type=6;yylval->node_name="#";return('#');}
[ \t\v\n\f] {}    
//"virtual"   {yylval=new treenode();yylval->value_type=8;yylval->node_name="virtual";return(VIRTUAL);}
//"public"  {return(PUBLIC);} 
//"private" {return(PRIVATE);}
//"auto"    {return(AUTO);} /* */
"double"    {yylval=new treenode();if(init) inittotal.push_back("double");yylval->value_type=7;yylval->node_name="double";return(DOUBLE);}/* */
"auto"    {yylval=new treenode();yylval->value_type=7;yylval->node_name="auto";return(AUTO);}/* */
//"struct"  {yylval=new treenode();yylval->value_type=7;yylval->node_name="STRUCT";return(STRUCT);}/* */
"break"     {return(BREAK);}/* */
"else"      {return(ELSE);}/* */
"long"      {yylval=new treenode();yylval->value_type=7;yylval->node_name="long"; return(LONG);}/* */
//"enum"      {return(ENUM);}/* */
//"typedef"   {return(TYPEDEF);}/* */
"char"      {if(init) inittotal.push_back("char");yylval=new treenode();yylval->value_type=7;yylval->node_name="CHAR";return(CHAR);}
"return"    {return(RETURN);}
"endl"      {return(ENDL);}
//"union"   {yylval=new treenode();yylval->value_type=7;yylval->node_name="UNION";return(UNION);}
"const"     {yylval=new treenode();yylval->value_type=8;yylval->node_name="const";return(CONST);}
"float"     {if(init) inittotal.push_back("float");yylval=new treenode();yylval->value_type=7;yylval->node_name="float";return(FLOAT);}
//"string"  {yylval=new treenode();yylval->value_type=7;yylval->node_name="sr";return(STRING);}
"short"     {yylval=new treenode();yylval->value_type=7;yylval->node_name="short";return(SHORT);}
"unsigned"  {yylval=new treenode();yylval->value_type=7;yylval->node_name="unsigned";return(UNSIGNED);}
"continue"  {return(CONTINUE);}
"signed"    {yylval=new treenode();yylval->value_type=7;yylval->node_name="signed";return(SIGNED);}
"void"      {yylval=new treenode();yylval->value_type=7;yylval->node_name="void";return(VOID);}
//"default" {return(DEFAULT);}
"sizeof"    {return(SIZEOF);}
"bool"      {if(init) inittotal.push_back("bool");yylval=new treenode();yylval->value_type=10;yylval->node_name="bool";return(BOOL);}
"do"        {return(DO);}
//"static"  {return(STATIC);}
"write"     {return(WRITE);}
"read"      {return(READ);}
//"class"   {return(CLASS);}
//"this"    {return(THIS);}
"new"      {return(NEW);}
{integer} { 
			stringstream ss;
			ss<<yytext;
			int sum;
			ss>>sum;
			//int sum=atoi(yytext.c_str());
            if(init) inittotal.push_back(to_string(sum));
			treenode *temp=new treenode();
            temp->value_type=1;
            temp->value_int=sum;
            yylval=temp;
            //yylval->setlabel(labelnum);
			return(COUNTINTNUM);
		  }
{float}  {
            stringstream ss;
			ss<<yytext;
			float sum;
			ss>>sum;
            if(init) inittotal.push_back(to_string(sum));
			treenode *temp=new treenode();
            temp->value_type=2;
            temp->value_float=sum;
            yylval=temp;
            //yylval->ifconst=true;
            yylval->setlabel(labelnum);
			return(COUNTFLOATNUM);
       }
{char}   {
            treenode *temp=new treenode();
            temp->value_type=4;
            temp->value_char=yytext[1];
            yylval=temp;
            yylval->chartofloat();
            yylval->setlabel(labelnum);
            string charstring="'";
            charstring+=(yytext[1]);
            charstring+="'";
            if(init) inittotal.push_back(charstring);
            return(COUNTCHARNUM);
         }
{string} {  yylval=new treenode();
             yylval->value_type=6;
             yylval->value_name=yytext;
             memcpy(yylval->value_name,yytext,strlen(yytext));
             yylval->stringtofloat();
             yylval->setlabel(labelnum);
             string temp=yylval->value_name;
             if(init) inittotal.push_back(temp);
             //cout<<yylval->value_temp<<endl;
            return(STRING);
         }
{if}     {
           return(IF);}
{while}  {
           //ifwhile=iffun+ifif+iffor+1;
           if(init) inittotal.push_back("while");
           return(WHILE);}/* */
{for}    {
    if(init) inittotal.push_back("for");
            return(FOR);}/* */
{INT}    {
           yylval=new treenode();
           yylval->value_type=7;
           yylval->node_name="INT";
           if(init) inittotal.push_back("int");
           return(INT);}/* */
{id}     {
              
             yylval=new treenode();
             yylval->value_type=5;
             yylval->value_name=yytext;
             yylval->nametofloat();
             yylval->curtable=current;
             yylval->setlabel(labelnum);
             string temp=yylval->value_name;
             if(init) inittotal.push_back(temp);
             bool have = 0;
             for(int i=0;i<idnum;i++){
                 if(yytext == id[i]){                  
                     have = 1;
                 }
             }
             if(have == 0){
                 id[idnum] = yytext;
                 idnum++; 
             }
             //cout<<yytext<<endl;
             return(ID);
         }
{comment} {}
//"0"		{ yylval=0; printf("0\n");  } 
%%

/////////////////////////////////////////////////////////////////////////////
// programs section

