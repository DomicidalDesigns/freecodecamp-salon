#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

# echo $($PSQL "\c salon")

echo "Welcome to my salon! We offer these services:"

services=""

function list_services {
  for (( i = 1 ; i <= $($PSQL "select count(*) from services;") ; i++ )) ; do
    echo "$i)" $($PSQL "select name from services where service_id=$i")
    services+=" $i"

  done
}

function user_input {
  # read SERVICE_ID_SELECTED
  # read -p "Which service would you like?" SERVICE_ID_SELECTED

  SERVICE_ID_SELECTED=0

  while ! [[ ${services[@]} =~ $SERVICE_ID_SELECTED ]]
  do
    list_services

    read -p "Which service would you like? " SERVICE_ID_SELECTED

  done
  # read CUSTOMER_PHONE
  read -p "What's your phone number? " CUSTOMER_PHONE

  if [ $($PSQL "select count(*) from customers where phone='$CUSTOMER_PHONE'") -gt 0 ]
  then
    CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
    echo "It's great to see you back, $CUSTOMER_NAME!"
    APPT_TYPE=2
    
  else
    # read CUSTOMER_NAME
    read -p "We haven't seen you before. What's your name? " CUSTOMER_NAME
    echo $($PSQL "insert into customers(phone, name) select '$CUSTOMER_PHONE', '$CUSTOMER_NAME'")
    APPT_TYPE=1
  fi



  # read SERVICE_TIME
  SELECTED_SERVICE=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED")
  read -p "What time would you like your $SELECTED_SERVICE, $CUSTOMER_NAME? " SERVICE_TIME

  # insert appointment
  $($PSQL "insert into appointments(time, customer_id, service_id) select '$SERVICE_TIME', (select customer_id from customers where name='$CUSTOMER_NAME'), $SERVICE_ID_SELECTED")

  echo "I have put you down for a $SELECTED_SERVICE at $SERVICE_TIME, $CUSTOMER_NAME." 
}

# list_services
user_input






# echo $SERVICE_ID_SELECTED, $CUSTOMER_PHONE, $CUSTOMER_NAME, $SERVICE_TIME
