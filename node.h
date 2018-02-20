#pragma once
#include "cn.h"
#include "entrytable.h"
#include "fourele.h"
#include<math.h>
#define MAXCHILDREN 10 //每一个树结点所拥有的孩子结点的最大个数

class treenode {
public:
	treenode* children[MAXCHILDREN];
	int value_type;//int 1 float 2 double 3 char 4 ID 5 STRING 6 类型7 修饰符8 其他9 
	int children_number;
	float value_float;
	int value_int;
	char value_char;
	char* value_bool;
	char* value_name;
	string node_name;
	int array[15];
	long long int value_temp;
	int curtable;
	int pointor_number;
	int array_number;
	int node_type;
	fourele *four;
	string temp;
	int minlabel;
	int maxlabel;
	string code_str="";
public:
	treenode() {
		this->children_number = 0;
		this->value_type = 0;
		this->value_temp = 0;
		this->curtable = current;
		this->pointor_number = 0;
		this->array_number = 0;
		for (int i = 0; i<15; i++)
			this->array[i] = 0;
		four = new fourele();
		minlabel = 999999;
		maxlabel = -1;
	};
	string tostring(int num) {
		string re = "";
		while (num > 0) {
			int key = num % 100;
			char keychar = char(key + '/');
			re += keychar;
			num = num / 100;
		}
		return re;
	};
	string nametostring(long long int num) {
		string re = "";
		while (num > 0) {
			int key = num % 1000;
			char keychar = key;
			re += keychar;
			num = num / 1000;
		}
		return re;
	}
	void nametofloat() {
		for (int i = strlen(this->value_name) - 1; i >= 0; i--)
		{
			this->value_temp = this->value_temp * 100 + this->value_name[i] - '/';
		}
	};
	void chartofloat() {
		this->value_temp = this->value_char;
	};
	void booltofloat() {
		if (value_bool == "true") { this->value_temp = 1; }
		if (value_bool == "false") { this->value_temp = 0; }
	};
	void stringtofloat() {
		temp = this->value_name;

	}
	void setarray() {
		int k = this->curtable;
		entry temp;
		while (k != -1) {
			int num = entrytable[k].number;
			for (int i = 0; i < num; i++) {
				temp = entrytable[k].item[i];
				if (temp.name == this->value_temp) {
					for (int j = 0; j<15; j++) {
						this->array[j] = temp.eachrow[j];
					}
					break;
				}
			}
			k = entrytable[k].parent;
		}
	}
	void changearray(treenode * t) {
		for (int i = 0; i<14; i++)
			this->array[i] = t->array[i + 1];
		this->array[14] = 0;
		for (int i = 14; i>0; i--)
			if (this->array[i] != 0) {
				this->array[i] -= 1;
				break;
			}
	}
	void copyarray(treenode *s) {
		for (int i = 0; i<15; i++)
			this->array[i] = s->array[i];
	}
	void changede(int a, int n, int p[15]) {
		int k = this->curtable;
		entry temp;
		while (k != -1) {
			int num = entrytable[k].number;
			for (int i = 0; i < num; i++) {
				if (entrytable[k].item[i].name == this->value_temp) {
					entrytable[k].item[i].deep_array = n;
					entrytable[k].item[i].entry_type = a;
					for (int sd = 0; sd<15; sd++)
						entrytable[k].item[i].eachrow[sd] = p[sd];
					break;
				}
			}
			k = entrytable[k].parent;
		}
	}
	int findtype()
	{
		int k = this->curtable;
		entry temp;
		while (k != -1) {
			int num = entrytable[k].number;
			for (int i = 0; i < num; i++) {
				temp = entrytable[k].item[i];
				if (temp.name == this->value_temp)
					return temp.entry_type;
			}
			k = entrytable[k].parent;
		}
		if (k == -1) {
			//cout<<this->value_temp;
			//cout<<this->curtable;
		}
		return -1;
	}
	int findpointordeep()
	{
		int k = this->curtable;
		entry temp;
		while (k != -1) {
			int num = entrytable[k].number;
			for (int i = 0; i < num; i++) {
				temp = entrytable[k].item[i];
				if (temp.name == this->value_temp)
					return temp.deep_pointer;
				//cout << "temp.deep_array:" << temp.deep_array << "temp.deep_pointer" << temp.deep_pointer;
			}
			k = entrytable[k].parent;
		}
		return -1;
	}
	int findarraydeep()
	{
		int k = this->curtable;
		entry temp;
		while (k != -1) {
			int num = entrytable[k].number;
			for (int i = 0; i < num; i++) {
				temp = entrytable[k].item[i];
				if (temp.name == this->value_temp)
					return temp.deep_array;
				//cout << "temp.deep_array:" << temp.deep_array << "temp.deep_pointer" << temp.deep_pointer;
			}
			k = entrytable[k].parent;
		}
		return -1;
	}
	bool ifcompare(treenode *s) {
		if (this->node_type != s->node_type) {
			cout << "node_type" << endl;
			return false;
		}
		else if ((this->pointor_number + this->array_number) != (s->pointor_number + s->array_number)) {
			cout << "node_add" << endl;
			return false;
		}
		else {
			for (int j = 14; j>0; j--)
				if (this->array[j] == s->array[j])
					continue;
				else if (j == 1 && (s->pointor_number == 1 || this->pointor_number == 1))
					return true;
				else {
					cout << "node_array" << endl;
					return false;
				}
		}
		return true;
	}
	string getre() {
		string arg = "";
		if (this->value_type == 5) {
			long long int num = this->value_temp;
			while (num > 0) {
				int key = num % 100;
				arg += char(key + '/');
				num = num / 100;
			}
		}
		else if (this->value_type == 1)
			arg = to_string(this->value_int);
		else if (this->value_type == 2 || this->value_type == 3)
			arg = to_string(this->value_float);
		else if (this->value_type == 4) {
			arg += "'";
			arg += char(this->value_temp);
			arg += "'";
		}
		else if (this->value_type == 6) {
			arg = temp;
		}
		else if (this->value_type == 6)
			arg = nametostring(this->value_temp);
		else if (this->value_type == 10)
			arg = this->value_bool;
		else
			arg = this->four->getre();
		return arg;
	}
	void setarg(treenode * s, int num) {
		string arg = s->getre();
		if (num == 1)
			this->four->setarg1(arg);
		else
			this->four->setarg2(arg);
		if (this->minlabel < s->minlabel)
			this->minlabel = s->minlabel;
	}
	void setre(int num) {
		this->four->setresult(num);
	}
	void setre(string s) {
		this->four->setre(s);
	}
	void setlabel(int label) {
		this->four->setlabel(label);
		this->maxlabel = label;
		this->minlabel = label;
	}
	void setopr(string oper) {
		this->four->setoper(oper);

	}
	bool ifexist() {
		if (this->maxlabel == -1||this->minlabel== 999999)return false;
		//if (this->four->arg1 == ""&&this->four->arg2 == ""&&this->four->oper == "")return false;
		else return true;
	}
};