#!/bin/bash
response=$(curl https://reqbin.com/echo/get/json -H "Accept: application/json")

if [ $response == "[]" ]
then
#      ${{ env.CHECKING_DELETION }} = true

     echo "Game over!"
     exit 1
fi
