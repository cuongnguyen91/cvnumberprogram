#!/bin/bash
#get variable value  from command
unset i_radix o_radix nb
function help {
echo "please use ./command -i <input radix> -o <output radix> -n <number convert>"
echo "input & output radix form: dec,bin,oct,hex,2,8,10,16"
echo "input & output radix don't same"
}
function check_i_o {
	case "$1" in
	dec|10)eval $2=10;;
	oct|8)eval $2=8;;
	bin|2)eval $2=2;;
	hex|16)eval $2=16;;
	*)help;exit 1;;
	esac
}
if [ $# -ne 6 ] 
then
	help
	exit 1
fi

while [ $1 ]
do
	case "$1" in
	-i)i_radix="$2";;
	-o)o_radix="$2";;
	-n)nb="$2";;
	*)help;exit 1;;
	esac
	shift 2
done
#check data input
check_i_o $i_radix i_radix
check_i_o $o_radix o_radix
echo "$i_radix $o_radix $nb"
if [ -z $i_radix ] || [ -z $o_radix ] || [ -z $nb ] || [ $i_radix -eq $o_radix ]
then
	help
	exit 1
fi
if ([ $i_radix -eq 2 ] && [[ ! "$nb" =~ ^[-0-1][0-1]*$ ]]) || ([ $i_radix -eq 8 ] && [[ ! "$nb" =~ ^[-0-7][0-7]*$ ]]) || ([ $i_radix -eq 10 ] && [[ ! "$nb" =~ ^[-0-9][0-9]*$ ]]) || ([ $i_radix -eq 16 ] && [[ ! "$nb" =~ ^[-0-9a-fA-F][0-9a-fA-F]*$ ]])
then
    echo "format number Incompatible to input radix"
    exit 1
fi
#calculator
if [ $i_radix -eq 10 ] || [ $o_radix -eq 10 ]
then
    if [ $i_radix -eq 10 ]
    then
        echo "obase="$o_radix";$nb"|bc
    else
        echo "ibase="$i_radix";$nb"|bc
    fi
else
    if [ $i_radix -gt $o_radix ]
    then
        echo "ibase=$i_radix;obase=$o_radix;$nb"|bc
    else
        echo "obase=$o_radix;ibase=$i_radix;$nb"|bc
    fi
fi
