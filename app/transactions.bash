function handle_POST_transactions() {
    ID=${PARAMS["id"]}
    AMOUNT=$(echo "$BODY" | jq -r '.valor')
    TRANSACTION_TYPE=$(echo "$BODY" | jq -r '.tipo')
    DESCRIPTION=$(echo "$BODY" | jq -r '.descricao')
 
    if [ -z "$ID" ] || ! [[ "$ID" =~ ^[1-5]$ ]]; then
        RESPONSE=$(cat views/404.htmlr)
        return
    fi

    if [ -z "$AMOUNT" ] || [ "$AMOUNT" -le 0 ]; then
        RESPONSE=$(cat views/400.htmlr)
        return
    fi

    if [ -z "$TRANSACTION_TYPE" ] || [ "$TRANSACTION_TYPE" != "c" ] && [ "$TRANSACTION_TYPE" != "d" ]; then
        RESPONSE=$(cat views/400.htmlr)
        return
    fi

    if [ -z "$DESCRIPTION" ] || [ "${#DESCRIPTION}" -gt 10 ]; then
        RESPONSE=$(cat views/400.htmlr)
        return
    fi

    if [ ! -z "$ID" ]; then
        RESULT=$(psql -t -h pgbouncer -U postgres -d postgres -p 6432 -c \
            "SELECT update_transaction_and_balance($ID, $AMOUNT, '$DESCRIPTION', '$TRANSACTION_TYPE')")

        if [ ! -z "$RESULT" ]; then
            RESPONSE=$(cat views/transactions.jsonr | sed "s/{{data}}/$RESULT/")
        else
            RESPONSE=$(cat views/422.htmlr)
        fi
    fi
}
