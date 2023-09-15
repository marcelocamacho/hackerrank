#!/bin/bash
## https://github.com/ADHYAN-Learnings/Linux-Shell/blob/main/function_and_fractals_Recursive_Trees_Bash.sh
declare -A screen

read -p "Input a number between 1 and 5: " input

iterationNumber=16

declare -A nodeRow
declare -A nodeCol

nodeRowIndex=0
nodeColumnIndex=0

nodeRow[0]=64
nodeColumn[0]=50

declare -A leavesRow
declare -A leavesColumn

leavesRowIndex=0
leavesColumnIndex=0

## ------------ Creating a scree ----------------

for((i=1;i<=63;i++))
do
	for((j=1;j<=100;j++))
	do
		screen[$i,$j]='_'
	done
done

## -----------Number of interations as per the input

for((i=1;i<=input;i++))
do
	for index in ${!nodeRow[@]}
	do
		startRow=${nodeRow[$index]}
		startColumn=${nodeColumn[$index]}
		for((j=1;j<=$iterationNumber;j++))
		do
			let startRow=startRow-1
			if [ $j -eq $iterationNumber ];then
				leavesRow[$leavesRowIndex]=$startRow
				leavesColumn[$leavesColumnIndex]=$startColumn
				let leavesRowIndex++
				let leavesColumnIndex++
			fi
			screen[$startRow,$startColumn]=1
		done
	done
	unset nodeRow
	unset nodeColumn

	nodeRowIndex=0
	nodeColumnIndex=0

	for index in ${!leavesRow[@]};do
		count=1
		startRow=${leavesRow[$index]}
		startColumn=${leavesColumn[$index]}
		while [ "$count" -le 2 ]
		do
			tempDataRow=$startRow
			tempDataColumn=$startColumn
			for((j=1;j<=$iterationNumber;j++))
			do
				let tempDataRow-=1
				if (( $count%2 != 0 ))
				then
					let tempDataColumn-=1
				else
					let tempDataColumn+=1
				fi

				if [ $j -eq $iterationNumber ]
				then
					nodeRow[$nodeRowIndex]=$tempDataRow
					nodeColumn[$nodeColumnIndex]=$tempDataColumn
					let nodeRowIndex++
					let nodeColumnIndex++
				fi
				screen[$tempDataRow,$tempDataColumn]=1
			done
			let count++;
		done
	done

	let $iterationNumber/2;
	unset leavesRow
	unset leavesColumn
	leavesRowIndex=0
	leavesColumnIndex=0
done

## ----------- Displaying the data --------------

for((i=1;i<=63;i++))
do
	for((j=1;j<=100;j++))
	do
		echo -ne ${screen[$i,$j]}
	done
	echo
done






