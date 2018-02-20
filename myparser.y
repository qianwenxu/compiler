%{
/****************************************************************************
myparser.y
ParserWizard generated YACC file.

Date: 2017???9??29???
****************************************************************************/
#include "mylexer.h"
#include "myparser.h"
#include <string>
#include <cstdio>
#include <sstream>
#include <vector>
#include <cmath>
#include <cstdlib>
#include <map>
#include "cn.h"
#include "backpatch.h"
#include "judge.h"
//#include "backpatch.h"
using namespace std;
treenode * root;
int iffun=0;
int iffor=0;
int ifif=0;
int ifwhile=0;
int ifc[4]={0,0,0,0};
int ifnum=0;
int ifarray[100];
int current=0;
int number=0;
int temp[100];
int temptype=0;
long long int tempname;
int tempdeep1;
int tempdeep2;
int row[10];
int nonum=0;
int rownum=0;
table entrytable[100];
formultiparamfunction function[20];
int functionnum=0;
extern int line;
extern bool init;
int rt=0;
int labelnum=0;
fourele list[200];
int listnum=0;
int firstparam=0;
int commamin=0;
%}

/////////////////////////////////////////////////////////////////////////////
// declarations section

// parser name
%name myparser

// class definition
{
  // place any extra class members here
 #ifndef YYSTYPE
 #define YYSTYPE treenode*
 #endif     
}

// constructor
{
  // place any extra initialisation code here
}

// destructor
{
  // place any extra cleanup code here
}

// attribute type
%include {

}

// place any declarations here
//%token INTEGER 
//%token PLUS MINUS MUL DIV
//%token LEFT RIGHT
//%token ENDFLAG
%token SIZEOF
%token XOR_EQUAL OR_EQUAL 
%token SUB_EQUAL DLE DRE AND_EQUAL
//%token PROTECTED PRIVATE PUBLIC VIST SPECIAL
//%token CLASS VIRTUAL DR CIN DQ DL COUT ENDL AUTO DEFINE
%token SHORT LONG SIGNED UNSIGNED DOUBLE CONST //STRING
//%token STRUCT UNION ENUM
%token MUL_EQUAL DIV_EQUAL MOD_EQUAL ADD_EQUAL MORE STATIC
%token CASE DEFAULT SWITCH DO FOR CONTINUE BREAK RETURN READ WRITE ENDL 
//%token DCA
%token ARROW STRING 
//%token USING NAMESPACE
//%token REGISTER TYPEDEF EXTERN VOLATLIE THIS
%token VOID  //void
//%token MAIN  //main
%token INT   //int
%token AUTO  //int
%token CHAR  //char
%token FLOAT //float
%token BOOL  //bool
%token IF  //if
%token ELSE  //else
%token WHILE //while
%token FOR   //for
//%token GOTO
%token ADD
%token SUB
%token DIV
%token MUL
%token DP  //'++'
%token DD  //'--'
%token EQ   //'=='
%token RE  //'>='
%token LE  //'<='
%token NE  //'!='
//%token DC  //'::'
%token NOT   //'!'
%token AND   //'&&'
%token OR    //'||'
%token LA   
%token COUNTINTNUM //'??D????y???3???'
%token COUNTFLOATNUM //'???????y???3???'
%token COUNTSTRINGNUM
%token COUNTCHARNUM //'charD??3???'
%token COUNTDOUBLENUM
%token TRUE FALSE
%token NEW
%token ID    //'??????????'
//%token TRUE  //true
//%token FALSE //false
%nonassoc IFX 
%nonassoc ELSE
%left ','
%left OR
%left AND
//%left '|'
//%left '^'
//%left '&'
%left EQ NE
%left LE RE
%left LA '|' '^'
%left DR DL
%left ADD SUB
%left MUL DIV '%'
%left UMINUS
%left DD DP '.'  ARROW '(' ')' '[' ']'
%left FUNCTION
%right '=' ADD_EQUAL SUB_EQUAL MUL_EQUAL DIV_EQUAL MOD_EQUAL
%right SIZEOF NOT
%%

/////////////////////////////////////////////////////////////////////////////
// rules section

// place your YACC rules here (there must be at least one)
TOTAL: declaration_list FUNCTION_STATEMENT_LIST{
    root->children[root->children_number]=$1;
    root->children_number++;

}
    | FUNCTION_STATEMENT_LIST
    ;
FUNCTION_STATEMENT_LIST: FUNCTION_STATEMENT{
                    root->children[root->children_number]=$1;
                    root->children_number++;
                     }
             | FUNCTION_STATEMENT_LIST FUNCTION_STATEMENT{
                root->children[root->children_number]=$2;
                root->children_number++;
             }
             ;
FUNCTION_STATEMENT: TOTAL_DECLARATOR FUNCTION_LIST compound_statement
                     {   
                         $$=new treenode();
                         $$->children[0]=$1;
                         $$->children[1]=$2;
                         $$->children[2]=$3;
                         $$->value_type =9;
                         $$->children_number = 3;
                         $$->node_name = "TOTAL_DECLARATOR FUNCTION_LIST compound_statement" ;
                         //if($2->children[0]->node_name=="ID'('')'")
                         //cout<<"$2->children[0]"<<$2->children[0]->value_type<<"    "<<$2->children_number<<endl;
                        $$->maxlabel=labelnum-1;
                        $$->minlabel=$2->minlabel;
                         if(ifc[0]>0){
                         current=entrytable[current].parent;
                         ifc[0]--;
                         }
                         //cout<<current<<"end"<<endl;
                         functionnum++;
                     }
                 | TOTAL_DECLARATOR POINTER FUNCTION_LIST compound_statement
                     {   
                         $$=new treenode();
                         $$->children[0]=$1;
                         $$->children[1]=$2;
                         $$->children[2]=$3;
                         $$->children[3]=$4;
                         $$->value_type =9;
                         $$->children_number = 4;
                         $$->node_name = "TOTAL_DECLARATOR FUNCTION_LIST compound_statement" ;
                        // cout<<"FUNCTION_STATEMENT"<<endl;;
                         if(ifc[0]>0){
                         current=entrytable[current].parent;
                         ifc[0]--;
                         }
                         //cout<<current<<"end"<<endl;
                         functionnum++;
                     }
                 ;

statement_list: statement
  {
      $$=$1;
  }
  | statement_list statement
  {
      $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$2;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "statement_list statement" ;
        $$->minlabel=$1->minlabel;
        $$->maxlabel=$2->maxlabel;
  }
  ;
  
FUNCTION_LIST: FUNCTION_LEFT PARAMETER_LIST ')' %prec FUNCTION
              {
                 //cout<<$1->value_name<<"FUNCTION_LEFT"<<endl;
                  $$=new treenode();
                  $$->children[0]=$1;
                  $$->children[1]=$2;
                  $$->children_number = 2;
                  $$->value_type =9;
                  $$->node_name = "ID'(' PARAMETER_LIST ')'" ;
          //$$->setre("");
          //$$->setlabel(labelnum++);
          //list[listnum++]=*($$->four);
                  $$->maxlabel=labelnum-1;
                  $$->minlabel=labelnum-1;
                  for(int i=0;i<functionnum;i++){
                      if(function[functionnum].ifsame(function[i]))
                      cout<<"error"<<" "<<"same function"<<" "<<line<<"line"<<endl;
                  }
              }
              | FUNCTION_LEFT ')' %prec FUNCTION
              {
                 // cout<<$1->value_name<<"FUNCTION_LEFT"<<endl;                  
                  $$=new treenode();
                  $$->children[0]=$1;
                  $$->children_number = 1;
                  $$->value_type =9;
                  $$->node_name = "ID'('')'" ;
                  //$$->setarg($1,1);
          //$$->setopr("func:");
          //$$->setre("");
          //$$->setlabel(labelnum++);
          //list[listnum++]=*($$->four);
                  $$->maxlabel=labelnum-1;
                  $$->minlabel=labelnum-1;
                   for(int i=0;i<functionnum;i++){
                      if(function[functionnum].ifsame(function[i]))
                      cout<<"error"<<" "<<"same function"<<" "<<line<<"line"<<endl;
                  }
              }
              ;
FUNCTION_LEFT: ID '('  {
                tempname=$1->value_temp;
                if(init){
                    init=false;
                    inittotal.pop_back();
                    inittotal.pop_back();
                    inittotal.pop_back();
                }
                entrytable[current].insert(tempname,temptype,tempdeep1,tempdeep2,true,functionnum);
                $$->setarg($1,1);
                $$->setopr("func:");
                $$->setlabel(labelnum++);
                list[listnum++]=*($$->four);
                list[listnum-1].re_type=temptype;
                $$->maxlabel=labelnum-1;
                $$->minlabel=labelnum-1;
                function[functionnum].setname(tempname);
                function[functionnum].re_type=temptype;
                tempname=0;
                tempdeep1=0;
                tempdeep2=0;
                number++;
                entrytable[number].parent=current;
                current=number;
                function[functionnum].curtable=current;
                ifc[0]++;
                ifarray[ifnum]=0;
                ifnum++;
                $$=$1;
                $$->maxlabel=labelnum-1;
                $$->minlabel=labelnum-1;
                };
PARAMETER_LIST: PARAMETER
               {
                  $$=$1;
               }
               | PARAMETER_LIST ',' PARAMETER
               {
                  $$=new treenode();
                  $$->children[0]=$1;
                  $$->children[1]=$3;
                  $$->children_number = 2;
                  $$->value_type =9;
                  $$->node_name = "PARAMETER_LIST ',' PARAMETER" ;
               }
               | PARAMETER_LIST ',' MORE
               {
                  $$=new treenode();
                  $$->children[0]=$1;
                  $$->children[1]=$3;
                  $$->children_number = 2;
                  $$->value_type =9;
                  $$->node_name = "PARAMETER_LIST ',' MORE" ;
                  function[functionnum].ismore=true;
               }
               ;
PARAMETER: TOTAL_DECLARATOR
           {
               entrytable[current].insert(tempname,temptype,tempdeep1,tempdeep2);
               function[functionnum].insert(temptype,tempdeep1,tempdeep2);
               tempdeep1=0;
               tempdeep2=0;
               tempname=0;
               $$=$1;
           }
           | TOTAL_DECLARATOR NEW_ELEMENT
           {
               $$=new treenode();
               $$->children[0]=$1;
               $$->children[1]=$2;
               $$->children_number = 2;
               $$->value_type =9;
               $$->node_name = "TOTAL_DECLARATOR NEW_ELEMENT" ;
               if(entrytable[current].test(tempname)==false)
                  //yyerror();
                   cout<<"error line:"<<line<<endl;
               entrytable[current].insert(tempname,temptype,tempdeep1,tempdeep2);
               function[functionnum].insert(temptype,tempdeep1,tempdeep2);
               function[functionnum].addextern(nonum,rownum,row);
               rownum=0;
               nonum=0;
               //for(int i=0;i<15;i++)row[i]=0;
               tempdeep1=0;
               tempdeep2=0;
               tempname=0;
               $$->node_type = $2->node_type;
         $$->value_temp = $2->value_temp;
         $$->pointor_number = $2->pointor_number;
         $$->array_number = $2->array_number;
           }
           | TOTAL_DECLARATOR ABSTRACT_NEW_ELEMENT
           {
               $$=new treenode();
               $$->children[0]=$1;
               $$->children[1]=$2;
               $$->children_number = 2;
               $$->value_type =9;
               $$->node_name = "TOTAL_DECLARATOR ABSTRACT_NEW_ELEMENT" ;
               if(entrytable[current].test(tempname)==false)
                  //yyerror();
                   cout<<"error line:"<<line<<endl;
               entrytable[current].insert(tempname,temptype,tempdeep1,tempdeep2);
               function[functionnum].insert(temptype,tempdeep1,tempdeep2);
               function[functionnum].addextern(nonum,rownum,row);
               rownum=0;
               nonum=0;
                //for(int i=0;i<15;i++)
               //row[i]=0;
               tempdeep1=0;
               tempdeep2=0;
               tempname=0;
               $$->node_type = $2->node_type;
         $$->value_temp = $2->value_temp;
         $$->pointor_number = $2->pointor_number;
         $$->array_number = $2->array_number;
           }
           ;
           
type_name
  : TOTAL_DECLARATOR {$$=$1;}
  | TOTAL_DECLARATOR ABSTRACT_NEW_ELEMENT {
    $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$2;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "type_name";
        $$->node_type=$1->node_type;
        $$->pointor_number=$2->pointor_number;
        $$->array_number=$2->array_number;
  }
  ;

//3?????????????????????a????????????????????y???????
ABSTRACT_NEW_ELEMENT: POINTER
                      {
                          $$=$1;
                      }
                      | POINTER ABSTRACT_ELEMENT
                      {
                          $$=new treenode();
                          $$->children[0]=$1;
                          $$->children[1]=$2;
                          $$->children_number = 2;
                          $$->value_type =9;
                          $$->node_name = "POINTER ABSTRACT_ELEMENT";
                          $$->pointor_number=$2->pointor_number;
                          $$->array_number=$2->array_number;
                      }
                      | ABSTRACT_ELEMENT
                      {
                          $$=$1;
                      }
                      ;
