#pragma once
#include <string>
using namespace std;
class entry {
public:
	long long int name;
	int entry_type;//int 1 float 2 double 3 char 4 function 5 bool 10
	int deep_pointer;//pointer
	int deep_array;
	int functionnum;
	int eachrow[15];
	bool iffun;
	void fill(long long int s, int n, int deep1, int deep2) {
		this->name = s;
		this->entry_type = n;
		this->deep_pointer = deep1;
		this->deep_array = deep2;
		for (int i = 0; i<15; i++)
			this->eachrow[i] = 0;
		this->iffun = false;
	}
	void fill(long long int s, int n, int deep1, int deep2, bool iffun, int functionnum) {
		this->name = s;
		this->entry_type = n;
		this->deep_pointer = deep1;
		this->deep_array = deep2;
		for (int i = 0; i<15; i++)
			this->eachrow[i] = 0;
		this->iffun = true;
		this->functionnum = functionnum;
	}
	string nametostring() {
		string re = "";
		long long int tmpnm = name;
		while (name > 0) {
			int key = name % 100;
			char keychar = key + '/';
			re += keychar;
			name = name / 100;
		}
		name = tmpnm;
		return re;
	}
	entry() {};
	void print() {
		switch (entry_type)
		{
		case 0:
			cout << "void" << " ";
			break;
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
		cout << nametostring();
		int k = 14;
		while (k > 0) {
			if (eachrow[k] != 0) {
				break;
			}
			else k--;
		}
		for (int i = 0; i < k; i++) {
			cout << "[" << eachrow[i] << "]";
		}

	}
};