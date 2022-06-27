response=[{"organizations": "lalala"}]

if [[ $response == "[]" ]] 
then
     ${{ env.CHECKING_DELETION }} = true
     echo ${{ env.CHECKING_DELETION }}
fi
