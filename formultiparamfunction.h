#pragma once
#include<iostream>
using namespace std;
class formultiparamfunction{
	public:
	long long int functionname;
	int re_type;
	int paramnum;
	int curtable;
	int type[15];
	int pointor_num[15];
	int array_num[15];
	int array[15][15];
	bool ismore;
	formultiparamfunction(){
		functionname=0;
		for (int i=0;i<15;i++){
			type[i]=0;
			pointor_num[i]=0;
			array_num[i]=0;
		}
		paramnum=0;
		ismore=false;
		for(int i=0;i<15;i++)
			for(int j=0;j<15;j++){
				this->array[i][j]=0;
			}
	}
	void setname(long long int tempname){
		this->functionname=tempname;

	}
	void insert(int type,int tempdeep1,int tempdeep2){
		this->type[paramnum]=type;
		this->pointor_num[paramnum]=tempdeep1;
		this->array_num[paramnum]=tempdeep2;
		paramnum++;
	}
	void addextern(int d,int num,int row[15]){
	    int k=this->paramnum-1;
		for(int i=0;i<d;i++){
			this->array[k][i]=0;
		}
		for(int i=d;i<d+num;i++){
			this->array[k][i]=row[i-d];
		}
		this->array[k][d+num]=num+d;
	}
	bool ifsame(formultiparamfunction s){
		if(s.functionname!=this->functionname){
			return false;
		}
		if(s.functionname==this->functionname){
			if(s.ismore!=this->ismore){
			return false;
			}
			else if(s.paramnum!=this->paramnum)
			{return false;}
			else {
				for(int i=0;i<this->paramnum;i++){
					if(s.type[i]!=this->type[i]){
					return false;
					}
					else {
						for(int j=14;j>0;j-- )
						if(s.array[i][j]!=this->array[i][j]){
						return false;
						}
					}
				}
			}

		}
		return true;
	}
};