ABSTRACT_ELEMENT:'(' ABSTRACT_NEW_ELEMENT ')'{
        $$=new treenode();
        $$->children[0]=$2;
        $$->children_number = 1;
        $$->value_type =9;
        $$->node_name = "'(' ABSTRACT_NEW_ELEMENT ')'" ;
    }
  | '[' ']'
  {
    $$=new treenode();
        $$->children_number = 0;
        $$->value_type =9;
        $$->node_name = "[]" ;
        tempdeep2++;
        nonum++;
  }
  | '[' condition_exp ']'
  {
    $$=new treenode();
        $$->children[0]=$2;
        $$->children_number = 1;
        $$->value_type =9;
        $$->node_name = "'[' condition_exp ']'" ;
        tempdeep2++;
        if($2->value_type==1)
        row[rownum]=$2->value_int;
        else if($2->value_type==2||$2->value_type==3)
        row[rownum]=$2->value_float;
        else row[rownum]=$2->value_temp;
        rownum++;
  }
  | ABSTRACT_ELEMENT '[' ']'{
    $$=new treenode();
        $$->children[0]=$1;
        $$->children_number = 1;
        $$->value_type =9;
        $$->node_name = "ABSTRACT_ELEMENT '[' ']'" ;
        tempdeep2++;
        nonum++;
  }
  | ABSTRACT_ELEMENT '[' condition_exp ']'{
    $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "ABSTRACT_ELEMENT '[' condition_exp ']'" ;
        tempdeep2++;
         if($3->value_type==1)
        row[rownum]=$3->value_int;
        else if($3->value_type==2||$3->value_type==3)
        row[rownum]=$3->value_float;
        else row[rownum]=$3->value_temp;
        rownum++;
  }
  | '(' ')'
  {
    $$=new treenode();
        $$->children_number = 0;
        $$->value_type =9;
        $$->node_name = "()" ;
  }
  | '(' PARAMETER_LIST ')'
  {
    $$=new treenode();
        $$->children[0]=$2;
        $$->children_number = 1;
        $$->value_type =9;
        $$->node_name = "'(' PARAMETER_LIST ')'" ;
  }
  | ABSTRACT_ELEMENT '(' ')'
  {
    $$=new treenode();
        $$->children[0]=$1;
        $$->children_number = 1;
        $$->value_type =9;
        $$->node_name = "ABSTRACT_ELEMENT '(' ')'" ;
  }
  | ABSTRACT_ELEMENT '(' PARAMETER_LIST ')'{
    $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "ABSTRACT_ELEMENT '(' PARAMETER_LIST ')'" ;
  }
  ;
statement: ID ':' statement
  {
        $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "ID ':' statement" ;
        $1->node_type = $1->findtype();
    $1->pointor_number=$1->findpointordeep();
    $1->array_number = $1->findarraydeep();
    $1->node_name="ID";
    if($1->node_type==-1||$1->pointor_number==-1||$1->array_number==-1){
      cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
    }else{
      //tostring($1->value_temp);
      //cout<<"(node_type,pointor_number,array_number):"<<$1->node_type<<","<<$1->pointor_number<<","<<$1->array_number;
    }
    }
  | CASE EQ_EXP ':' statement
  {
        $$=new treenode();
        $$->children[0]=$2;
        $$->children[1]=$4;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "CASE EQ_EXP ':' statement" ;
    }
  | DEFAULT ':' statement
  {
        $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "DEFAULT ':' statement" ;
    }
  | compound_statement
  {
        $$ = $1;
        //printf("compound_stmt\n");
    }
    | if_r '(' COMMA_exp ')' statement %prec IFX 
    {
        $$=new treenode();
        $$->children[0]=$3;
        $$->children[1]=$5;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "IF '(' COMMA_exp ')' statement" ;
        backpatch_if($$,$3, $5);
        printf("ifminlabel%d",$$->minlabel);
        printf("ifmaxlabel%d\n",$$->maxlabel);
       /*if(ifc[2]>0){
        ifc[2]--;
        ifnum--;
        current=entrytable[current].parent;
        //cout<<"cur"<<current<<endl;
        }*/
    }
  | if_r '(' COMMA_exp ')' statement ELSE statement
  {
        $$=new treenode();
        $$->children[0]=$3;
        $$->children[1]=$5;
        $$->children[2]=$7;
        $$->children_number = 3;
        $$->value_type =9;
        $$->node_name = "IF '(' COMMA_exp ')' statement ELSE statement" ;
        backpatch_if($$,$3,$5,$7);
        printf("ifelseminlabel%d",$$->minlabel);
        printf("ifelsemaxlabel%d\n",$$->maxlabel);
       /* if(ifc[2]>0){
        ifc[2]--;
        ifnum--;
        //cout<<"pree"<<current<<endl;
        current=entrytable[current].parent;
        //cout<<"curr"<<current<<endl;
        }*/
    }
  | SWITCH '(' COMMA_exp ')' statement  //switch(a = a+1,a=a+2){cout<<"true";cout<<a;}????????y???????2????3?true
  {
        $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->children[2]=$5;
        $$->children_number = 3;
        $$->value_type =9;
        $$->node_name = "SWITCH '(' COMMA_exp ')' statement" ;
        }
  | while_r '(' COMMA_exp ')' statement
  {
        $$=new treenode();
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->children[2]=$5;
        $$->children_number = 3;
        $$->value_type =9;
        $$->node_name = "WHILE '(' COMMA_exp ')' statement" ;
        backpatch_while($$, $3, $5);
        $$->minlabel=$3->minlabel;
        $$->maxlabel=$5->maxlabel;
        if(labelnum-1>$$->maxlabel){
        $$->maxlabel=labelnum-1;
        }
        cout<<"while(comma)min&max"<<$3->minlabel<<"&"<<$3->maxlabel<<endl;
        printf("whileminlabel%d",$$->minlabel);
        printf("whilemaxlabel%d",$$->maxlabel);
        //printf("whilestmtminlabel%d\n",$5->minlabel);
        /*if(ifc[3]>0){
        ifc[3]--;
        ifnum--;
        current=entrytable[current].parent;
        }*/
    }
  | DO statement WHILE '(' COMMA_exp ')' ';'
  {
        $$=new treenode();
        $$->children[0]=$2;
        $$->children[1]=$5;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "DO statement WHILE '(' COMMA_exp ')' ';'" ;
    }
  | for_r '(' declaration_or_descriptive_statement declaration_or_descriptive_statement ')' statement
  {
        $$=new treenode();
        $$->children[0]=$3;
        $$->children[1]=$4;
        $$->children[2]=$6;
        $$->children_number = 3;
        $$->value_type =9;
        $$->node_name = "FOR '(' descriptive_statement descriptive_statement ')' statement" ;
        backpatch_for($$,$3,$4,$6);
        if(ifc[1]>0){
        ifc[1]--;
        ifnum--;
        current=entrytable[current].parent;
        }
    }
  | for_r '(' declaration_or_descriptive_statement declaration_or_descriptive_statement COMMA_exp ')' statement
  //| GOTO ID ';'
  {
        $$=new treenode();
        $$->children[0]=$3;
        $$->children[1]=$4;
        $$->children[2]=$5;
        $$->children[3]=$7;
        $$->children_number = 4;
        $$->value_type =9;
        $$->node_name = "FOR '(' descriptive_statement descriptive_statement COMMA_exp ')' statement" ;
        backpatch_for($$,$3, $4, $7, $5);
        //$$->minlabel=$3->minlabel;
        //$$->maxlabel=$7->maxlabel;
        printf("forminlabel%d",$$->minlabel);
        printf("formaxlabel%d\n",$$->maxlabel);
        if(ifc[1]>0){
         ifc[1]--;
         ifnum--;
         current=entrytable[current].parent;
         }
    }
  | BREAK ';'
  {
        $$=new treenode();
        $$->value_type =9;
        $$->children_number = 0;
        $$->node_name = "BREAK ';'" ;
        $$->setopr("break");
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
    }
  | CONTINUE ';'
  {
        $$=new treenode();
        $$->value_type =9;
        $$->children_number = 0;
        $$->node_name = "CONTINUE ';'" ;
        $$->setopr("continue");
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
    } 
  | RETURN ';'
  {
        $$=new treenode();
        $$->value_type =9;
        $$->children_number = 0;
        $$->node_name = "RETURN ';'" ;
        $$->setopr("return");
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
    }
  | RETURN COMMA_exp ';'
  {
        $$=new treenode();
        $$->children[0]=$2;
        $$->value_type =9;
        $$->children_number = 1;
        $$->node_name = "RETURN COMMA_exp ';'" ;
        $$->setarg($2,1);
        $$->setopr("return");
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($2->minlabel<$$->minlabel){
      $$->minlabel=$2->minlabel;
        }
        if($2->array_number+$2->pointor_number>0){
        cout<<"error "<<line<<endl;
        }
    }
    |descriptive_statement
    {
        $$=$1;
    }
    | read_statement{$$=$1;}
    | write_statement{$$=$1;}
  ;
read_statement: READ DR read_list ';'
              {
               //cout<<"read"<<endl;
               $$=new treenode();
               $$->children[0]=$3;
               $$->value_type =9;
               $$->children_number = 1;
               $$->node_name = "READ_STATEMENT" ;
               $$->setopr("read");
               $$->setarg($3,1);
         $$->setlabel(labelnum++);
         list[listnum++]=*($$->four);
         $$->maxlabel=labelnum-1;
         if(labelnum-1<$3->minlabel){
          $$->minlabel=labelnum-1;
         }
         else{
          $$->minlabel=$3->minlabel;
         }
              };
read_list: ID {
      $$=$1;
      $$->node_name="ID";
      $$->node_type = $$->findtype();
      $$->pointor_number=$$->findpointordeep();
      $$->array_number = $$->findarraydeep();
      $$->node_name="ID";
      if($$->node_type==-1||$$->pointor_number==-1||$$->array_number==-1){
        cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
      }else{
        //tostring($$->value_temp);
        //cout<<"(node_type,pointor_number,array_number):"<<$$->node_type<<","<<$$->pointor_number<<","<<$$->array_number;
      }
  }
		| Assign_exp{$$=$1;}
        | read_list DR ID{
            $$=new treenode();
            $$->children[0]=$1;
            $$->children[1]=$3;
            $$->value_type =9;
            $$->children_number = 2;
            $$->node_name = "READ_LIST" ;
            $3->node_type = $3->findtype();
      $3->pointor_number=$3->findpointordeep();
      $3->array_number = $3->findarraydeep();
      $3->node_name="ID";
      if($3->node_type==-1||$3->pointor_number==-1||$3->array_number==-1){
        cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
      }else{
        //tostring($3->value_temp);
        //cout<<"(node_type,pointor_number,array_number):"<<$3->node_type<<","<<$3->pointor_number<<","<<$3->array_number;
      }
      $$->setopr("readdr");
      $$->setarg($3,1);
      $$->setlabel(labelnum++);
      list[listnum++]=*($$->four);
      $$->maxlabel=labelnum-1;
      if(labelnum-1<$1->minlabel){
          $$->minlabel=labelnum-1;
         }
         else{
          $$->minlabel=$1->minlabel;
      }
      $$->setre($1->getre());
        } 
        | read_list DR Assign_exp{
               $$=new treenode();
               $$->children[0]=$1;
               $$->children[1]=$3;
               $$->value_type =9;
               $$->children_number = 2;
               $$->node_name = "READ_LIST" ;
               $$->setopr("readdr");
        $$->setarg($3,1);
            $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        if(labelnum-1<$1->minlabel){
          $$->minlabel=labelnum-1;
         }
         else{
          $$->minlabel=$1->minlabel;
         }
	        $$->setre($1->getre());
            }
        ;
write_statement: WRITE DL write_list';'
             {
               //cout<<"write"<<endl;
               $$=new treenode();
               $$->children[0]=$3;
               $$->value_type =9;
               $$->children_number = 1;
               $$->node_name = "WRITE_STATMENT" ;
               $$->setopr("write");
               $$->setarg($3,1);
               $$->setlabel(labelnum++);
               cout<<"yacc"<<labelnum<<endl;
               list[listnum++]=*($$->four);
               $$->maxlabel=labelnum-1;
               if(labelnum-1<$3->minlabel){
                 $$->minlabel=labelnum-1;
                }
                else{
                    $$->minlabel=$3->minlabel;
                }
                /*cout<<"inyacc"<<endl;
                cout<<$$->maxlabel<<endl;
                cout<<$$->minlabel<<endl;*/
            };
