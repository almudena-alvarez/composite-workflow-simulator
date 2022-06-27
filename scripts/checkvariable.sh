response=[{"organizations": "lalala"}]

if [[ $response != "[]" ]] 
then
     ${{ env.CHECKING_DELETION }} = true
     echo ${{ env.CHECKING_DELETION }}
     echo "Game over!"
     exit 1
fi
