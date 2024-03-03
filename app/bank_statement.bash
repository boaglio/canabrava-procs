function handle_GET_bank_statement() {
  ID=${PARAMS["id"]}

  # id between 1 and 5 ?
  if [ ! -z "$ID" ] && [ "$ID" -ge 1 ] && [ "$ID" -le 5 ]; then
    RESULT=$(psql -t -h pgbouncer -U postgres -d postgres -p 6432 -c \
      "SELECT generate_bank_statement($ID)")

    if [ ! -z "$RESULT" ]; then
      RESPONSE=$(cat views/bank_statement.jsonr | sed "s/{{data}}/$RESULT/")
    else
      RESPONSE=$(cat views/404.htmlr)
    fi
  else    
    RESPONSE=$(cat views/404.htmlr)
  fi
}