write_list: ID {
      $$=$1;
      $$->node_name="ID";
      $$->node_type = $$->findtype();
      $$->pointor_number=$$->findpointordeep();
      $$->array_number = $$->findarraydeep();
      $$->node_name="ID";
      if($$->node_type==-1||$$->pointor_number==-1||$$->array_number==-1){
        cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
      }else{
        //tostring($$->value_temp);
        //cout<<"(node_type,pointor_number,array_number):"<<$$->node_type<<","<<$$->pointor_number<<","<<$$->array_number;
      }
      cout<<"writelistidgetre:"<<$$->getre();
      
      } 
          | Assign_exp{$$=$1;}
          //| CONSTANT{$$=$1;}
          | ENDL{
              
               $$=new treenode();
               $$->value_type =9;
               $$->children_number = 0;
               $$->node_name = "ENDL" ;
               $$->four->setre("endl");
          }
          | write_list DL ID
              {
               $$=new treenode();
               $$->children[0]=$1;
               $$->children[1]=$3;
               $$->value_type =9;
               $$->children_number = 2;
               $$->node_name = "WRITE_LIST" ;
               $3->node_type = $3->findtype();
        $3->pointor_number=$3->findpointordeep();
        $3->array_number = $3->findarraydeep();
        $3->node_name="ID";
        if($3->node_type==-1||$3->pointor_number==-1||$3->array_number==-1){
          cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
        }else{
          //tostring($3->value_temp);
          //cout<<"(node_type,pointor_number,array_number):"<<$3->node_type<<","<<$3->pointor_number<<","<<$3->array_number;
        }
        $$->setopr("writedl");
        $$->setarg($3,1);
            $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        if(labelnum-1<$1->minlabel){
          $$->minlabel=labelnum-1;
         }
         else{
          $$->minlabel=$1->minlabel;
         }
        $$->setre($1->getre());
        cout<<"   $1getre"<<$1->getre()<<endl;
            }
          | write_list DL Assign_exp{
               $$=new treenode();
               $$->children[0]=$1;
               $$->children[1]=$3;
               $$->value_type =9;
               $$->children_number = 2;
               $$->node_name = "WRITE_LIST" ;
               $$->setopr("writedl");
        $$->setarg($3,1);
            $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        if(labelnum-1<$1->minlabel){
          $$->minlabel=labelnum-1;
         }
         else{
          $$->minlabel=$1->minlabel;
         }
        $$->setre($1->getre());
            }
          | write_list DL ENDL{
              $3=new treenode();
              $3->value_type =9;
              $3->children_number = 0;
              $3->node_name = "ENDL" ;
              $$=new treenode();
              $$->children[0]=$1;
              $$->children[1]=$3;
              $$->value_type =9;
              $$->children_number = 2;
              $$->node_name = "WRITE_LIST" ;
              $$->setopr("writedl");
        $$->four->setarg1("endl");
          $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        if(labelnum-1<$1->minlabel){
          $$->minlabel=labelnum-1;
         }
         else{
          $$->minlabel=$1->minlabel;
         }
        $$->setre($1->getre());
        cout<<"$1=>getre:  "<<$1->getre();
          }
          ;


compound_statement: left_r '}'
  {
        $$=new treenode();
        $$->value_type =9;
        $$->children_number = 0;
        $$->node_name = "'{' '}'" ;
        $$->minlabel=-1;
        $$->maxlabel=-1;
        //current=entrytable[current].parent;
    }
  | left_r statement_list '}'
  {
        $$=new treenode();
        $$->children[0]=$2;
        $$->children_number = 1;
        $$->value_type =9;
        $$->node_name = "'{' statement_list '}'" ;
        $$->four=$2->four;
        $$->minlabel=$2->minlabel;
        $$->maxlabel=$2->maxlabel;
        //current=entrytable[current].parent;
        cout<<"'{' statement_list '}'min"<<$2->minlabel<<"max"<<$2->maxlabel<<endl;
    }
  | left_r declaration_list '}'
  {
        $$=new treenode();
        $$->children[0]=$2;
        $$->children_number = 1;
        $$->value_type =9;
        $$->node_name = "'{' declaration_list '}'" ;
        $$->four=$2->four;
        $$->minlabel=$2->minlabel;
        $$->maxlabel=$2->maxlabel;
        cout<<"'{' declaration_list '}'min"<<$2->minlabel<<"max"<<$2->maxlabel<<endl;
        //current=entrytable[current].parent;
    }
  | left_r declaration_list statement_list '}'//declaration????????????????a??a???????????????,?????????3??????????DD??|??????????statement?????Ddescripyive_statement
  {
        $$=new treenode();
        $$->children[0]=$2;
        $$->children[1]=$3;
        $$->children_number = 2;
        $$->value_type =9;
        $$->node_name = "'{' declaration_list statement_list '}'" ;
        $$->minlabel=$2->minlabel;
        if($3->minlabel<$$->minlabel){
      $$->minlabel=$3->minlabel;
        }
        $$->maxlabel=$3->maxlabel;
        cout<<"'{'declaration_list statement_list '}'min"<<$$->minlabel<<"max"<<$$->maxlabel<<endl;
        //current=entrytable[current].parent;
    }
    ;
declaration_list: DECLARATION                     {$$=$1;}
              | declaration_list DECLARATION    {
              $$=new treenode();
              $$->value_type=9;
              $$->node_name="declaration_list";
              $$->children_number=2;
              $$->children[0]=$1;
              $$->children[1]=$2;
              $$->minlabel=$1->minlabel;
        $$->maxlabel=$2->maxlabel;
              }
              ;
  
declaration_or_descriptive_statement: DECLARATION {$$=$1;}
                                    | descriptive_statement {$$=$1;}
                                    ;

DECLARATION: TOTAL_DECLARATOR';' {
           $$=$1;
           }
           | TOTAL_DECLARATOR INITIAL_LIST';' {
               $$=new treenode();
               $$->value_type=9;
               $$->node_name="DECLARATION";
               $$->children_number=2;
               $$->children[0]=$1;
               $$->children[1]=$2;
               $$->minlabel=$2->minlabel;
         $$->maxlabel=$2->maxlabel;
            }
           ;
TOTAL_DECLARATOR: SPECIAL_DECLARATOR variable_type   {$$=new treenode();$$->value_type=9;$$->node_name="TOTAL_DECLARATOR";$$->children_number=2;$$->children[0]=$1;$$->children[1]=$2;}
                | variable_type                      {$$=$1;}
                ;

SPECIAL_DECLARATOR:STATIC {$$=$1;}
                  |CONST  {$$=$1;}
                  ;
//?????????D????D????????D??????????????o  
INITIAL_LIST: INITIAL_ELEMENT                  {$$=$1;}
            | INITIAL_LIST ',' INITIAL_ELEMENT {
            $$=new treenode();
            $$->value_type=9;
            $$->node_name="INITIAL_LIST";
            $$->children_number=2;
            $$->children[0]=$1;
            $$->children[1]=$3;
            $$->minlabel=$1->minlabel;
      $$->maxlabel=$3->maxlabel;
            }
            ;
//3??????????D?????????D3???????o??????D3???????
INITIAL_ELEMENT: NEW_ELEMENT {
                if(entrytable[current].test(tempname)==false)
                  //yyerror();
                   cout<<"error line:"<<line<<endl;
                else {
          $$=$1;
          $1->node_type=temptype;
                    $1->pointor_number=tempdeep1;
                    $1->array_number=tempdeep2;
                    entrytable[current].insert(tempname,temptype,tempdeep1,tempdeep2);
                    entrytable[current].addextern(tempname,nonum,rownum,row);
                    rownum=0;
                    nonum=0;
                    //cout<<"new:"<<tempname<<"  "<<tempdeep1<<" "<<tempdeep2<<" "<<current<<endl; 
                    tempdeep1=0;
                    tempdeep2=0;
                    tempname=0;
                    if($$->children_number==1){
            if($$->children[0]->node_name=="ID array_dim_opt"){
              if($$->children[0]->children[1]->node_name=="[]"||$$->children[0]->children[1]->node_name=="'[' ']' array_dim"){
                cout<<"line"<<line<<":error??y?????????????2????D????1???2??????????????D??"<<endl;
              }
            }
                    }else if($$->children_number==2){
            if($$->children[1]->node_name=="ID array_dim_opt"){
              if($$->children[1]->children[1]->node_name=="[]"||$$->children[1]->children[1]->node_name=="'[' ']' array_dim"){
                cout<<"line"<<line<<":error??y?????????????2????D????1???2??????????????D??"<<endl;
              }
            }
                    }
               }
               }
               | NEW_ELEMENT'='OLD_EXPRESSION   
               {
          $$=new treenode();
                    $$->value_type=9;
                    $$->node_name="Equal";
                    $$->children_number=2;
                    $$->children[0]=$1;
                    $$->children[1]=$3;
                    $1->node_type=temptype;
                    $1->pointor_number=tempdeep1;
                    $1->array_number=tempdeep2;
                    entrytable[current].insert(tempname,temptype,tempdeep1,tempdeep2);
                    entrytable[current].addextern(tempname,nonum,rownum,row);
                    rownum=0;
                    nonum=0;
                    //cout<<"equal====="<<$1->children[0]->node_name<<"======="<<$3->node_name<<endl;
                    //cout<<"new:"<<tempname<<"  "<<tempdeep1<<" "<<tempdeep2<<" "<<current<<endl; 
                    if($3->node_name=="'{' OLD_EXPRESSION_LIST'}'"||$3->node_name=="'{' OLD_EXPRESSION_LIST ',' '}'"||$3->node_name=="{ }"){
						//cout<<$1->code_str<<"="<<$3->code_str<<endl;
						$$->minlabel=labelnum;
						aboutarray($1->code_str,$3->code_str,tempdeep2,current);
						$$->maxlabel=labelnum-1;
					    //cout<<"decmin"<<$$->minlabel<<"max"<<$$->maxlabel<<endl;
					}else if($1->children[0]->node_name=="(NEW_ELEMENT)"&&$3->node_name=="'(' COMMA_exp')'"){
						$$->setre($1->code_str);
						$$->four->setarg1($3->code_str);
						$$->setopr("=");
						$$->setlabel(labelnum++);
						list[listnum++]=*($$->four);
						list[listnum-1].re_type=temptype;
						$$->maxlabel=labelnum-1;
						$$->minlabel=labelnum-1;
					}else if($1->children[0]->node_name=="(NEW_ELEMENT)"){
						$$->setre($1->code_str);
						$$->setarg($3,1);
						$$->setopr("=");
						$$->setlabel(labelnum++);
						list[listnum++]=*($$->four);
						list[listnum-1].re_type=temptype;
						$$->maxlabel=labelnum-1;
						$$->minlabel=labelnum-1;
					}else if($3->node_name=="'(' COMMA_exp')'"){
						cout<<"YES$3"<<$3->code_str<<endl;
						$$->setre($1->getre());
						$$->four->setarg1($3->code_str);
						$$->setopr("=");
						$$->setlabel(labelnum++);
						list[listnum++]=*($$->four);
						list[listnum-1].re_type=temptype;
						$$->maxlabel=labelnum-1;
						$$->minlabel=labelnum-1;
					}
					else{
						$$->setre($1->getre());
						$$->setarg($3,1);
						$$->setopr("=");
						$$->setlabel(labelnum++);
						list[listnum++]=*($$->four);
						list[listnum-1].re_type=temptype;
						$$->maxlabel=labelnum-1;
						$$->minlabel=labelnum-1;
					}
					tempdeep1=0;
					tempdeep2=0;
					tempname=0;
          if($3->minlabel<$$->minlabel){
				$$->minlabel=$3->minlabel;
			}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
                    //cout<<line<<"(node_type,pointor_number,arry_num):" << $1->node_type << "," << $2->pointor_number << "," << $3->array_number;
                    if(($$->children[1]->node_name == "SEN_ELEM_EXP (COMMA_exp)" || $$->children[1]->node_name == "SEN_ELEM_EXP ()")){
                     if($1->array_number+$1->pointor_number!=$3->array_number+$3->pointor_number)
                       cout<<"error "<<line<<"equal"<<endl;
                    }
                else if($1->node_type==11){
            if(($3->pointor_number+$3->array_number)==0||$3->node_name=="POINTER ID"||$3->node_name=="ID'(' PARAMETER_LIST ')'"||$3->node_name=="ID'('')'"||$3->node_name=="ID"||$3->node_name=="ID array_dim_opt"||$3->node_name=="&"){
              $$->node_type=$3->node_type;
              $$->pointor_number = $3->pointor_number;
              $$->array_number = $3->array_number;
                            $1->changede($3->node_type,$3->array_number,$3->array);
            }
            else{
              cout<<"error line"<<line<<":auto"<<endl;
            }
          }
          else if($3->node_name=="'{' OLD_EXPRESSION_LIST'}'"||$3->node_name=="'{' OLD_EXPRESSION_LIST ',' '}'"||$3->node_name=="{ }"){
            $$->node_type=$1->node_type;
            $$->pointor_number = $1->pointor_number;
            $$->array_number = $1->array_number;
          }else{
            if($1->array_number!=0){
              cout<<line<<"error:array moust {}"<<endl;
            }else if($1->pointor_number!=0 && $1->node_type!=$3->node_type){
              cout<<"error"<<line<<endl;
            }else if($1->pointor_number<$3->pointor_number+$3->array_number){
              cout<<"error"<<line<<endl;
                        }
          }
                }
               ;
