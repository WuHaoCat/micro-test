#!/bin/bash
iter=5;
num=9;
for (( k=1; k<num; k++ )) do
	for((i=0;i<iter;i++)) do
		for ((j=1;j<10;j++))do
			./memTest2.out 0 0 ${j} 0 ${k}
			./memTest2.out 0 1 ${j} 0 ${k}
			./memTest2.out 1 0 ${j} 0 ${k}
			./memTest2.out 1 1 ${j} 0 ${k}
			./memTest2.out 0 0 ${j} 1 ${k}
			./memTest2.out 0 1 ${j} 1 ${k}
			./memTest2.out 1 0 ${j} 1 ${k}
			./memTest2.out 1 1 ${j} 1 ${k}
		done;
	done;
done;
