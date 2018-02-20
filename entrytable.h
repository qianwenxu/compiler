#pragma once
#include"entry.h"
#include "data.h"
using namespace std;
class table {
public:
	int parent;
	int hasprint=0;
	int number;
	entry item[1000];
	table() {
		this->parent = -1;
		this->number = 0;
	}
	bool find(int name) {
		for (int i = 0; i < number; i++)
		if (this->item[i].name == name)
			return true;
		return false;
	}
	void insert(long long int name, int type, int deep1, int deep2,bool iffun,int functionnum) {
		this->item[this->number].fill(name, type, deep1, deep2,iffun,functionnum);
		//cout <<"insert"<<deep1;
		this->number++;
	}
	void insert(long long int name, int type, int deep1, int deep2) {
		this->item[this->number].fill(name, type, deep1, deep2);
		//cout <<"insert"<<deep1;
		this->number++;
	}
	void addextern(int tempname,int nonum,int rownum,int row[15]){
		for (int i = 0; i < number; i++)
		if (this->item[i].name == tempname){
			for(int j=0;j<nonum;j++){
				this->item[i].eachrow[j]=0;
			}
		for(int j=nonum;j<nonum+rownum;j++){
			this->item[i].eachrow[j]=row[j-nonum];
		}

		this->item[i].eachrow[nonum+rownum]=nonum+rownum;
	}
}
	bool test(long long int num) {
		for (int i = 0; i < number; i++)
		if (item[i].name == num)
			return false;
		return true;
	}
	void printtable() {
		for (int i = 0; i < this->number; i++) {
			item[i].print();
			cout << ";" << endl;
		}
	}
	void printfun() {
		int k0 = 0;
		int re = 0;
		for (int i = 0; i < number; i++) {
			if (item[i].iffun) {
				re = i;
				if (k0 == funprint)
					break;
				else k0++;
			}
		}
		item[re].print();
	}
	void printwithoutfun() {
		for (int i = 0; i < number; i++) {
			if (item[i].iffun)
				continue;
			else {
				item[i].print();
				cout << ";" << endl;
			}
		}
	}
	void printwithparam() {
		cout << "(";
		int k = function[funprint].paramnum;
		for (int i = 0; i < k; i++) {
			item[i].print();
			if(i!=k-1)
				cout << ",";
		}
		cout << ")  {" << endl;
		for (int i = k; i < number; i++) {
			item[i].print();
			cout << ";" << endl;
		}
		funprint++;

	}
};