//3??????????????a?????????o?????????????
NEW_ELEMENT: POINTER NEW_ELEMENT_ID           {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="NEW_ELEMENT";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$2;
        $$->node_type=$2->node_type;
          $$->value_temp=$2->value_temp;
          $$->pointor_number=$2->pointor_number;
          $$->array_number = $2->array_number;
        }
           | NEW_ELEMENT_ID                   {
        $$=new treenode();
        $$->value_type=$1->value_type;
        $$->node_name="NEW_ELEMENT";
        $$->children_number=1;
        $$->children[0]=$1;
                $$->curtable=$1->curtable;
        $$->node_type=$1->node_type;
        $$->value_temp=$1->value_temp;
        $$->pointor_number=$1->pointor_number;
        $$->array_number = $1->array_number;
        if($1->node_name=="ID array_dim_opt"||$1->node_name=="(NEW_ELEMENT)"){
					$$->code_str=$1->code_str;
				}
      }
            ;
POINTER: MUL         {tempdeep1++;$$=new treenode();$$->value_type=9;$$->node_name="POINTER";$$->children_number=0;$$->pointor_number = 1;$$->array_number=0;}
       | POINTER MUL  {
            tempdeep1++;
            $$=new treenode();
            $$->value_type=9;
            $$->node_name="POINTER MUL";
            $$->children_number=2;
            $2=new treenode();
            $2->value_type=9;
            $2->node_name="POINTER";
            $2->children_number=0;
            $2->pointor_number=1;
            $$->children[0]=$1;
            $$->children[1]=$2;
            $$->pointor_number=$1->pointor_number+$2->pointor_number;
            $$->array_number=0;
       }
       ;
       
OLD_EXPRESSION_LIST: OLD_EXPRESSION                         {$$=$1;}
  | OLD_EXPRESSION_LIST ',' OLD_EXPRESSION {
      $$=new treenode();
      $$->value_type=9;
      $$->node_name="OLD_EXPRESSION_LIST";
      $$->children_number=2;
      $$->children[0]=$1;
      $$->children[1]=$3;
      $$->node_type=$1->node_type;
      $$->array_number=max($1->array_number,$3->array_number);
      $$->pointor_number=0;
      $$->minlabel=$1->minlabel;
        $$->maxlabel=$3->maxlabel;
        $$->code_str=$1->code_str+","+$3->code_str;
  }
  ;
  //?????????????????????????D???????????????????????????
OLD_EXPRESSION: Assign_exp                      {
		$$=$1;
		if($$->code_str==""){
			$$->code_str=$1->getre();
		}
		}
  | left_r '}' {
  $$=new treenode();
  $$->value_type=9;
  $$->node_name="{ }";
  $$->children_number=0;
  $$->array_number=1;
  $$->pointor_number=0;
  $$->code_str="{}";
  }
  | left_r OLD_EXPRESSION_LIST'}'      {
  $$=new treenode();
  $$->value_type=9;
  $$->node_name="'{' OLD_EXPRESSION_LIST'}'";
  $$->children_number=1;
  $$->children[0]=$2;
  $$->node_type=$2->node_type;
  $$->array_number=$2->array_number+1;
  $$->pointor_number=0;
  $$->code_str="{"+$2->code_str+"}";
  }
  | left_r OLD_EXPRESSION_LIST ',' '}' {
  $$=new treenode();
  $$->value_type=9;
  $$->node_name="'{' OLD_EXPRESSION_LIST ',' '}'";
  $$->children_number=1;
  $$->children[0]=$2;
  $$->node_type=$2->node_type;
  $$->array_number=$2->array_number+1;
  $$->pointor_number=0;
  $$->code_str="{"+$2->code_str+",}";
  }
    //|  NEW variable_type POINTER '['COMMA_exp']'  {$$=new treenode();$$->value_type=9;$$->node_name="list";$$->children_number=3;$$->children[0]=$2;$$->children[1]=$3;$$->children[2]=$5;}
    //|  NEW variable_type POINTER '['']'  {$$=new treenode();$$->value_type=9;$$->node_name="list";$$->children_number=2;$$->children[0]=$2;$$->children[1]=$3;}
    //|  NEW variable_type POINTER '['OLD_EXPRESSION_LIST']' {$$=new treenode();$$->value_type=9;$$->node_name="list";$$->children_number=3;$$->children[0]=$2;$$->children[1]=$3;$$->children[2]=$5;}
    //|  NEW variable_type '['OLD_EXPRESSION_LIST']' {$$=new treenode();$$->value_type=9;$$->node_name="list";$$->children_number=2;$$->children[0]=$2;$$->children[1]=$4;}
    //|  NEW variable_type '['COMMA_exp']'          {$$=new treenode();$$->value_type=9;$$->node_name="list";$$->children_number=2;$$->children[0]=$2;$$->children[1]=$4;}
    //|  NEW variable_type '['']'          {$$=new treenode();$$->value_type=9;$$->node_name="list";$$->children_number=1;$$->children[0]=$2;}
  ;

 //D?3????????????????????????????????????????y????????????o????y????????????
NEW_ELEMENT_ID: ID                                    {
      $$=$1;tempname=$1->value_temp;$$->node_name="ID";
    }
               | '('NEW_ELEMENT')'                     {
               $$=new treenode();
               $$->value_type=9;
               $$->node_name="(NEW_ELEMENT)";
               $$->children_number=1;
               $$->children[0]=$2;
               $$->code_str="("+$2->getre()+")";
               }
             | ID array_dim_opt            {
             tempname=$1->value_temp;
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="ID array_dim_opt";
             $$->children_number=2;
             $$->children[0]=$1;
             $$->children[1]=$2;
             $$->node_type=$1->node_type;
         $$->value_temp=$1->value_temp;
         $$->pointor_number=$1->pointor_number;
         $$->code_str=$1->getre();
             }
             | NEW_ELEMENT_ID'(' IDENTIFIER_LIST ')' {$$=new treenode();$$->value_type=9;$$->node_name="NEW_ELEMENT_ID'(' IDENTIFIER_LIST ')'";$$->children_number=2;$$->children[0]=$1;$$->children[1]=$3;}
             ;

array_dim_opt: '[' ']'  {tempdeep2++;nonum=1;$$=new treenode();$$->value_type=9;$$->node_name="[]";$$->children_number=0;}
             | '[' ']' array_dim {nonum=1;tempdeep2++;$$=new treenode();$$->value_type=9;$$->node_name="'[' ']' array_dim";$$->children_number=1;$$->children[0]=$3;}
             | array_dim{$$=$1;}
             | error ';'{
                   printf("line %d: ", line);
                   printf("multidimensional array must have bounds for all dimensions except the first\n");
             }
             | error '='{
                   printf("line %d: ", line);
                   printf("multidimensional array must have bounds for all dimensions except the first\n");
             }
             ;
             
array_dim: '['condition_exp ']' 
{
    tempdeep2++;
    if($2->value_type==1)
    row[rownum]=$2->value_int;
    else if($2->value_type==2||$2->value_type==3)
    row[rownum]=$2->value_float;
    else row[rownum]=$2->value_temp;
    rownum++;
    $$=new treenode();
    $$->value_type=9;
    $$->node_name="[condition_exp]";
    $$->children_number=1;
    $$->children[0]=$2;
    }
         |  array_dim '[' condition_exp ']'  
         {
             tempdeep2++;
             if($3->value_type==1)
             row[rownum]=$3->value_int;
             else if($3->value_type==2||$3->value_type==3)
             row[rownum]=$3->value_float;
             else row[rownum]=$3->value_temp;
             rownum++;
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="array_dim [COUNTINTNUM]";
             $$->children_number=2;
             $$->children[0]=$1;
             $$->children[1]=$3;
         }
         ;         
             
IDENTIFIER_LIST: ID {
            $$=$1;
      $$->node_type = $$->findtype();
      $$->pointor_number=$$->findpointordeep();
      $$->array_number = $$->findarraydeep();
            $$->setarray();
      $$->node_name="ID";
      if($$->node_type==-1||$$->pointor_number==-1||$$->array_number==-1){
        cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
      }else{
        //tostring($$->value_temp);
        //cout<<"(node_type,pointor_number,array_number):"<<$$->node_type<<","<<$$->pointor_number<<","<<$$->array_number;
      }
                    //cout<<$1->value_name<<"i_l";
                }
                | IDENTIFIER_LIST ',' ID{
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="LIST";
          $$->children_number=2;
          $$->children[0]=$1;
          $$->children[1]=$3;
          $3->node_type = $3->findtype();
          $3->pointor_number=$3->findpointordeep();
          $3->array_number = $3->findarraydeep();
          $3->node_name="ID";
          if($3->node_type==-1||$3->pointor_number==-1||$3->array_number==-1){
            cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
          }else{
            //tostring($3->value_temp);
            //cout<<"(node_type,pointor_number,array_number):"<<$3->node_type<<","<<$3->pointor_number<<","<<$3->array_number;
          }
        }
                ;
descriptive_statement: ';'{
    $$=new treenode();
    }     
  | COMMA_exp ';'{$$=$1;}
  ;
COMMA_exp: Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="list";
        $$->children_number=1;
        $$->children[0]=$1;
        $$->node_type=$1->node_type;
        $$->copyarray($1);
        $$->array_number=$1->array_number;
        $$->pointor_number=$1->pointor_number;
        $$->maxlabel=$1->maxlabel;
        $$->minlabel=$1->minlabel;
        $$->four=$1->four;
        $$->four->result=$1->getre();
        $$->value_temp=$1->value_temp;
        $$->code_str=$1->getre();
        //cout<<"commaset   re"<<$1->getre()<<"and$$re"<<$$->four->result<<endl;
    }
  | COMMA_exp ',' Assign_exp 
    {
        $$=$1;
        $$->children[$$->children_number]=$3;
        $$->children_number++;
        $$->array_number=0;
        $$->pointor_number=0;
        $$->node_type=0;
        if(firstparam==0){
      $$->setarg($$,1);
      //$$->setre(rt++);
      $$->setopr(",");
      $$->setlabel(labelnum++);
      list[listnum++]=*($$->four);
      firstparam=1;
      commamin=$$->minlabel;
      $$->code_str=$$->getre();
        }
        $$->setarg($3,1);
        //$$->setre(rt++);
    $$->setopr(",");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
    $$->maxlabel=$3->maxlabel;
        $$->minlabel=commamin;
        $$->code_str+=",";
        $$->code_str+=$3->getre();
    }
  ;
