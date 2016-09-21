#!/bin/sh
iter=20;
for((i=0;i<iter;i++)) do
	for ((j=1;j<56;j+=5))do
		./regTest2.out ${j} 0
		./regTest2.out ${j} 1
	done;
done;
mv regTestTime.txt regTestTimeNPC.txt
export COMPUTE_PROFILE=1
export COMPUTE_PROFILE_CSV=1
export COMPUTE_PROFILE_CONFIG=config.txt
for((i=0;i<iter;i++)) do
	for ((j=1;j<56;j+=5))do
		export COMPUTE_PROFILE_LOG=log1_${i}_${j}_0.csv
		./regTest2.out ${j} 0
		export COMPUTE_PROFILE_LOG=log1_${i}_${j}_1.csv
		./regTest2.out ${j} 1
	done;
done;
mkdir regTest20
mv *.csv regTest20

