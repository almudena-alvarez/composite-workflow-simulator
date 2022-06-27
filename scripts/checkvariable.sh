#!/bin/bash
response=$(curl https://reqbin.com/echo/get/json -H "Accept: application/json")

if [ $response != "[]" ]
then
#      ${{ env.CHECKING_DELETION }} = true
     echo $1
     echo ${{ env.CHECKING_DELETION }}
     echo "Game over!"
     exit 1
fi
