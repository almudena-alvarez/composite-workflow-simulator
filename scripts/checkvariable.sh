response=["organizations": "lalala"]

if [[ $response == "[]" ]] 
then
     ${{ env.CHECKING_DELETION }} = true
fi