Assign_exp: condition_exp  {$$=$1;}
  | condition_exp '=' Assign_exp       
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->value_temp = $1->value_temp;
		if($1->node_name=="'(' COMMA_exp')'"&&$3->node_name=="'(' COMMA_exp')'"){
						$$->setre($1->code_str);
						$$->four->setarg1($3->code_str);
						$$->setopr("=");
						$$->setlabel(labelnum++);
						list[listnum++]=*($$->four);
						list[listnum-1].re_type=temptype;
						$$->maxlabel=labelnum-1;
						$$->minlabel=labelnum-1;
					}
		else if($1->node_name=="'(' COMMA_exp')'"){
						$$->setre($1->code_str);
						$$->setarg($3,1);
						$$->setopr("=");
						$$->setlabel(labelnum++);
						list[listnum++]=*($$->four);
						list[listnum-1].re_type=temptype;
						$$->maxlabel=labelnum-1;
						$$->minlabel=labelnum-1;
					}else if($3->node_name=="'(' COMMA_exp')'"){
						$$->setre($1->getre());
						$$->four->setarg1($3->code_str);
						$$->setopr("=");
						$$->setlabel(labelnum++);
						list[listnum++]=*($$->four);
						list[listnum-1].re_type=temptype;
						$$->maxlabel=labelnum-1;
						$$->minlabel=labelnum-1;
					}
		else{
			$$->setre($1->getre());
			$$->setarg($3,1);
			$$->setopr("=");
			$$->setlabel(labelnum++);
			list[listnum++]=*($$->four);
		    $$->maxlabel=labelnum-1;
			$$->minlabel=labelnum-1;
		}
        //cout<<"equal====="<<$1->node_name<<"======="<<$3->node_name<<endl;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
    if($1->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$1->node_name!="MUL SEN_ELEM_EXP"&&$1->value_type!=5&&$1->node_name!="DP SEN_ELEM_EXP"&&$1->node_name!="DD SEN_ELEM_EXP"&&$1->node_name!="list"){
            cout<<$1->value_type<<endl;
            cout<<"error left value:line"<<line<<"equal"<<endl;
    }else if($1->node_name=="list"){
      treenode* listtmp=$1->children[$1->children_number-1];
      if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
        cout<<"error left value:line"<<line<<"sen_elem_exp ++"<<endl;
      }
    }else if(($$->children[1]->node_name == "SEN_ELEM_EXP (COMMA_exp)" || $$->children[1]->node_name == "SEN_ELEM_EXP ()")){
            if($1->array_number+$1->pointor_number!=$3->array_number+$3->pointor_number)
            cout<<"error "<<line<<"equal"<<endl;
        }
    else if($1->node_type==11){
      if(($3->pointor_number+$3->array_number)==0||$3->node_name=="POINTER ID"||$3->node_name=="ID'(' PARAMETER_LIST ')'"||$3->node_name=="ID'('')'"||$3->node_name=="ID"||$3->node_name=="ID array_dim_opt"){
        $$->node_type=$3->node_type;
        $$->pointor_number = $3->pointor_number;
        $$->array_number = $3->array_number;
      }
      else{
        cout<<"error line"<<line<<":auto?T????????????D????a??"<<endl;
      }
    }
    else{
            if($1->array_number!=0){
                cout<<"line"<<"  "<<line<<" "<<"array can't be give value"<<endl;
            }
      else if($1->pointor_number!=($3->pointor_number+$3->array_number)){
        cout<<"line"<<"  "<<line<<" "<<"array suit problem"<<endl;
      }else if($1->pointor_number!=0 && $1->node_type!=$3->node_type){
        cout<<"line"<<"  "<<line<<" "<<"can't change"<<endl;
      }else if($1->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$1->node_name!="MUL SEN_ELEM_EXP"&&$1->value_type!=5&&$1->node_name!="DP SEN_ELEM_EXP"&&$1->node_name!="DD SEN_ELEM_EXP"&&$1->node_name!="list"){
        cout<<"left value lines"<<line<<endl;
      }
    }
        if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=$1->value_type;
                    $$->value_int=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=$1->value_type;
                    $$->value_int=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=$1->value_type;
                    $$->value_int=$3->value_temp;
                    cout<<$3->value_temp<<endl;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=$1->value_type;
                    $$->value_float=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=$1->value_type;
                    $$->value_float=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=$1->value_type;
                    $$->value_float=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=$1->value_type;
                    $$->value_temp=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=$1->value_type;
                    $$->value_temp=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=$1->value_type;
                    $$->value_temp=$3->value_temp;
                }
                $$->node_type=$$->value_type;
        }
    }
  | condition_exp MUL_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="MUL_EQUAL";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("*=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "error mulequal"<<" line "<<line<<endl;
    }
    else {
        $$->node_type = maxtype($1->node_type,$3->node_type);
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
        if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int*=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int*=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int*=$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float*=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float*=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float*=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp*=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp*=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp*=$3->value_temp;
                }
        }
    }
  | condition_exp DIV_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="DIV_Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("/=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "error divequal "<<"line "<<line<<endl;
    }
    else {
        $$->node_type = maxtype($1->node_type,$3->node_type);
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
        if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int/=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int/=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int/=$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float/=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float/=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float/=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp/=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp/=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp/=$3->value_temp;
                }
        }
    }
  |condition_exp MOD_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="MOD_Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        int k=maxtype(1,$1->node_type);
        k=maxtype(1,k);
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("%=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if(k!=1){
            cout << "error modequal lines "<<line<<endl;
        }
        else{
            if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "error modequal lines "<<line<<endl;
    }
    else {
        $$->node_type =1;
        $$->pointor_number = 0;
        $$->array_number = 0;
    }   
        }
        if($1->value_type==1){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_int%=$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_int%=$3->value_temp;
                    }
                }
                if($1->value_type==4||$1->value_type==10){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp%=$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp%=$3->value_temp;
                    }
                }
    }
  | condition_exp ADD_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="ADD_Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("+=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if($1->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$1->node_name!="MUL SEN_ELEM_EXP"&&$1->value_type!=5&&$1->node_name!="DP SEN_ELEM_EXP"&&$1->node_name!="DD SEN_ELEM_EXP"&&$1->node_name!="list"){
            cout<<$1->value_type<<endl;
            cout<<"error left value:line"<<line<<"equal"<<endl;
    }else if($1->node_name=="list"){
          treenode* listtmp=$1->children[$1->children_number-1];
          if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
            cout<<"error left value:line"<<line<<"+="<<endl;
    }
    }else if (($1->pointor_number+$1->array_number) != 0 && ($3->pointor_number+$3->array_number) != 0) {
        cout << "      error addequal";
    }else if($1->array_number!=0){
          cout<<"error line:"<<line<<"array can not +="<<endl;
    }else {
        $$->node_type = maxtype($1->node_type,$3->node_type);
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
        if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int+=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int+=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int+=$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float+=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float+=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float+=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp+=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp+=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp+=$3->value_temp;
                }
        }
    }
  | condition_exp SUB_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="SUB_Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("-=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if($1->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$1->node_name!="MUL SEN_ELEM_EXP"&&$1->value_type!=5&&$1->node_name!="DP SEN_ELEM_EXP"&&$1->node_name!="DD SEN_ELEM_EXP"&&$1->node_name!="list"){
            cout<<$1->value_type<<endl;
            cout<<"error left value:line"<<line<<"equal"<<endl;
    }else if($1->node_name=="list"){
          treenode* listtmp=$1->children[$1->children_number-1];
          if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
            cout<<"error left value:line"<<line<<"-="<<endl;
    }
    }else if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "      error subequal";
    }else if($1->array_number!=0){
          cout<<"error line:"<<line<<"array can not -="<<endl;
    }else {
        $$->node_type = maxtype($1->node_type,$3->node_type);
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
        if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int-=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int-=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int-=$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float-=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float-=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float-=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp-=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp-=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp-=$3->value_temp;
                }
        }
    }
  | condition_exp DLE       Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="DL";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("<<=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "      error dleequal";
    }
    else {
        $$->node_type = $1->node_type;
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
    }
  | condition_exp DRE       Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="DR";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr(">>=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "      error dreequal";
    }
    else {
        $$->node_type = $1->node_type;
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
    }
  | condition_exp AND_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="AND_Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("&=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "      error andequal";
    }
    else {
        $$->node_type = $1->node_type;
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
    }
  | condition_exp XOR_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="XOR_Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("^=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "      error xorequal";
    }
    else {
        $$->node_type = $1->node_type;
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
    }
  | condition_exp OR_EQUAL Assign_exp 
    {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="OR_Equal";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setre($1->getre());
        $$->setarg($3,1);
    $$->setopr("|=");
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        cout << "      error orequal";
    }
    else {
        $$->node_type = $1->node_type;
        $$->pointor_number = 0;
        $$->array_number = 0;
    }
    }
  ;
condition_exp: logical_OR_exp{$$=$1;}
  | logical_OR_exp '?' COMMA_exp ':' condition_exp
  {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="logical_OR_exp '?' COMMA_exp ':' condition_exp";
        $$->children_number=3;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->children[2]=$5;
        if (($3->pointor_number+$3->array_number) != ($5->pointor_number+$5->array_number)) {
        cout << "       error logical";
      }
      else {
        if ($$->children[1]->node_type != $$->children[2]->node_type) {
                    if(($3->pointor_number+$3->array_number)!=0){
                        cout<<"          error logic"<<endl;
                    }
          else {
            $$->node_type = maxtype($$->children[1]->node_type, $$->children[2]->node_type);
            $$->pointor_number = 0;
            $$->array_number = 0;
          }
        }
        else {
          $$->node_type = $$->children[1]->node_type;
          $$->pointor_number = $$->children[1]->pointor_number;
          $$->array_number = $3->array_number;
        }
      }
    }
    ;
  
logical_OR_exp: logical_AND_exp{$$=$1;}
  | logical_OR_exp OR logical_AND_exp {
    $$=new treenode();
    $$->value_type=9;
    $$->node_name="OR";
    $$->children_number=2;
    $$->children[0]=$1;
    $$->children[1]=$3;
    $$->node_type=10;
        $$->setarg($1,1);
        $$->setarg($3,2);
    $$->setopr("||");
    $$->setre(rt++);
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
    list[listnum-1].re_type=$$->node_type;
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int||$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int||$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int||$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float||$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float||$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float||$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp||$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp||$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp||$3->value_temp;
                }
        }
  }
  ;

logical_AND_exp: OR_exp          {$$=$1;}
  | logical_AND_exp AND OR_exp {
    $$=new treenode();
    $$->value_type=9;
    $$->node_name="AND";
    $$->children_number=2;
    $$->children[0]=$1;
    $$->children[1]=$3;
    $$->node_type=10;
    $$->setarg($1,1);
        $$->setarg($3,2);
    $$->setopr("&&");
    $$->setre(rt++);
    $$->setlabel(labelnum++);
    list[listnum++]=*($$->four);
    list[listnum-1].re_type=$$->node_type;
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int&&$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int&&$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int&&$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float&&$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float&&$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float&&$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp&&$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp&&$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp&&$3->value_temp;
                }
        }
  }
  ;     
OR_exp: EXC_OR_exp{$$=$1;}
  | OR_exp '|' EXC_OR_exp{
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="|";
          $$->children_number=2;
          $$->children[0]=$1;
          $$->children[1]=$3;
          int k = maxtype($1->node_type, 1);
          k = maxtype($3->node_type, k);
          $$->setarg($1,1);
          $$->setarg($3,2);
          $$->setopr("|");
          $$->setre(rt++);
          $$->setlabel(labelnum++);
          list[listnum++]=*($$->four);
          list[listnum-1].re_type=1;
          $$->maxlabel=labelnum-1;
          $$->minlabel=labelnum-1;
          if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		  }
		  if($1->minlabel<$$->minlabel){
		  	$$->minlabel=$1->minlabel;
		  }
          if (k != 1 || ($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
            cout <<"error line "<<line<< ":|"<<endl;
          }
          else{
            $$->node_type = 1;
            $$->pointor_number = 0;
            $$->array_number = 0;
          }
            if($1->value_type==1){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_int|$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_int|$3->value_temp;
                    }
                }
                if($1->value_type==4||$1->value_type==10){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp|$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp|$3->value_temp;
                    }
                }
  }
  ;
EXC_OR_exp: AND_exp{$$=$1;}
  |EXC_OR_exp '^' AND_exp{
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="^";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        int k = maxtype($1->node_type, 1);
        k = maxtype($3->node_type, k);
        $$->setarg($1,1);
        $$->setarg($3,2);
        $$->setopr("^");
        $$->setre(rt++);
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        list[listnum-1].re_type=1;
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (k != 1 || ($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
          cout <<"error line"<<line<< ":^"<<endl;
        }
        else{
          $$->node_type = 1;
          $$->pointor_number = 0;
          $$->array_number = 0;
        }
                if($1->value_type==1){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_int^$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_int^$3->value_temp;
                    }
                }
                if($1->value_type==4||$1->value_type==10){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp^$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp^$3->value_temp;
                    }
                }
  }
  ;
AND_exp: AND_exp LA EQ_EXP {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="&";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        int k = maxtype($1->node_type, 1);
        k = maxtype($3->node_type, k);
        $$->setarg($1,1);
        $$->setarg($3,2);
        $$->setopr("&");
        $$->setre(rt++);
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        list[listnum-1].re_type=1;
        $$->maxlabel=labelnum-1;
        $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (k != 1 || ($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
          cout <<"error line "<<line<< "&"<<endl;
        }
        else {
          $$->node_type = 1;
          $$->pointor_number = 0;
          $$->array_number = 0;
        }
                if($1->value_type==1){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_int&$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_int&$3->value_temp;
                    }
                }
                if($1->value_type==4||$1->value_type==10){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp&$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp&$3->value_temp;
                    }
                }
  }
  | EQ_EXP {$$=$1;}
  ;
EQ_EXP: COMP_EXP                         {
       $$=$1;}
      | EQ_EXP EQ COMP_EXP               
      {
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="EQ";
          $$->children_number=2;
          $$->children[0]=$1;
          $$->children[1]=$3;
          $$->node_type=10;
          $$->setarg($1,1);
      $$->setarg($3,2);
      $$->setopr("==");
      $$->setre(rt++);
      $$->setlabel(labelnum++);
      list[listnum++]=*($$->four);
      list[listnum-1].re_type=$$->node_type;
          $$->maxlabel=labelnum-1;
          $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        cout<<"encouter =="<<"$1min"<<$1->minlabel<<"$3min"<<$3->minlabel<<"$$min"<<$$->minlabel<<endl;
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        if(!$1->ifcompare($3))
                cout<<"error can't compare line "<<line<<endl;
                else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
                }
      }
         else{
      $$->node_type = 10;
      $$->pointor_number = 0;
      $$->array_number = 0;
         }
           if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int==$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int==$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int==$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float==$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float==$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float==$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp==$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp==$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=($1->value_temp==$3->value_temp);
                }
        }
    }
      | EQ_EXP NE COMP_EXP               
      {
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="EQ";
          $$->children_number=2;
          $$->children[0]=$1;
          $$->children[1]=$3;
          $$->node_type=10;
          $$->setarg($1,1);
      $$->setarg($3,2);
      $$->setopr("!=");
      $$->setre(rt++);
      $$->setlabel(labelnum++);
      list[listnum++]=*($$->four);
      list[listnum-1].re_type=$$->node_type;
          $$->maxlabel=labelnum-1;
          $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
          if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        if(!$1->ifcompare($3))
                cout<<"error can't compare line "<<line<<endl;
                else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
                }
      }
         else{
      $$->node_type = 10;
      $$->pointor_number = 0;
      $$->array_number = 0;
         }
           if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int!=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int!=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int!=$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float!=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float!=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float!=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp!=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp!=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp!=$3->value_temp;
                }
        }
      }
      ;

