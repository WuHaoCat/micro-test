#!/bin/sh
iter=10;
for((i=0;i<iter;i++)) do
	for ((j=1;j<10;j++))do
		./memTest2.out 0 0 ${j} 0
		./memTest2.out 0 1 ${j} 0
		./memTest2.out 1 0 ${j} 0
		./memTest2.out 1 1 ${j} 0
		./memTest2.out 0 0 ${j} 1
		./memTest2.out 0 1 ${j} 1
		./memTest2.out 1 0 ${j} 1
		./memTest2.out 1 1 ${j} 1
	done;
done;
mkdir mem11
mv mem*.txt mem11/
export COMPUTE_PROFILE=1
export COMPUTE_PROFILE_CSV=1
export COMPUTE_PROFILE_CONFIG=config.txt
for((i=0;i<iter;i++)) do
	for ((j=1;j<10;j++))do
		export COMPUTE_PROFILE_LOG=log1_${i}_0_0_${j}_0.csv
		./memTest2.out 0 0 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_0_1_${j}_0.csv
		./memTest2.out 0 1 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_1_0_${j}_0.csv
		./memTest2.out 1 0 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_1_1_${j}_0.csv
		./memTest2.out 1 1 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_0_0_${j}_1.csv
		./memTest2.out 0 0 ${j} 1
		export COMPUTE_PROFILE_LOG=log1_${i}_0_1_${j}_1.csv
		./memTest2.out 0 1 ${j} 1
		export COMPUTE_PROFILE_LOG=log1_${i}_1_0_${j}_1.csv
		./memTest2.out 1 0 ${j} 1
		export COMPUTE_PROFILE_LOG=log1_${i}_1_1_${j}_1.csv
		./memTest2.out 1 1 ${j} 1
	done;
done;
for ((k=1; k < 9; k++)) do
	export COMPUTE_PROFILE=1
	export COMPUTE_PROFILE_CSV=1
	export COMPUTE_PROFILE_CONFIG=config${k}.txt
	num=$((k+1));
	for((i=0;i<iter;i++)) do
		for ((j=1;j<10;j++))do
			export COMPUTE_PROFILE_LOG=log${num}_${i}_0_0_${j}_0.csv
			./memTest2.out 0 0 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_0_1_${j}_0.csv
			./memTest2.out 0 1 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_0_${j}_0.csv
			./memTest2.out 1 0 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_1_${j}_0.csv
			./memTest2.out 1 1 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_0_0_${j}_1.csv
			./memTest2.out 0 0 ${j} 1
			export COMPUTE_PROFILE_LOG=log${num}_${i}_0_1_${j}_1.csv
			./memTest2.out 0 1 ${j} 1
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_0_${j}_1.csv
			./memTest2.out 1 0 ${j} 1
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_1_${j}_1.csv
			./memTest2.out 1 1 ${j} 1
		done;
	done;
done;
mkdir mem12
mv *.csv mem12/
mv mem*.txt mem12/
