#!/bin/bash -x

function empWorkHours(){
isfulltime=1
isparttime=2
case $1 in
        $isfulltime) work_hours=8 ;;
        $isparttime) work_hours=4 ;;
      *)       work_hours=0 ;;
esac
   echo $work_hours
}

#constants
wage_per_hour=15
work_days_per_month=20

#variables
total_work_hours=0
working_day=0

function empWage(){
   echo $(($wage_per_hour*$1))
}

declare -A wage_dict
while [[ ($total_work_hours -le 100) && ($working_day -le $work_days_per_month) ]]
do
   ((working_day++))
   work_hours_per_day=$( empWorkHours $((RANDOM%3)) )
   wage_dict["Day $working_day"]=$( empWage $work_hours_per_day )
   total_work_hours=$((total_work_hours+work_hours_per_day))
done

total_wage=$( empWage $total_work_hours )
echo "Total Wage: "$total_wage
for num in "${!wage_dict[@]}"
do
   echo $num" Wage: "${wage_dict[$num]}
done