COMP_EXP: MOVE_EXP                         
        {
         $$=$1;
         }
        | COMP_EXP '>' MOVE_EXP            
        {
            $$=new treenode();
            $$->value_type=9;
            $$->node_name="Larger";
            $$->children_number=2;
            $$->children[0]=$1;
            $$->children[1]=$3;
            $$->setarg($1,1);
      $$->setarg($3,2);
      $$->setopr(">");
      $$->setre(rt++);
      $$->setlabel(labelnum++);
      list[listnum++]=*($$->four);
      list[listnum-1].re_type=10;
          $$->maxlabel=labelnum-1;
          $$->minlabel=labelnum-1;
          if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
            if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        if(!$1->ifcompare($3))
                cout<<"error can't compare line "<<line<<endl;
                else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
                }
      }
      else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
      }
             if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int>$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int>$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int>$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float>$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float>$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float>$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp>$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp>$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp>$3->value_temp;
                }
        }
        }
        | COMP_EXP '<' MOVE_EXP            
          {
            $$=new treenode();
            $$->value_type=9;
            $$->node_name="Small";
            $$->children_number=2;
            $$->children[0]=$1;
            $$->children[1]=$3;
            $$->setarg($1,1);
        $$->setarg($3,2);
        $$->setopr("<");
        $$->setre(rt++);
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        list[listnum-1].re_type=10;
            $$->maxlabel=labelnum-1;
            $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
		cout<<"encouter<min"<<$$->minlabel<<"max"<<$$->maxlabel<<endl;
            if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        if(!$1->ifcompare($3))
                cout<<"error can't compare line "<<line<<endl;
                else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
                }
      }
      else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
      }
             if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int<$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int<$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int<$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float<$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float<$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float<$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp<$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp<$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp<$3->value_temp;
                }
        }
        }
        | COMP_EXP LE MOVE_EXP             
          {
            $$=new treenode();
            $$->value_type=9;
            $$->node_name="LE";
            $$->children_number=2;
            $$->children[0]=$1;
            $$->children[1]=$3;
            $$->setarg($1,1);
        $$->setarg($3,2);
        $$->setopr("<=");
        $$->setre(rt++);
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        list[listnum-1].re_type=10;
            $$->maxlabel=labelnum-1;
            $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
            if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        if(!$1->ifcompare($3))
                cout<<"error can't compare line "<<line<<endl;
                else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
                }
      }
      else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
      }
             if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int<=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int<=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int<=$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float<=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float<=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float<=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp<=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp<=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp<=$3->value_temp;
                }
        }
            }
        | COMP_EXP RE MOVE_EXP             
        {
            $$=new treenode();
            $$->value_type=9;
            $$->node_name="RE";
            $$->children_number=2;
            $$->children[0]=$1;
            $$->children[1]=$3;
            $$->setarg($1,1);
        $$->setarg($3,2);
        $$->setopr(">=");
        $$->setre(rt++);
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
        list[listnum-1].re_type=10;
            $$->maxlabel=labelnum-1;
            $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
            if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
        if(!$1->ifcompare($3))
                cout<<"error can't compare line "<<line<<endl;
                else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
                }
      }
      else {
        $$->node_type = 10;
        $$->pointor_number = 0;
        $$->array_number = 0;
      }
             if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int>=$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int>=$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_int>=$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float>=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float>=$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_float>=$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp>=$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp>=$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=10;
                    $$->value_temp=$1->value_temp>=$3->value_temp;
                }
        }
        }
        ;

MOVE_EXP: EASY_OPE_EXP                     
        {
             $$=$1;
        }
        | MOVE_EXP DL EASY_OPE_EXP         {
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="DL";
          $$->children_number=2;
          $$->children[0]=$1;
          $$->children[1]=$3;
          $$->setarg($1,1);
          $$->setarg($3,2);
          $$->setopr("<<");
          $$->setre(rt++);
          $$->setlabel(labelnum++);
          list[listnum++]=*($$->four);
          list[listnum-1].re_type=1;
          $$->maxlabel=labelnum-1;
          $$->minlabel=labelnum-1;
          if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
          int k = maxtype($1->node_type, 1);
          k = maxtype($3->node_type, k);
          if (k != 1 || ($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
            cout <<"line"<<line<< ":<< "<<endl;
          }
          else{
            $$->node_type = 1;
            $$->pointor_number = 0;
            $$->array_number = 0;
          }
                if($1->value_type==1){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=($1->value_int<<$3->value_int);
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_int<<$3->value_temp;
                    }
                }
                if($1->value_type==4||$1->value_type==10){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp<<$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp<<$3->value_temp;
                    }
                }
    }
        | MOVE_EXP DR EASY_OPE_EXP         {
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="DR";
          $$->children_number=2;
          $$->children[0]=$1;
          $$->children[1]=$3;
          int k = maxtype($1->node_type, 1);
          k = maxtype($3->node_type, k);
          $$->setarg($1,1);
          $$->setarg($3,2);
          $$->setopr(">>");
          $$->setre(rt++);
          $$->setlabel(labelnum++);
          list[listnum++]=*($$->four);
          list[listnum-1].re_type=1;
          $$->maxlabel=labelnum-1;
          $$->minlabel=labelnum-1;
          if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
          if (k != 1 || ($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0) {
            cout <<"line"<<line<< ":>>";
          }
          else{
            $$->node_type = 1;
            $$->pointor_number = 0;
            $$->array_number = 0;
          }
                if($1->value_type==1){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_int>>$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_int>>$3->value_temp;
                    }
                }
                if($1->value_type==4||$1->value_type==10){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp>>$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp>>$3->value_temp;
                    }
                }
    }
        ;
    
EASY_OPE_EXP: EASY_OPE_EXP ADD COM_OPE_EXP     {
                     $$=new treenode();
                     $$->value_type=9;
                     $$->node_name="ADD";
                     $$->children_number=2;
                     $$->children[0]=$1;
                     $$->children[1]=$3;
                     $$->setarg($1,1);
                     $$->setarg($3,2);
                     $$->setopr("add");
                     $$->setre(rt++);
                     $$->setlabel(labelnum++);
                     list[listnum++]=*($$->four);
                     $$->maxlabel=labelnum-1;
                     $$->minlabel=labelnum-1;
                     if($3->minlabel<$$->minlabel){
						$$->minlabel=$3->minlabel;
					}
					if($1->minlabel<$$->minlabel){
						$$->minlabel=$1->minlabel;
					}
                     if (($1->pointor_number+$1->array_number) != 0 && ($3->pointor_number+$3->array_number) != 0){
                  cout <<"line"<<line<< ":add";
               }else{
            if (($1->pointor_number+$1->array_number) == 0){
              if (($3->pointor_number+$3->array_number) == 0){
                                //cout<<"before add"<<endl;
                                //cout<<$1->node_type<<endl;
                                //cout<<$3->node_type<<endl;
                $$->node_type = maxtype($1->node_type, $3->node_type);
                                //cout<<$$->node_type<<endl;
                                //cout<<"before add"<<endl;
                $$->pointor_number = 0;
                $$->array_number = 0;
              }
              else{
                $$->node_type = $3->node_type;
                $$->pointor_number = $3->pointor_number;
                $$->array_number = $3->array_number;
                                $$->copyarray($3);
              }
            }
            else{
              $$->node_type = maxtype($1->node_type,$3->node_type);
              $$->pointor_number = $1->pointor_number;
              $$->array_number = $1->array_number;
                            $$->copyarray($1);
            }
          }
            if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_int+$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_int+$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_int+$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float+$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float+$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float+$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp+$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_temp+$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp+$3->value_temp;
                }
        }
            //cout<<"add"<<endl;
            //cout<<$$->value_int<<" "<<$1->value_int<<" "<<$3->value_int;
            //cout<<$$->node_type<<endl;
            //cout<<"addend"<<endl;
            list[listnum-1].re_type=$$->node_type;
             }
             | EASY_OPE_EXP SUB COM_OPE_EXP     {
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="SUB";
          $$->children_number=2;
          $$->children[0]=$1;
          $$->children[1]=$3;
          $$->setarg($1,1);
                     $$->setarg($3,2);
                     $$->setopr("sub");
                     $$->setre(rt++);
                     $$->setlabel(labelnum++);
                     list[listnum++]=*($$->four);
                     $$->maxlabel=labelnum-1;
                     $$->minlabel=labelnum-1;
                     if($3->minlabel<$$->minlabel){
						$$->minlabel=$3->minlabel;
					}
					if($1->minlabel<$$->minlabel){
						$$->minlabel=$1->minlabel;
					}
          if (($1->pointor_number+$1->array_number) != 0 && ($3->pointor_number+$3->array_number) != 0){
                  cout <<"line"<<line<< ":sub";
               }else{
            if (($1->pointor_number+$1->array_number) == 0){
              if (($3->pointor_number+$3->array_number) == 0){
                $$->node_type = maxtype($1->node_type, $3->node_type);
                $$->pointor_number = 0;
                $$->array_number = 0;
              }
              else{
                $$->node_type = $3->node_type;
                $$->pointor_number = $3->pointor_number;
                $$->array_number = $3->array_number;
              }
            }
            else{
              $$->node_type = maxtype($1->node_type,$3->node_type);
              $$->pointor_number = $1->pointor_number;
              $$->array_number = $1->array_number;
            }
          }
                if(($1->pointor_number+$1->array_number)==0&&($3->pointor_number+$3->array_number)==0){
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_int-$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_int-$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_int-$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float-$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float-$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float-$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp-$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_temp-$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp-$3->value_temp;
                }
        }
        list[listnum-1].re_type=$$->node_type;
             }
             | COM_OPE_EXP                      {$$=$1;}
             ;
COM_OPE_EXP: COM_OPE_EXP MUL SEN_ELEM_EXP     {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="MUL";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setarg($1,1);
                $$->setarg($3,2);
                $$->setopr("mul");
                $$->setre(rt++);
                $$->setlabel(labelnum++);
                list[listnum++]=*($$->four);
                $$->maxlabel=labelnum-1;
                $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) !=0|| ($3->pointor_number+$3->array_number)!=0 ){
          cout <<"line"<<line<< ":mul";
        }
        else{
          $$->node_type = maxtype($1->node_type,$3->node_type);
          $$->pointor_number = 0;
          $$->array_number = 0;
        }
                 if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_int*$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_int*$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_int*$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float*$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float*$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float*$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp*$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$2->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_temp*$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp*$3->value_temp;
                }
                list[listnum-1].re_type=$$->node_type;
      }
             | COM_OPE_EXP DIV SEN_ELEM_EXP     {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="DIV";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setarg($1,1);
                $$->setarg($3,2);
                $$->setopr("div");
                $$->setre(rt++);
                $$->setlabel(labelnum++);
                list[listnum++]=*($$->four);
                $$->maxlabel=labelnum-1;
                $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) !=0|| ($3->pointor_number+$3->array_number)!=0 ){
          cout <<"line"<<line<< ":div";
        }
        else{
          $$->node_type = maxtype($1->node_type,$3->node_type);
          $$->pointor_number = 0;
          $$->array_number = 0;
        }
                if($1->value_type==1&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_int/$3->value_int;
                }
                else if($1->value_type==1&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_int/$3->value_float;
                }
                else if($1->value_type==1&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_int/$3->value_temp;
                }
                else if($3->value_type==1&&($1->value_type==2||$1->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float/$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float/$3->value_int;
                }
                else if(($1->value_type==2||$1->value_type==3)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=2;
                    $$->value_float=$1->value_float/$3->value_temp;
                }
                else if(($1->value_type==4||$1->value_type==10)&&$3->value_type==1){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp/$3->value_int;;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==2||$3->value_type==3)){
                    $$->value_type=2;
                    $$->value_float=$1->value_temp/$3->value_float;
                }
                else if(($1->value_type==4||$1->value_type==10)&&($3->value_type==4||$3->value_type==10)){
                    $$->value_type=1;
                    $$->value_int=$1->value_temp/$3->value_temp;
                }
                list[listnum-1].re_type=$$->node_type;
      }
             | SEN_ELEM_EXP                     {$$=$1;}
             | COM_OPE_EXP '%' ELEM_EXP         {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="MOD";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$3;
        $$->setarg($1,1);
                $$->setarg($3,2);
                $$->setopr("mod");
                $$->setre(rt++);
                $$->setlabel(labelnum++);
                list[listnum++]=*($$->four);
                $$->maxlabel=labelnum-1;
                $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
        if (($1->pointor_number+$1->array_number) != 0 || ($3->pointor_number+$3->array_number) != 0){
          cout <<"line"<<line<< ":mod";
        }else{
          if ($1->node_type == 2 || $1->node_type == 3 || $3->node_type == 2 || $3->node_type == 3){
            cout <<"line"<<line<< ":float/double?";
          }
          else{
            $$->node_type = 1;
            $$->pointor_number = 0;
            $$->array_number = 0;
          }
        }
                if($1->value_type==1){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_int%$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_int%$3->value_temp;
                    }
                }
                if($1->value_type==4||$1->value_type==10){
                    if($3->value_type==1){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp%$3->value_int;
                    }
                    else if($3->value_type==4||$3->value_type==10){
                        $$->value_type=1;
                        $$->value_int=$1->value_temp%$3->value_temp;
                    }
                }
                list[listnum-1].re_type=$$->node_type;
      }
             ;
