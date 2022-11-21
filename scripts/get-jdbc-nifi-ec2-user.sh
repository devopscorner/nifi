#!/bin/sh

NIFI_VERSION="1.18.0"
PATH_CONTAINER="/home/ec2-user/nifi"

URL_JDBC="https://jdbc.postgresql.org/download"

LIST_JDBC="postgresql-42.2.26.jre6.jar \
    postgresql-42.2.26.jre7.jar \
    postgresql-42.2.5.jar \
    postgresql-42.2.5.jre6.jar \
    postgresql-42.2.5.jre7.jar \
    postgresql-42.5.0.jar
"

create_folder_drivers() {
    mkdir -p "$PATH_CONTAINER-$NIFI_VERSION/drivers"
}

get_jdbc() {
    cd $PATH_CONTAINER-$NIFI_VERSION/drivers

    for JDBC_NAME in $LIST_JDBC; do
        echo "Getting JDBC: $JDBC_NAME ..."
        curl -o $JDBC_NAME $URL_JDBC/$JDBC_NAME
        echo "- DONE -"
        echo ""
    done

    echo "- ALL DONE -"
}

chmod_jdbc() {
    chmod +x *.jar
}

main() {
    create_folder_drivers
    get_jdbc
    chmod_jdbc
}

### START HERE ###
main $@
