#!/bin/bash
echo "xin moi nhap number: "
read a
echo "nhi phan: "
echo "obase=2;$a" | bc
echo "bat phan:  "
echo "obase=8;$a" | bc
echo "thap luc phan: "
echo "obase=16;$a" | bc