SEN_ELEM_EXP: ELEM_EXP                         {$$=$1;}
             | '(' COMMA_exp')'                 
             {
                 $$=$2;
                 $$->code_str="("+$2->code_str+")";
                 $$->node_name="'(' COMMA_exp')'";
                 cout<<"'(' COMMA_exp')'"<<$$->code_str<<endl;
             }
             | SEN_ELEM_EXP DP                  
             {
               $$=new treenode();
               $$->value_type=9;
               $$->node_name="SEN_ELEM_EXP DP";
               $$->children_number=1;
               $$->children[0]=$1;
               $$->node_type = $1->node_type;
         $$->pointor_number =$1->pointor_number;
         $$->array_number ==$1->array_number;
         $$->setarg($1,1);
               $$->setopr("xdp");
               $$->setre(rt++);
               $$->setlabel(labelnum++);
               $$->minlabel=labelnum-1;
               $$->maxlabel=labelnum-1;
               if($1->minlabel<$$->minlabel){
					$$->minlabel=$1->minlabel;
               }
               //printf("sth ++minlabel%d",$$->minlabel);
               //printf("sth ++maxlabel%d\n",$$->maxlabel);
         list[listnum++]=*($$->four);
         list[listnum-1].re_type=$$->node_type;
         if($1->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$1->node_name!="MUL SEN_ELEM_EXP"&&$1->value_type!=5&&$1->node_name!="DP SEN_ELEM_EXP"&&$1->node_name!="DD SEN_ELEM_EXP"&&$1->node_name!="list"){
            cout<<$1->value_type<<endl;
            cout<<"error left value:line"<<line<<"equal"<<endl;
        }else if($1->node_name=="list"){
          treenode* listtmp=$1->children[$1->children_number-1];
          if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
            cout<<"error left value:line"<<line<<"sen_elem_exp ++"<<endl;
          }
        }else if($1->array_number!=0){
          cout<<"error line:"<<line<<"array can not ++"<<endl;
          }
              }
             | SEN_ELEM_EXP DD                  
             {
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="SEN_ELEM_EXP DD";
             $$->children_number=1;
             $$->children[0]=$1;
             $$->node_type = $1->node_type;
       $$->pointor_number =$1->pointor_number;
       $$->array_number ==$1->array_number;
       $$->setarg($1,1);
             $$->setopr("xdd");
             $$->setre(rt++);
             $$->setlabel(labelnum++);
       list[listnum++]=*($$->four);
       list[listnum-1].re_type=$$->node_type;
             $$->maxlabel=labelnum-1;
             $$->minlabel=labelnum-1;
			if($1->minlabel<$$->minlabel){
				$$->minlabel=$1->minlabel;
             }
             cout<<"encouter--min"<<$$->minlabel<<"max"<<$$->maxlabel;
       if($1->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$1->node_name!="MUL SEN_ELEM_EXP"&&$1->value_type!=5&&$1->node_name!="DP SEN_ELEM_EXP"&&$1->node_name!="DD SEN_ELEM_EXP"&&$1->node_name!="list"){
            cout<<$1->value_type<<endl;
            cout<<"error left value:line"<<line<<"sen_elem_exp --"<<endl;
      }else if($1->node_name=="list"){
          treenode* listtmp=$1->children[$1->children_number-1];
          if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
            cout<<"error left value:line"<<line<<"sen_elem --"<<endl;
          }
      }else if($1->array_number!=0){
          cout<<"error line:"<<line<<"array can not --"<<endl;
         }
             }
             //| SEN_ELEM_EXP DC SEN_ELEM_EXP     {$$=new treenode();$$->value_type=9;$$->node_name="DC";$$->children_number=2;$$->children[0]=$1;$$->children[1]=$3;}
             | SEN_ELEM_EXP'[' COMMA_exp']'     
             {
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="SEN_ELEM_EXP [COMMA_exp]";
             $$->children_number=2;
             $$->children[0]=$1;
             $$->children[1]=$3;
             $$->node_type = $1->node_type;
       $$->value_temp =$1->value_temp;
       $$->pointor_number=$1->pointor_number;
       $$->array_number=$1->array_number - 1;
             $$->changearray($1);
             $$->setarg($1,1);
             $$->setarg($3,2);
             $$->setopr("=[]");
             $$->setre($1->getre()+"["+$3->children[0]->getre()+"]");
             $$->setlabel(labelnum++);
             list[listnum++]=*($$->four);
             list[listnum-1].re_type=$$->node_type;
             $$->maxlabel=labelnum-1;
             $$->minlabel=labelnum-1;
             if($3->minlabel<$$->minlabel){
				$$->minlabel=$3->minlabel;
			}
			if($1->minlabel<$$->minlabel){
				$$->minlabel=$1->minlabel;
			}
             }
             | SEN_ELEM_EXP '('')'              
             {
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="SEN_ELEM_EXP ()";
             $$->children_number=1;
             $$->children[0]=$1;
             $$->node_type = $1->node_type;
           $$->pointor_number = $1->pointor_number;
           $$->array_number = $1->array_number;
           $$->setarg($1,1);
             $$->setopr("=()");
             $$->setre(rt++);
             $$->setlabel(labelnum++);
             list[listnum++]=*($$->four);
             list[listnum-1].re_type=$$->node_type;
             $$->maxlabel=labelnum-1;
             $$->minlabel=labelnum-1;
             if($1->minlabel<$$->minlabel){
            $$->minlabel=$1->minlabel;
             }
             }
             | SEN_ELEM_EXP '('COMMA_exp')'     
             {
                 $$=new treenode();
                 $$->value_type=9;
                 $$->node_name="SEN_ELEM_EXP (COMMA_exp)";
                 $$->children_number=2;
                 $$->children[0]=$1;$$->children[1]=$3;
                 $$->pointor_number = $1->pointor_number;
               $$->array_number = $1->array_number;
                 $$->node_type=$1->node_type;
                 $$->setarg($1,1);
         $$->setarg($3,2);
         $$->setopr("call");
         $$->setre(rt++);
         $$->setlabel(labelnum++);
         list[listnum++]=*($$->four);
         list[listnum-1].re_type=$$->node_type;
                 $$->maxlabel=labelnum-1;
                 $$->minlabel=labelnum-1;
        if($3->minlabel<$$->minlabel){
			$$->minlabel=$3->minlabel;
		}
		if($1->minlabel<$$->minlabel){
			$$->minlabel=$1->minlabel;
		}
                 firstparam=0;
                 /*if(judg_func($$,0)==0)
        { cout<<"error"<<" "<<line<<" "<<"lines"<<endl;}
                 else if(judg_func($$,0)==2)
                 cout<<"too many function fit"<<" "<<line<<endl;
                 $1->node_type=$$->node_type;*/
            }
             | SEN_ELEM_EXP '.'SEN_ELEM_EXP     {$$=new treenode();$$->value_type=9;$$->node_name=".";$$->children_number=2;$$->children[0]=$1;$$->children[1]=$3;}
             | SEN_ELEM_EXP ARROW SEN_ELEM_EXP  {$$=new treenode();$$->value_type=9;$$->node_name="ARROW";$$->children_number=2;$$->children[0]=$1;$$->children[1]=$3;}
             | '('type_name')'SEN_ELEM_EXP  
             {
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="(type_name)SEN_ELEM_EXP";
             $$->children_number=2;
             $$->children[0]=$2;
             $$->children[1]=$4;
         $$->node_type=$2->node_type;
         $$->pointor_number=$2->pointor_number; 
               if ($$->children[0]->node_name == "INT") {
                    $$->node_type = 1;
                    if($1->value_type<5||$1->value_type==10){
                        $$->value_type==$$->node_type;
                        if($1->value_type==1)
                        $$->value_int=$1->value_int;
                        else if($1->value_type==2||$1->value_type==3)
                        $$->value_int=(int )$1->value_float;
                        else if($1->value_type==4)
                        $$->value_int=(int)$1->value_temp;
                        else if($1->value_type==10)
                        $$->value_int=$1->value_temp;
                        }
                    }
          if ($$->children[0]->node_name == "CHAR") {
          $$->node_type = 4;
                    if($1->value_type<5||$1->value_type==10){
                        $$->value_type==$$->node_type;
                        if($1->value_type==1)
                        $$->value_temp=$1->value_int;
                        else if($1->value_type==2||$1->value_type==3)
                        $$->value_temp=(int)$1->value_float;
                        else if($1->value_type==4)
                        $$->value_temp=(int)$1->value_temp;
                        else if($1->value_type==10)
                        $$->value_temp=$1->value_temp;
                        }
                    }
                if ($$->children[0]->node_name == "flaot") {
                    $$->node_type = 2;
                    if($1->value_type<5||$1->value_type==10){
                        $$->value_type==$$->node_type;
                        if($1->value_type==1)
                        $$->value_float=$1->value_int;
                        else if($1->value_type==2||$1->value_type==3)
                        $$->value_float=$1->value_float;
                        else if($1->value_type==4)
                        $$->value_float=(int)$1->value_temp;
                        else if($1->value_type==10)
                        $$->value_float=$1->value_temp;
                        }
                    }
                if ($$->children[0]->node_name == "double") {
                    $$->node_type = 1;
                     if($1->value_type<5||$1->value_type==10){
                        $$->value_type==$$->node_type;
                        if($1->value_type==1)
                        $$->value_float=$1->value_int;
                        else if($1->value_type==2||$1->value_type==3)
                        $$->value_float=$1->value_float;
                        else if($1->value_type==4)
                        $$->value_float=(int)$1->value_temp;
                        else if($1->value_type==10)
                        $$->value_float=$1->value_temp;
                        }
                    }
                if ($$->children[0]->node_name == "bool") {
                    $$->node_type = 10;
                     if($1->value_type<5||$1->value_type==10){
                        $$->value_type==$$->node_type;
                        if($1->value_type==1)
                        $$->value_temp=(bool)$1->value_int;
                        else if($1->value_type==2||$1->value_type==3)
                        $$->value_temp=(bool)(int)$1->value_float;
                        else if($1->value_type==4)
                        $$->value_temp=1;
                        else if($1->value_type==10)
                        $$->value_temp=$1->value_temp;
                        }
                    }
            }
            
             | SUB SEN_ELEM_EXP %prec UMINUS     
             {
                 $$=new treenode();
                 $$->value_type=9;
                 $$->node_name="-";
                 $$->children_number=1;
                 $$->children[0]=$2;
                 $$->setarg($2,1);
         $$->setopr("-");
         $$->setre(rt++);
         $$->setlabel(labelnum++);
                 list[listnum++]=*($$->four);
                 $$->maxlabel=labelnum-1;
                 $$->minlabel=labelnum-1;
                 if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                     }
                 if($2->value_type==1){
                     $$->value_type=1;
                     $$->value_int=-$2->value_int;
                 }
                 else if($2->value_type==2||$2->value_type==3){
                     $$->value_type=$2->value_type;
                     $$->value_float=-$2->value_float;
                 }
                 else if ($2->value_type==4){
                     $$->value_type=1;
                     $$->value_int=-$2->value_temp;
                 
                 }
                 else if($2->value_type==10){
                     $$->value_type=1;
                     $$->value_int=-$2->value_temp;
                 }
                 $$->node_type=$2->node_type;
                 list[listnum-1].re_type=$$->node_type;
                 cout<<"-type"<<$$->node_type<<endl;
            }
             | ADD SEN_ELEM_EXP %prec UMINUS     
             {
                 $$=new treenode();
                 $$->value_type=9;
                 $$->node_name="+";
                 $$->children_number=1;
                 $$->children[0]=$2;
                 $$->node_type=$2->node_type;
                 $$->setarg($2,1);
         $$->setopr("+");
         $$->setre(rt++);
         $$->setlabel(labelnum++);
                 list[listnum++]=*($$->four);
                 $$->maxlabel=labelnum-1;
                 $$->minlabel=labelnum-1;
                 if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                 }
                  if($2->value_type==1){
                      $$->node_type=1;
                     $$->value_type=1;
                     $$->value_int=abs($2->value_int);
                 }
                 else if($2->value_type==2||$2->value_type==3){
                     $$->node_type=$2->node_type;
                     $$->value_type=$2->value_type;
                     $$->value_float=fabs((float)$2->value_float);
                 }
                 else if ($2->value_type==4){
                     $$->node_type=1;
                     $$->value_type=1;
                     $$->value_int=fabs((float)$2->value_temp);
                 
                 }
                 else if($2->value_type==10){
                     $$->node_type=1;
                     $$->value_type=1;
                     $$->value_int=fabs((float)$2->value_temp);
                 }
                 list[listnum-1].re_type=$$->node_type;
            }
             | LA SEN_ELEM_EXP %prec NOT        {
          $$=new treenode();
          $$->value_type=9;
          $$->node_name="&";
          $$->children_number=1;
          $$->children[0]=$2;
          $$->node_type = $2->node_type;
          $$->value_temp =$2->value_temp;
          $$->pointor_number = $2->pointor_number+1;
          $$->setarg($2,1);
            $$->setopr("&x");
            $$->setre(rt++);
            $$->setlabel(labelnum++);
          list[listnum++]=*($$->four);
          list[listnum-1].re_type=$$->node_type;
                    $$->maxlabel=labelnum-1;
                    $$->minlabel=labelnum-1;
                    if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                     }
          if($2->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$2->node_name!="MUL SEN_ELEM_EXP"&&$2->value_type!=5&&$2->node_name!="DP SEN_ELEM_EXP"&&$2->node_name!="DD SEN_ELEM_EXP"&&$1->node_name!="list"){
            //cout<<$1->value_type<<endl;
            cout<<"error left value:line"<<line<<"equal"<<endl;
          }else if($2->node_name=="list"){
            treenode* listtmp=$2->children[$2->children_number-1];
            if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
              cout<<"error left value:line"<<line<<"&"<<endl;
            }
          }
      }
             | '~' SEN_ELEM_EXP                  {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="~";
        $$->children_number=1;
        $$->children[0]=$2;
        $$->setarg($2,1);
        $$->setopr("~");
        $$->setre(rt++);
        $$->setlabel(labelnum++);
        list[listnum++]=*($$->four);
                $$->maxlabel=labelnum-1;
                $$->minlabel=labelnum-1;
                if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                     }
        int k = maxtype($2->node_type, 1);
        if (k != 1 || ($2->pointor_number+$2->array_number) != 0) {
          cout <<"line"<<line<< "??o~";
        }
        else {
          $$->node_type = 1;
          $$->pointor_number = $2->pointor_number-1;
          $$->array_number = 0;
                    $$->value_int=~$$->value_int;
                    $$->value_type=1;
        }
        list[listnum-1].re_type=$$->node_type;
      }
             | MUL SEN_ELEM_EXP %prec NOT         
             {
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="MUL SEN_ELEM_EXP";
             $$->children_number=1;
             $$->children[0]=$2;
             $$->node_type = $$->children[0]->node_type;
       $$->value_temp =$$->children[0]->value_temp;
       $$->setarg($2,1);
       $$->setopr("*");
       $$->setre(rt++);
       $$->setlabel(labelnum++);
             list[listnum++]=*($$->four);
             list[listnum-1].re_type=$$->node_type;
             $$->maxlabel=labelnum-1;
             $$->minlabel=labelnum-1;
             if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                     }
             if($$->pointor_number>0){
                $$->pointor_number = $$->children[0]->pointor_number - 1;
                 $$->array_number=$$->children[0]->array_number;
             }
       else{
             $$->array_number=$$->children[0]->array_number-1;
             $$->changearray($2);
             }
             }
             | NOT SEN_ELEM_EXP                
             {
             $$=new treenode();
             $$->value_type=9;
             $$->node_name="NOT";
             $$->children_number=1;
             $$->children[0]=$2;
             $$->setarg($2,1);
       $$->setopr("!");
       $$->setre(rt++);
       $$->setlabel(labelnum++);
             list[listnum++]=*($$->four);
             list[listnum-1].re_type=10;
             $$->maxlabel=labelnum-1;
             $$->minlabel=labelnum-1;
             if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                     }
             if( ($2->pointor_number+$2->array_number) == 0) {
           $$->node_type = 10;
           $$->pointor_number = 0;
           $$->array_number = 0;
             }
       else {
        cout<<"error line:"<<line<<"error NOT"<<endl;
             }
             
             if($2->value_type==1){
                 if($2->value_int>0)
                 $$->value_temp=1;
                 else $$->value_temp=0;
                 $$->value_type=10;
             }
             else if($2->value_type==2||$2->value_temp==3){
                 if($2->value_float>0)
                 $$->value_temp=1;
                 else $$->value_temp=0;
                 $$->value_type=10;
             }
             else if($2->value_type==10||$2->value_type==4){
                 if($2->value_temp>0)
                 $$->value_temp=1;
                 else $$->value_temp=0;
                 $$->value_type=10;
             }
             $$->node_type=10;
             }
             | SIZEOF SEN_ELEM_EXP              {$$=new treenode();$$->value_type=9;$$->node_name="SIZEOF";$$->children_number=1;$$->children[0]=$2;}
             | SIZEOF '(' type_name ')'     {$$=new treenode();$$->value_type=9;$$->node_name="SIZEOF";$$->children_number=2;$$->children[0]=$4;}
             | DP SEN_ELEM_EXP %prec UMINUS     
             {
                 $$=new treenode();
                 $$->value_type=9;
                 $$->node_name="DP SEN_ELEM_EXP";
                 $$->children_number=1;
                 $$->children[0]=$2;
                 $$->node_type = $2->node_type;
           $$->pointor_number =$2->pointor_number;
           $$->array_number = $2->array_number;
           $$->setarg($2,1);
         $$->setopr("dpx");
         $$->setre(rt++);
         $$->setlabel(labelnum++);
           list[listnum++]=*($$->four);
           list[listnum-1].re_type=$$->node_type;
                 $$->maxlabel=labelnum-1;
                 $$->minlabel=labelnum-1;
                 if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                     }
           if($2->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$2->node_name!="MUL SEN_ELEM_EXP"&&$2->value_type!=5&&$2->node_name!="DP SEN_ELEM_EXP"&&$2->node_name!="DD SEN_ELEM_EXP"&&$2->node_name!="list"){
            cout<<$2->value_type<<endl;
            cout<<"error left value:line"<<line<<"equal"<<endl;
        }else if($2->node_name=="list"){
          for(int i=0;i<$2->children_number;i++){
          treenode* listtmp=$2->children[i];
          if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
            cout<<"error left value:line"<<line<<"++ sen_elem"<<endl;
          }
          }
        }else if($2->array_number!=0){
          cout<<"error line:"<<line<<"array can not ++"<<endl;
         }
            }
             | DD SEN_ELEM_EXP %prec UMINUS     
             {
                 $$=new treenode();
                 $$->value_type=9;
                 $$->node_name="DD SEN_ELEM_EXP";
                 $$->children_number=1;
                 $$->children[0]=$2;
                 $$->node_type = $2->node_type;
           $$->pointor_number =$2->pointor_number;
           $$->array_number = $2->array_number;
           $$->setarg($2,1);
         $$->setopr("ddx");
         $$->setre(rt++);
         $$->setlabel(labelnum++);
           list[listnum++]=*($$->four);
           list[listnum-1].re_type=$$->node_type;
                 $$->maxlabel=labelnum-1;
                 $$->minlabel=labelnum-1;
                 if($2->minlabel<$$->minlabel){
            $$->minlabel=$2->minlabel;
                     }
          if($2->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&$2->node_name!="MUL SEN_ELEM_EXP"&&$2->value_type!=5&&$2->node_name!="DP SEN_ELEM_EXP"&&$2->node_name!="DD SEN_ELEM_EXP"&&$2->node_name!="list"){
            cout<<$2->value_type<<endl;
            cout<<"error left value:line"<<line<<"equal"<<endl;
        }else if($2->node_name=="list"){
          for(int i=0;i<$2->children_number;i++){
          treenode* listtmp=$2->children[i];
          if(listtmp->node_name!="SEN_ELEM_EXP [COMMA_exp]"&&listtmp->node_name!="MUL SEN_ELEM_EXP"&&listtmp->value_type!=5&&listtmp->node_name!="DP SEN_ELEM_EXP"&&listtmp->node_name!="DD SEN_ELEM_EXP"){
            cout<<"error left value:line"<<line<<"-- sen_elem"<<endl;
          }
          }
        }else if($2->array_number!=0){
          cout<<"error line:"<<line<<"array can not --"<<endl;
         }
            }
             | POINTER ID             {
        $$=new treenode();
        $$->value_type=9;
        $$->node_name="POINTER ID";
        $$->children_number=2;
        $$->children[0]=$1;
        $$->children[1]=$2;
        $2->node_type = $2->findtype();
          $2->pointor_number=$2->findpointordeep();
        $2->array_number = $2->findarraydeep();
        $2->node_name="ID";
        if($2->node_type==-1||$2->pointor_number==-1||$2->array_number==-1){
          cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
        }else{
          //tostring($2->value_temp);
          //cout<<"(node_type,pointor_number,array_number):"<<$2->node_type<<","<<$2->pointor_number<<","<<$2->array_number;
        }
        $$->node_type=$2->node_type;
        $$->value_temp=$2->value_temp;
        $$->pointor_number=$2->pointor_number - $1->pointor_number;
        $$->array_number=$2->array_number;
      }
           ;  
