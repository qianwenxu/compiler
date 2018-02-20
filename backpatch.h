#pragma once
#include "node.h"
int funprint = 0;
int relation(int before, int now) {
	int father = 0;
	int child = 0;
	int nowcopy = now;
	while (now != -1) {
		now = entrytable[now].parent;
		father++;
		if (now == before)
			return father;
	}
	while (before != -1) {
		before = entrytable[before].parent;
		child--;
		if (before == nowcopy)
			return child;
	}
	return 0;
}
void printlist() {
	cout << "label" << "    " << "arg1" << "    " << "arg2" << "    " << "result" << endl;
	for (int i = 0; i < listnum; i++)
	{
		cout << i << "    ";
		list[i].print();
	}
}
struct fordpdd{
	int type;
	string re;
	string arg;
	int listnum;
};
fordpdd pd[20];
int pdnum = 0;
void gotobeauty(){
	for (int i = 0; i < listnum; i++)
	{
		if (list[i].oper == "GOTO" || list[i].oper == "IF"){
			int tmpgoto = list[i].gotobnum;
			while (list[tmpgoto].oper == "GOTO"){
				tmpgoto = list[tmpgoto].gotobnum;
			}
			list[i].gotobnum = tmpgoto;
		}
	}
	/*for (int i = 0; i < listnum; i++)
	{
	if (list[i].signal&&list[i].gotobnum<i){
	int tmpgoto = list[i].gotobnum;
	int j;
	for (j = 0; tmpgoto + j < i; j++){
	if (list[tmpgoto + j].oper == "IF") break;
	}
	string changed[40];
	int s = 0;
	for (int k = tmpgoto + j; k <= i; k++){
	if (list[k].result != ""){
	changed[s++] = list[k].result;
	}
	}
	}
	}*/
}
void dim(int dimnum, int each[], string name){
	if (dimnum == 1){
		for (int i = 0; i < each[0]; i++){
			cout << name << "[" << i << "]=0;" << endl;
		}
	}
	else if (dimnum == 2){
		for (int i = 0; i < each[0]; i++){
			for (int j = 0; j < each[1]; j++){
				cout << name << "[" << i << "][" << j << "]=0;" << endl;
			}
		}
	}
	else if (dimnum == 3){
		for (int i = 0; i < each[0]; i++){
			for (int j = 0; j < each[1]; j++){
				for (int k = 0; k < each[2]; k++){
					cout << name << "[" << i << "][" << j << "][" << k << "]=0;" << endl;
				}
			}
		}
	}
	else if (dimnum == 4){
		for (int i = 0; i < each[0]; i++){
			for (int j = 0; j < each[1]; j++){
				for (int k = 0; k < each[2]; k++){
					for (int l = 0; l < each[3]; l++){
						cout << name << "[" << i << "][" << j << "][" << k << "][" << l << "]=0;" << endl;
					}
				}
			}
		}
	}
	else if (dimnum == 5){
		for (int i = 0; i < each[0]; i++){
			for (int j = 0; j < each[1]; j++){
				for (int k = 0; k < each[2]; k++){
					for (int l = 0; l < each[3]; l++){
						for (int m = 0; m < each[4]; m++){
							cout << name << "[" << i << "][" << j << "][" << k << "][" << l << "][" << m << "]=0;" << endl;
						}
					}
				}
			}
		}
	}
}
void printcodelist() {
	int temp = -1;
	int firstprintfun = true;
	bool iffirst = true;
	for (int i = 0; i < listnum; i++) {
		int currenttable = list[i].curtable;
		if (list[i].curtable != temp) {
			if (list[i].oper == "func:") {
				if (firstprintfun) {
					firstprintfun = false;
				}
				else {
					int l = relation(temp, 0);
					for (; l < 0; l++)
						cout << "}" << endl;
				}
				entrytable[0].printfun();
				int l = function[funprint].curtable;
				temp = l;
				entrytable[l].printwithparam();
			}
			else {
				int l = relation(temp, currenttable);
				if (l == 0) {
					cout << "}" << endl << "{" << endl;
					entrytable[currenttable].printtable();
				}
				for (; l > 0; l--) {
					cout << "{" << endl;
					int k = l;
					int parent = currenttable;
					while (k > 1) {
						parent = entrytable[parent].parent;
						k--;
					}
					entrytable[parent].printtable();
				}
				for (; l < 0; l++)
					cout << "}" << endl;
				temp = currenttable;
			}
		}
	}
	int l = relation(temp, 0);
	for (; l < 0; l++)
		cout << "}" << endl;
}
void printcode(int &temp, int i, int & firstprintfun, bool & iffirst) {
	//int temp = -1;
	//int firsstprintfun = true;
	//bool iffirst = true;
	//for (int i = 0; i < listnum; i++) {
	if (list[i].oper == "") {
		return;
	}
	int currenttable = list[i].curtable;
	if (list[i].oper == "func:") {
		if (firstprintfun) {
			firstprintfun = false;
		}
		else {
			int l = relation(temp, 0);
			for (; l < 0; l++)
				cout << "}" << endl;
		}
		entrytable[0].printfun();
		int l = function[funprint].curtable;
		temp = l;
		entrytable[l].printwithparam();
	}
	else if (list[i].curtable != temp) {
		int l = relation(temp, currenttable);
		if (l == 0) {
			cout << "}" << endl << "{" << endl;
			entrytable[currenttable].printtable();
		}
		for (; l > 0; l--) {
			cout << "{" << endl;
			int k = l;
			int parent = currenttable;
			while (k > 1) {
				parent = entrytable[parent].parent;
				k--;
			}
			entrytable[parent].printtable();
		}
		for (; l < 0; l++)
			cout << "}" << endl;
		temp = currenttable;
	}
	//}
	/*int l = relation(temp, 0);
	for (; l < 0; l++)
	cout << "}" << endl;*/
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
void printend(int temp) {
	int l = relation(temp, 0);
	for (; l < 0; l++)
		cout << "}" << endl;
}
void print_insidecode() {
	int templ = 0;
	double recordl[40] = { 0 };
	int temp = -1;
	int firstprintfun = true;
	bool iffirst = true;
	//entrytable[0].printwithoutfun();
	temp = 0;
	int ffun = 0;
	for (int i = 0; i < listnum + 1; i++) {
		if (list[i].oper == "func:") {
			ffun = i;
			break;
		}
	}
	for (int i = 0; i < inittotal.size(); i++) {
		cout << inittotal.at(i);
		cout << " ";
		if (inittotal.at(i) == ";")
			cout << endl;
	}

	for (int i = ffun; i < listnum; i++) {
		if (list[i].oper == "IF") {
			if (list[list[i].gotobnum].oper != "func:"){
				int je = 1;
				for (int j = 0; j < templ; j++){
					if (recordl[j] == list[i].gotobnum){
						je = 0;
					}
				}
				if (je){
					recordl[templ++] = list[i].gotobnum;
				}
			}
			else{
				int je = 1;
				for (int j = 0; j < templ; j++){
					if (recordl[j] == list[i].gotobnum - 0.5){
						je = 0;
					}
				}
				if (je){
					recordl[templ++] = list[i].gotobnum - 0.5;
				}
			}
		}
		else if (list[i].oper == "GOTO") {
			if (list[list[i].gotobnum].oper != "func:"){
				int je = 1;
				for (int j = 0; j < templ; j++){
					if (recordl[j] == list[i].gotobnum){
						je = 0;
					}
				}
				if (je){
					recordl[templ++] = list[i].gotobnum;
				}
			}
			else{
				int je = 1;
				for (int j = 0; j < templ; j++){
					if (recordl[j] == list[i].gotobnum - 0.5){
						je = 0;
					}
				}
				if (je){
					recordl[templ++] = list[i].gotobnum - 0.5;
				}
			}
		}
	}

	int ttmpl = 0;
	for (int i = ffun; i < listnum + 1; i++) {
		if (i<listnum)
			printcode(temp, i, firstprintfun, iffirst);
		//cout << i << endl;
		for (int s = 0; s < pdnum; s++){
			if (i == pd[s].listnum){
				printvariable(pd[s].type);
				cout << pd[s].re << "=" <<pd[s].arg << ";" << endl;
			}
		}
		for (int s = 0; s < templ; s++) {
			if (i == recordl[s]) {
				cout << "L" << s << ":";
			}
		}
		if (list[i].oper == ",") {
			int j;
			for (j = 0; list[i + j + 1].oper == ",";) {
				j++;
			}
			if (list[i + j + 1].oper == "call") {
				if (list[i + j + 1].re_type != 0){
					list[i + j + 1].printvariable(list[i + j + 1].re_type);
					cout << list[i + j + 1].result << "=";
				}
				cout << list[i + j + 1].arg1 << "(";
				for (int k = 0; k < j; k++) {
					cout << list[i + k].arg1 << ",";
				}
				cout << list[i + j].arg1 << ");" << endl;
				i += j + 1;
			}
			else if (list[i + j + 1].oper == "="){
				list[i + j + 1].gen_c_code();
				i += j + 1;
			}
			else{
				i += j;
			}
		}
		else if (list[i].oper == "IF") {
			cout << "if(!" << list[i].arg1 << ") goto L";
			for (int j = 0; j < templ; j++){
				if (recordl[j] == list[i].gotobnum || recordl[j] == list[i].gotobnum - 0.5){
					cout << j;
				}
			}
			cout << ";" << endl;
		}
		else if (list[i].oper == "GOTO") {
			cout << "goto L";
			for (int j = 0; j < templ; j++){
				if (recordl[j] == list[i].gotobnum || recordl[j] == list[i].gotobnum - 0.5){
					cout << j;
				}
			}
			cout << ";" << endl;
		}
		else if (list[i].oper == "read"){
			cout << "cin" << ">>" << list[i].arg1;
			string cincon = "";
			for (int j = 1; list[i - j].oper == "readdr"; j++){
				cincon = ">>" + list[i - j].arg1 + cincon;
			}
			cout << cincon << ";" << endl;
		}
		else if (list[i].oper == "write"){
			cout << "cout<<" << list[i].arg1;
			string coutcon = "";
			for (int j = 1; list[i - j].oper == "writedl"; j++){
				coutcon = "<<" + list[i - j].arg1 + coutcon;
			}
			cout << coutcon << ";" << endl;
		}
		else if (list[i].oper == "call"){
			if (list[i].re_type == 0){
				cout << list[i].arg1 << "(" << list[i].arg2 << ");" << endl;
			}
			else{
				list[i].printvariable(list[i].re_type);
				cout << list[i].result << "=" << list[i].arg1 << "(" << list[i].arg2 << ");" << endl;
			}
		}
		else if (list[i].oper == "initarr"){
			int cur = atoi(list[i].arg1.c_str());
			string arrayname = list[i].result;
			//cout << "initarr!" << "cur" << cur << "arrname" << arrayname;
			for (int k = 0; k < entrytable[cur].number; k++){
				//cout << "name" << entrytable[cur].item[k].nametostring();
				if (entrytable[cur].item[k].nametostring() == arrayname){
					int s = 14;
					//cout << "great" << entrytable[cur].item[k].eachrow;
					while (s > 0) {
						if (entrytable[cur].item[k].eachrow[s] != 0) {
							break;
						}
						else s--;
					}
					dim(s, entrytable[cur].item[k].eachrow, arrayname);
				}
			}
			//cout << endl;
		}
		else if (list[i].oper == "dpx"){
			cout << "++" << list[i].arg1 << ";" << endl;
			int ju = 1;
			for (int j = 0; i + j < listnum; j++){
				if (list[i + j].arg1 == list[i].result || list[i + j].arg2 == list[i].result){
					pd[pdnum].arg = list[i].arg1;
					pd[pdnum].re = list[i].result;
					pd[pdnum].type = list[i].re_type;
					pd[pdnum++].listnum = i + j;
					ju = 0;
				}
			}
			if (ju){
				list[i].printvariable(list[i].re_type);
				cout <<list[i].result << "=" << list[i].arg1 << ";" << endl;
			}
		}
		else if (list[i].oper == "ddx"){
			cout << "--" << list[i].arg1 << ";" << endl;
			int ju = 1;
			for (int j = 0; i + j < listnum; j++){
				if (list[i + j].arg1 == list[i].result || list[i + j].arg2 == list[i].result){
					pd[pdnum].arg = list[i].arg1;
					pd[pdnum].re = list[i].result;
					pd[pdnum].type = list[i].re_type;
					pd[pdnum++].listnum = i + j;
					ju = 0;
				}
			}
			if (ju){
				list[i].printvariable(list[i].re_type);
				cout << list[i].result << "=" << list[i].arg1 << ";" << endl;
			}
		}
		else if (list[i].oper != "call"&&list[i].oper != "=[]"&&list[i].oper != "readdr"&&list[i].oper != "writedl") {
			list[i].gen_c_code();
		}
		for (int s = 0; s < templ; s++) {
			if (i == recordl[s] - 0.5) {
				cout << "L" << s << ":;";
			}
		}
	}
	printend(temp);
}
void change_move_restirct(int start, int end, int step, int beign, int fin) {
	for (int i = beign; i <= fin; i++)
	if (list[i].getsignal() && list[i].getgoto() >= start&&list[i].getgoto() < end) {
		cout << "change" << endl << i << endl;
		cout << list[i].getgoto() << endl;
		cout << step << endl;
		list[i].setgoto(list[i].getgoto() + step);
		list[i].print();
	}
}
void copy(fourele* re, fourele*source, int start, int sourcestart, int sourceend) {
	for (int i = sourcestart; i <= sourceend; i++)
		re[i - sourcestart + start] = source[i];
}
int maxtype(int a, int b) {//用于合并时的type取max
	if (a == 10) { a = 5; }
	if (b == 10) { b = 5; }
	if (a == 3 || b == 3) { return 3; }
	int m[] = { 3, 2, 1, 4, 5 };
	if (m[a - 1] == m[b - 1]) {
		if (a == 5) { return 10; }
		else {
			return a;
		}
	}
	else if (m[a - 1] > m[b - 1]) {
		if (b == 5) { return 10; }
		else {
			return b;
		}
	}
	else {
		if (a == 5) { return 10; }
		else {
			return a;
		}
	}
}
int max(int a, int b) {
	if (a >= b) { return a; }
	else { return b; }
}
void change_move(int start, int end, int step) {
	for (int i = 0; i < listnum; i++)
	if (list[i].getsignal() && list[i].getgoto() >= start&&list[i].getgoto() < end) {
		cout << "change" << endl << i << endl;
		cout << list[i].getgoto() << endl;
		cout << step << endl;
		list[i].setgoto(list[i].getgoto() + step);
		list[i].print();
	}
}
void backpatch_if(treenode*total, treenode * boolexp, treenode* truelist, treenode *falselist) {
	change_move(falselist->minlabel, listnum + 1, 2);
	for (int j = listnum; j >= falselist->minlabel; j--)
		list[j + 2] = list[j];
	cout << "changetruelist" << endl;
	change_move_restirct(falselist->minlabel + 2, falselist->minlabel + 3, falselist->maxlabel - falselist->minlabel + 1, truelist->minlabel, truelist->maxlabel);
	cout << "changetruliet" << endl;
	//change_move_restirct(falselist->minlabel,falselist->minlabel+1,2,falselist->minlabel,falselist->maxlabel);
	listnum += 2;
	labelnum += 2;
	list[falselist->minlabel + 1].setoper("GOTO");
	list[falselist->minlabel + 1].cleararg(1);
	list[falselist->minlabel + 1].cleararg(2);
	list[falselist->minlabel + 1].setgoto(falselist->maxlabel + 3);
	list[falselist->minlabel + 1].curtable = boolexp->curtable;
	if (truelist->ifexist()) {
		for (int j = truelist->maxlabel; j >= truelist->minlabel; j--) {
			list[j + 1] = list[j];
		}
		change_move(truelist->minlabel + 1, truelist->maxlabel + 2, 1);
		list[truelist->minlabel].setoper("IF");
		list[truelist->minlabel].setarg1(boolexp->getre());
		list[truelist->minlabel].cleararg(2);
		list[truelist->minlabel].setgoto(falselist->minlabel + 2);
		list[truelist->minlabel].curtable = boolexp->curtable;
	}
	if (boolexp->ifexist())
		total->minlabel = boolexp->minlabel;
	else if (truelist->ifexist())
		total->minlabel = truelist->minlabel;
	total->maxlabel = falselist->maxlabel + 2;
}
void backpatch_if(treenode*total, treenode * boolexp, treenode* truelist) {
	for (int j = listnum; j >= truelist->minlabel; j--)
		list[j + 1] = list[j];
	change_move(truelist->minlabel + 1, listnum + 1, 1);
	listnum += 1;
	labelnum += 1;
	list[truelist->minlabel].setoper("IF");
	list[truelist->minlabel].setgoto(truelist->maxlabel + 2);
	list[truelist->minlabel].setarg1(boolexp->getre());
	list[truelist->minlabel].cleararg(2);
	list[truelist->minlabel].curtable = boolexp->curtable;
	total->minlabel = boolexp->minlabel;
	total->maxlabel = truelist->maxlabel + 1;

}
void backpatch_while(treenode*total, treenode * boolexp, treenode* truelist) {
	change_move(truelist->maxlabel + 1, truelist->maxlabel + 2, 1);
	/*for (int j = listnum; j > truelist->maxlabel; j--)
	list[j + 2] = list[j];*/
	listnum += 2;
	labelnum += 2;
	int num = listnum - 1;
	list[num].setoper("GOTO");
	list[num].cleararg(1);
	list[num].cleararg(2);
	if (boolexp->ifexist())
		list[num].setgoto(boolexp->minlabel);
	else
		list[num].setgoto(truelist->minlabel);
	list[num].curtable = boolexp->curtable;
	if (truelist->ifexist()) {
		for (int j = truelist->maxlabel; j >= truelist->minlabel; j--)
			list[j + 1] = list[j];
	}
	change_move(truelist->minlabel + 1, truelist->maxlabel + 2, 1);
	list[truelist->minlabel].setoper("IF");
	list[truelist->minlabel].setarg1(boolexp->getre());
	list[truelist->minlabel].cleararg(2);
	list[truelist->minlabel].setgoto(num + 1);
	list[truelist->minlabel].curtable = boolexp->curtable;
	if (boolexp->ifexist())
		total->minlabel = boolexp->minlabel;
	else if (truelist->ifexist())
		total->minlabel = truelist->minlabel;
	total->maxlabel = truelist->maxlabel + 2;
}

void backpatch_for1(treenode *total, treenode *init, treenode * boolexp, treenode*moves, treenode* truelist) {
	//change_move(truelist->maxlabel+1, truelist->maxlabel + 2, 2);
	/*for (int i = listnum; i > truelist->maxlabel; i--)
	list[i+2] = list[i];*/
	listnum += 2;
	labelnum += 2;
	list[truelist->maxlabel + 2].setoper("GOTO");
	list[truelist->maxlabel + 2].setgoto(boolexp->minlabel);
	list[truelist->maxlabel + 2].curtable = boolexp->curtable;
	fourele * state = new fourele[truelist->maxlabel - truelist->minlabel + 1];
	for (int i = truelist->minlabel; i <= truelist->maxlabel; i++)
		state[i - truelist->minlabel] = list[i];
	int nummove = 1 + moves->maxlabel - moves->minlabel;
	int numtrue = 1 + truelist->maxlabel - truelist->minlabel;
	//change_move(moves->minlabel, moves->maxlabel+1, 1+numtrue);
	int j = 0;
	for (int i = moves->minlabel; i <= moves->maxlabel; i++) {
		list[j + boolexp->maxlabel + numtrue + 2] = list[i];
		j++;
		//list[i].print();
	}
	for (int i = 0; i <numtrue; i++)
		list[boolexp->maxlabel + 2 + i] = state[i];
	change_move(truelist->minlabel, truelist->maxlabel + 1, 1 - nummove);
	list[boolexp->maxlabel + 1].setoper("IF");
	list[boolexp->maxlabel + 1].setarg1(boolexp->getre());
	list[boolexp->maxlabel + 1].setgoto(truelist->maxlabel + 3);
	list[boolexp->maxlabel + 1].curtable = boolexp->curtable;
	total->maxlabel = truelist->maxlabel + 2;
	total->minlabel = init->minlabel;
}
void aboutarray(string arrayname, string dec, int array_num, int cur){
	char* tmp = (char*)dec.data();
	int deep = -1;
	int offset[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
	//cout << "**************"<<"arraynum"<<array_num<<"*****************"<<endl;
	list[listnum].setre(arrayname);
	list[listnum].setoper("initarr");
	list[listnum++].setarg1(to_string(cur));
	labelnum++;
	for (int i = 0; i < dec.length(); i++){
		if (tmp[i] == '{'){
			deep++;
		}
		else if (tmp[i] == '}'){
			offset[deep] = 0;
			deep--;
		}
		else if (tmp[i] == ','){
			offset[deep]++;
		}
		else{
			string tmpre = arrayname;
			for (int j = 0; j < array_num; j++){
				tmpre += "[";
				tmpre += to_string(offset[j]);
				tmpre += "]";
			}
			string tmpval = "";
			tmpval += tmp[i];
			while (tmp[i + 1] != '{'&&tmp[i + 1] != '}'&&tmp[i + 1] != ','){
				i++;
				tmpval += tmp[i];
			}
			list[listnum].setre(tmpre);
			list[listnum].setoper("=");
			list[listnum++].setarg1(tmpval);
			labelnum++;
			//cout << tmpval<<endl;
		}
	}
	//cout << "declength" <<dec.length << endl;
	//cout << "******************************************"<<endl;
}
void backpatch_for(treenode *total, treenode*init, treenode*boolexp, treenode * truelist, treenode *move = NULL) {
	//if (init->ifexist() && boolexp->ifexist() && move->ifexist() && truelist->ifexist())
	//backpatch_for1(total, init, boolexp, move, truelist);
	fourele *boolexpcopy = NULL, *movecopy = NULL, *truelistcopy = NULL;
	listnum += 2;
	if (boolexp->ifexist()){
		boolexpcopy = new fourele[boolexp->maxlabel - boolexp->minlabel + 1];
		for (int i = boolexp->minlabel; i <= boolexp->maxlabel; i++)
			boolexpcopy[i - boolexp->minlabel] = list[i];
	}
	if (move != NULL&&move->ifexist()) {
		movecopy = new fourele[move->maxlabel - move->minlabel + 1];
		for (int i = move->minlabel; i <= move->maxlabel; i++)
			movecopy[i - move->minlabel] = list[i];
	}
	if (truelist->ifexist()) {
		truelistcopy = new fourele[truelist->maxlabel - truelist->minlabel + 1];
		for (int i = truelist->minlabel; i <= truelist->maxlabel; i++)
			truelistcopy[i - truelist->minlabel] = list[i];
	}
	int numstart = listnum;
	if (boolexp->ifexist()) {
		cout << "boolexpifexist" << endl;
		numstart = boolexp->maxlabel + 1;
		list[numstart].setoper("IF");
		list[numstart].setgoto(listnum);
		cout << numstart << endl;
		cout << list[numstart].curtable << endl;
		cout << boolexp->curtable;
		list[numstart].setarg1(boolexp->getre());
		list[numstart].curtable = boolexp->curtable;
		total->minlabel = boolexp->minlabel;
		numstart++;
	}
	else if (move != NULL&&move->ifexist()) {
		numstart = move->minlabel;
		list[numstart].setoper("IF");
		list[numstart].setgoto(listnum);
		list[numstart].setarg1("true");
		list[numstart].curtable = move->curtable;
		total->minlabel = move->minlabel;
		numstart++;
	}
	else if (truelist->ifexist()) {
		numstart = truelist->minlabel;
		list[numstart].setoper("IF");
		list[numstart].setarg1("true");
		list[numstart].setgoto(listnum);
		list[numstart].cleararg(2);
		list[numstart].curtable = truelist->curtable;
		total->minlabel = truelist->minlabel;
		numstart++;
	}
	else {
		list[numstart].setoper("IF");
		list[numstart].setarg1("true");
		list[numstart].setgoto(listnum);
		list[numstart].curtable = current;
		total->minlabel = numstart;
		numstart++;
	}
	if (init->ifexist()) {
		total->minlabel = init->minlabel;
	}
	int ifwhere = numstart - 1;
	if (truelist->ifexist()) {
		int k = 1;
		if (move != NULL&&move->ifexist())
			k = k - (move->maxlabel - move->minlabel + 1);
		for (int i = numstart; i <= numstart + truelist->maxlabel - truelist->minlabel; i++) {
			list[i] = truelistcopy[i - numstart];
		}
		change_move(truelist->minlabel + 1, truelist->maxlabel + 2, k);
		numstart = numstart + truelist->maxlabel - truelist->minlabel + 1;
	}
	if (move != NULL&&move->ifexist()) {
		for (int i = numstart; i <= numstart + move->maxlabel - move->minlabel; i++) {
			list[i] = movecopy[i - numstart];
		}
		numstart = numstart + move->maxlabel - move->minlabel + 1;

	}
	list[numstart].setoper("GOTO");
	if (boolexp->ifexist())
		list[numstart].setgoto(boolexp->minlabel);
	else list[numstart].setgoto(ifwhere);
	list[numstart].cleararg(1);
	list[numstart].cleararg(2);
	list[numstart].curtable = list[ifwhere].curtable;
	total->maxlabel = numstart;
	labelnum += 2;
}
