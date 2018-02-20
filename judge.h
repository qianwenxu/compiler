#pragma once
#include "cn.h"
#include "node.h"
int length(int a,int b){
	if(a==1||b==1)
	return 2;
	else return 4;

}
int judg_func(treenode *s,int k){
	long long int name=0;
	int total=0;
	formultiparamfunction temp;
	if(s->children[0]->value_type==5)
	name=s->children[0]->value_temp;
	int key=0;
	int numbermax=3*s->children[1]->children_number+1;
	bool ifsuit=false;
	while(key<=functionnum){
		int signal=k;
		ifsuit=true;
		if(function[key].functionname!=name){
			ifsuit=false;
			key++;
			continue;
		}
		if(function[key].functionname==name)
			 temp=function[key];
		if(temp.ismore==true&&k>0){
			treenode * list=s->children[1];
			signal--;
			if(temp.paramnum>list->children_number){
				ifsuit=false;
				break;
			}
			for(int i=0;i<temp.paramnum;i++){
				if((temp.pointor_num[i]==0)&&(list->children[i]->pointor_number==0)&&(temp.array_num[i]==0)&&(list->children[i]->array_number==0))
				{
					if(temp.type[i]==list->children[i]->node_type)
					continue;
					else{ 
						signal-=length(temp.type[i],list->children[i]->node_type);
						continue;
					}
				}
				else {
					if(temp.type[i]!=list->children[i]->node_type) {
						ifsuit=false;
					}
				for(int j=14;j>0;j--){
					if(temp.array[i][j]==list->children[i]->array[j])
					continue;
					else if(j==1&&list->children[i]->pointor_number==1)
					continue;
					else if(j==1&&temp.array_num[i]+temp.pointor_num[i]==list->children[i]->pointor_number+list->children[i]->array_number)
					continue;
					else{
						ifsuit=false;
						break;
					}
				}
			}
		}
	}
		else {
			treenode * list=s->children[1];
			if(temp.paramnum!=list->children_number){
				ifsuit=false;
			}
			for(int i=0;i<temp.paramnum;i++){
				if((temp.pointor_num[i]==0)&&(list->children[i]->pointor_number==0)&&(temp.array_num[i]==0)&&(list->children[i]->array_number==0)){
					if(temp.type[i]==list->children[i]->node_type)
					continue;
					else{ 
						signal-=length(temp.type[i],list->children[i]->node_type);
						continue;
					}
				}
				else {
					if(temp.type[i]!=list->children[i]->node_type) {
						ifsuit=false;
						break;
					}
					for(int j=14;j>0;j--){
						if(temp.array[i][j]==list->children[i]->array[j]){
						continue;
						}
						else if(j==1&&list->children[i]->pointor_number==1)
						continue;
						//else if(j==1&&temp.array_num[i]+temp.pointor_num[i]==list->children[i]->pointor_number+list->children[i]->array_number)
						//continue;
						else{
							ifsuit=false;
							break;
						}
				}
			}
		}

	}
	if(ifsuit&&signal>=0&&k==0){
	s->node_type=function[key].re_type;
	break;
	}
	else if(ifsuit&&signal>=0) {
		s->node_type=function[key].re_type;
		total++;
	}
	key++;
}
if(k==0&&ifsuit){
return 1;
}
else if(k<numbermax&&total==1){
return 1;
}
else if(k<numbermax&&total>1){
	return 2;
}
else if(k<numbermax&&total==0)judg_func(s,k+1);
else if(k==numbermax){
	return ifsuit;
}
}