ELEM_EXP: CONSTANT       {$$=$1;}
        | ID             
        {
      $$=$1;
      $$->node_type = $$->findtype();
      $$->pointor_number=$$->findpointordeep();
      $$->array_number = $$->findarraydeep();
            $$->setarray();
      $$->node_name="ID";
      if($$->node_type==-1||$$->pointor_number==-1||$$->array_number==-1){
        cout<<"error line:"<<line<<"CAN'T FIND THIS ID!!!"<<endl;
      }
        }  //int * a=(b[2][3]+3); int *(*a)[5][5];;
        ;
CONSTANT: COUNTSTRINGNUM {$$=$1;}
        | COUNTCHARNUM   {
      $$=$1;
      $$->node_type = $$->value_type;
      $$->pointor_number=0;
      $$->array_number = 0;
        }
        | COUNTINTNUM    {
      $$=$1;
      $$->node_type = $$->value_type;
      $$->pointor_number=0;
      $$->array_number = 0;
    }
        | COUNTFLOATNUM  {
      $$=$1;
      $$->node_type = $$->value_type;
      $$->pointor_number=0;
      $$->array_number = 0;
    }
        | COUNTDOUBLENUM {
      $$=$1;
      $$->node_type = $$->value_type;
      $$->pointor_number=0;
      $$->array_number = 0;
      }
        | STRING {
            $$=$1;
            cout<<"cometoconst"<<endl;
      $$->node_type = $$->value_type;
      $$->pointor_number=0;
      $$->array_number = 0;
            }
        | TRUE {
      $$=$1;
      $$->node_type = $$->value_type;
      $$->pointor_number=0;
      $$->array_number = 0;
    }
        | FALSE {
      $$=$1;
      $$->node_type = $$->value_type;
      $$->pointor_number=0;
      $$->array_number = 0;
    }
        ;
if_r: IF{
    /*number++;
    entrytable[number].parent=current;
    current=number;
    ifarray[ifnum]=2;
    ifnum++;
    ifc[2]++;*/

};
while_r: WHILE{
           /*number++;
           entrytable[number].parent=current;
           current=number;
           //cout<<""<<endl;
           ifarray[ifnum]=3;
           ifnum++;
           ifc[3]++;*/

};
for_r: FOR{
    number++;
    entrytable[number].parent=current;
    current=number;
    //iffor=iffun+ifif+ifwhile+1;
    ifarray[ifnum]=1;
    ifnum++;
    ifc[1]++;
};
left_r: '{'
{
    if(ifnum==0){
        number++;
        entrytable[number].parent=current;
        current=number;
    }
    else{
        ifnum--;
        ifc[ifarray[ifnum]]--;
    }
};

variable_type
    : VOID     {
    temptype=0;
    $$=$1;
    $$->node_type = temptype;
    $$->pointor_number=0;
    $$->array_number=0;
  }
  | CHAR     {
    temptype=4;
    $$=$1;
    $$->node_type = temptype;
    $$->pointor_number=0;
    $$->array_number=0;
  }
  | SHORT    {temptype=1;$$=$1;}
  | INT      {
    temptype=1;
    $$=$1;
    $$->node_type = temptype;
    $$->pointor_number=0;
    $$->array_number=0;
  }
  | LONG     {temptype=1;$$=$1;}
  | FLOAT    {
    temptype=2;
    $$=$1;
    $$->node_type = temptype;
    $$->pointor_number=0;
    $$->array_number=0;
  }
  //| STRING {}
  | DOUBLE   {
    temptype=3;
    $$=$1;
    $$->node_type = temptype;
    $$->pointor_number=0;
    $$->array_number=0;
  }
  | SIGNED   {temptype=1;$$=$1;}
  | UNSIGNED {temptype=1;$$=$1;}
  | BOOL     {
    temptype=10;
    $$=$1;
    $$->node_type = temptype;
    $$->pointor_number=0;
    $$->array_number=0;
  }
    | AUTO     {
    temptype=11;
    $$=$1;
    $$->node_type = temptype;
    $$->pointor_number=0;
    $$->array_number=0;
  }
  //| su_overall_dec
  //| enum_overall_dec
  ;

%%

/////////////////////////////////////////////////////////////////////////////
// programs section

int main(void)
{
  int n = 1;
  mylexer lexer;
  myparser parser;
    root=new treenode();
    root->value_type=9;
    root->node_name="root";
  if (parser.yycreate(&lexer)) {
    if (lexer.yycreate(&parser)) {
      n = parser.yyparse();
    }
  }
  //printnode(root,0);
  //judge_the_type(root,0);
    printlist();
    gotobeauty();
    //printcodelist();
    print_insidecode();
  return n;
}
