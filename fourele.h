#pragma once
#include<string>
#include <string.h>
#include<iostream>
#include "data.h"
using namespace std;
class fourele {
public:
	string oper;
	string arg1;
	string arg2;
	string result;
	int resultnumber;
	int gotobnum;
	int label;
	int curtable;
	bool signal;
	int re_type;
public:
	fourele() {
		this->oper = "";
		this->arg1 = "";
		this->arg2 = "";
		this->result = "";
		this->resultnumber = -1;
		this->gotobnum = -1;
		this->signal = false;
		this->label = -1;
	}
	void  print() {
		/*if (arg1 == "")
			arg1 = "_";
		if (arg2 == "")
			arg2 = "_";
		if (result == "")
			result = "_";*/
		cout << "     " << oper << "      ";
		if (arg1 == ""){
			cout << "_";
		}
		else{
			cout << arg1;
		}
		if (arg2 == ""){
			cout << "      _      ";
		}
		else{
			cout << "      " << arg2 << "      ";
		}
		if (signal)
			cout << "(" << gotobnum << ")" << endl;
		else{
			if (result == ""){
				cout << "(_)" << endl;
			}
			else{
				cout << "(" << this->result << ")" << endl;
			}
		} 
	}
	void printvariable(int thetype){
		switch (thetype){
			case 1:
				cout << "int" << " ";
				break;
			case 2:
				cout << "float" << " ";
				break;
			case 3:
				cout << "double" << " ";
				break;
			case 4:
				cout << "char" << " ";
				break;
			case 10:
				cout << "bool" << " ";
				break;
			default:
				break;
		}
	}
	void gen_c_code(){
		if (oper == "=" || oper == "*=" || oper == "/=" || oper == "%=" || oper == "+=" || oper == "-=" || oper == "<<="
			|| oper == ">>=" || oper == "&=" || oper == "^=" || oper == "|="){
			cout << this->result << oper << arg1 << ";" << endl;
		}
		else if (oper == "return"){
			if (arg1 != ""){
				cout << "return " << arg1 << ";" << endl;
			}
			else{
				cout << "return;" << endl;
			}
		}
		else if (oper == "break"){
			cout << "break;" << endl;
		}
		else if (oper=="continue"){
			cout << "continue" << endl;
		}
		//else if (oper==",")
		else if (oper == "||" || oper == "&&" || oper == "==" || oper == "!=" || oper == ">" || oper == "<" || oper == ">=" || oper == "<="){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << oper << arg2 << ";" << endl;
		}
		else if (oper == "|" || oper == "^" || oper == "&" || oper == "<<" || oper == ">>"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << oper << arg2 << ";" << endl;
		}
		else if (oper == "add"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << "+" << arg2 << ";" << endl;
		}
		else if (oper == "sub"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << "-" << arg2 << ";" << endl;
		}
		else if (oper == "mul"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << "*" << arg2 << ";" << endl;
		}
		else if (oper == "div"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << "/" << arg2 << ";" << endl;
		}
		else if (oper == "mod"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << "%" << arg2 << ";" << endl;
		}
		else if (oper == "xdp"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << ";" << endl;
			cout << arg1 << "++;" << endl;
		}
		/*else if (oper == "dpx"){
			cout << "++" << arg1 << ";" << endl;
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << ";" << endl;
		}*/
		else if (oper == "xdd"){
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << ";" << endl;
			cout << arg1 << "--;" << endl;
		}
		/*else if (oper == "ddx"){
			cout << "--" << arg1 << ";" << endl;
			printvariable(this->re_type);
			cout << this->result << "=" << arg1 << ";" << endl;
		}*/
		//else if(oper=="=[]")
		else if (oper == "=()"){
			printvariable(this->re_type);
			if (this->re_type == 0){
				cout << arg1 << "();" << endl;
			}
			else{
				cout << this->result << "=" << arg1 << "();" << endl;
			}
		}
		//else if(oper=="call")
		else if (oper == "-" || oper == "+" || oper == "~" || oper == "*" || oper == "!"){
			printvariable(this->re_type);
			cout << this->result << "=" << oper << arg1 << ";" << endl;
		}
		else if (oper == "&x"){
			printvariable(this->re_type);
			cout << this->result << "=" << "&" << arg1 << ";" << endl;
		}
		else cout << ";" << endl;
	}
	void setarg1(string arg) {
		this->arg1 = arg;
		this->curtable = current;
	}
	void setarg2(string arg) {
		this->arg2 = arg;
		this->curtable = current;
	}
	void setresult(int re) {
		string  temp = "t";
		this->resultnumber = re;
		string renum = to_string(re);
		this->result = temp.append(renum);
		this->curtable = current;
	}
	void setlabel(int num) {
		this->label = num;
		this->curtable = current;
	}
	void setgoto(int num) {
		signal = true;
		this->gotobnum = num;
	}
	string getre() {
		return this->result;
	}
	void setre(string re) {
		this->result = re;
		this->curtable = current;
	}
	void setoper(string oper) {
		this->oper = oper;
		this->curtable = current;
	}
	int getgoto() {
		return this->gotobnum;
	}
	bool getsignal() {
		return this->signal;
	}
	void cleararg(int num) {
		if (num == 1)
			this->arg1 = "";
		else
			this->arg2 = "";
	}
	void copy(fourele temp) {
		this->oper = temp.oper;
		this->arg1 = temp.arg1;
		this->arg2 = temp.arg2;
		this->result = temp.result;
		this->signal = temp.signal;
		this->resultnumber = temp.resultnumber;
		this->gotobnum = temp.gotobnum;
		this->label = temp.label;
		this->re_type = temp.re_type;
	}
};