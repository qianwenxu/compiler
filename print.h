#pragma once
#include"node.h"
#include<iostream>
#include<string>
#include<cstring>
using namespace std;
//int functionnum=0;
//formultiparamfunction fmpf[20];


void printnode(treenode* s, int n) {
	if (s->value_type == 9) {
		for (int i = 0; i < n * 4; i++) {
			cout << " ";
		}
		cout << s->node_name;
		if (s->node_name == "NEW_ELEMENT" || s->node_name == "&" || s->node_name == "'{' OLD_EXPRESSION_LIST'}'"){
			cout<<"         "<<"(node_type,pointor_number,arry_num):"<<s->node_type<<","<<s->pointor_number<<","<<s->array_number;
		}
		cout<<endl;
		for (int i = 0; i < s->children_number; i++)
			printnode(s->children[i], n + 1);
	}
	else {
		for (int i = 0; i < n * 4; i++)
			cout << " ";
		switch (s->value_type)
		{
		case 1:
			cout << "Integer" << "     " << s->value_int << endl;
			break;
		case 2:
			cout << "float" << "     " << s->value_float << endl;
			break;
		case 4:
			cout << "char" << "     ";
			cout<<char(s->value_temp);
			cout << endl;
			break;
		case 5:
			cout << "id" << "     ";
			//getstring(s->value_temp);
			cout << "         " << "(node_type,pointor_number,arry_num):" << s->node_type << "," << s->pointor_number << "," << s->array_number;
			cout << endl;
			break;
		case 6:
			cout << "STRING" << "     ";
			//cout << s->value_temp;
			//getnamestring(s->value_temp);
			cout << s->node_name << endl;
			break;
		case 7:
			cout << "type" << "     " << s->node_name << endl;
			break;
		case 8:
			cout << "decration" << "     " << s->node_name << endl;
			break;
		case 10:
			cout << "bool" << "     ";
			if (s->value_temp == 0) { cout << "false"; }
			if (s->value_temp == 1) { cout << "true"; }
			cout << endl;
			break;
		default:
			cout << s->node_name << endl;
			break;
		}
	}

}

