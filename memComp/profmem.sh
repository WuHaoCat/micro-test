#!/bin/sh
iter=5;
for((i=0;i<iter;i++)) do
	for ((j=1;j<10;j++))do
		./memTest.out 0 0 ${j} 0
		./memTest.out 0 1 ${j} 0
		./memTest.out 1 0 ${j} 0
		./memTest.out 1 1 ${j} 0
		./memTest.out 0 0 ${j} 1
		./memTest.out 0 1 ${j} 1
		./memTest.out 1 0 ${j} 1
		./memTest.out 1 1 ${j} 1
	done;
done;
mkdir mem01
mv mem*.txt mem01/
export COMPUTE_PROFILE=1
export COMPUTE_PROFILE_CSV=1
export COMPUTE_PROFILE_CONFIG=config.txt
for((i=0;i<iter;i++)) do
	for ((j=1;j<10;j++))do
		export COMPUTE_PROFILE_LOG=log1_${i}_0_0_${j}_0.csv
		./memTest.out 0 0 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_0_1_${j}_0.csv
		./memTest.out 0 1 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_1_0_${j}_0.csv
		./memTest.out 1 0 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_1_1_${j}_0.csv
		./memTest.out 1 1 ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_0_0_${j}_1.csv
		./memTest.out 0 0 ${j} 1
		export COMPUTE_PROFILE_LOG=log1_${i}_0_1_${j}_1.csv
		./memTest.out 0 1 ${j} 1
		export COMPUTE_PROFILE_LOG=log1_${i}_1_0_${j}_1.csv
		./memTest.out 1 0 ${j} 1
		export COMPUTE_PROFILE_LOG=log1_${i}_1_1_${j}_1.csv
		./memTest.out 1 1 ${j} 1
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
			./memTest.out 0 0 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_0_1_${j}_0.csv
			./memTest.out 0 1 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_0_${j}_0.csv
			./memTest.out 1 0 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_1_${j}_0.csv
			./memTest.out 1 1 ${j} 0
			export COMPUTE_PROFILE_LOG=log${num}_${i}_0_0_${j}_1.csv
			./memTest.out 0 0 ${j} 1
			export COMPUTE_PROFILE_LOG=log${num}_${i}_0_1_${j}_1.csv
			./memTest.out 0 1 ${j} 1
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_0_${j}_1.csv
			./memTest.out 1 0 ${j} 1
			export COMPUTE_PROFILE_LOG=log${num}_${i}_1_1_${j}_1.csv
			./memTest.out 1 1 ${j} 1
		done;
	done;
done;
mkdir mem02
mv *.csv mem02/
mv mem*.txt mem02/
