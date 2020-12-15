#! /bin/sh


PROGNAME=$(basename $0)

NAME_BY_BASE64='cmFrdW1vCg=='
NAME=`echo $NAME_BY_BASE64 | base64 -D`

APP_ID_BY_BASE64='Y2FscGRldgo='
APP_ID=`echo $APP_ID_BY_BASE64 | base64 -D`

STORAGE_PATH=$HOME/workspace/server_storage/dev-storage
WORKSPACE=$HOME/workspace/
BACKEND_YAML=''
EXTRA_OPT=''
WATCHER_IGNORE="--watcher_ignore_re=(?!.*README\.md)"
# WATCHER_IGNORE="--watcher_ignore_re=.*/(apps|bin|docs|etc|fasti|static|tools|vender)/.*"

usage() {
    echo "usage: $PROGNAME [default] [hotfix] [deploy] [feature] [showmail] [sendmail] [clear_datastore]"
    echo
    echo "Options:"
    echo "  default:           use storage for default test"
    echo "  hotfix:            use workspace for hotfix"
    echo "  deploy:            use workspace for deploy"
    echo "  feature:           use workspace for feature"
    echo "  navitime:          use workspace for navitime-proxy"
    echo "  timestamp:         use workspace for timestamp"
    echo "  showmail:          use '--show_mail_body'"
    echo "  sendmail:          use '--enable_sendmail'"
    echo "  clear_datastore:   use '--clear_datastore'"
    echo
    exit 1
}

####### python 2.7 #########
for OPT in $@
do
    case $OPT in
        'def'|'default' )
            STORAGE_PATH=$HOME/workspace/server_storage/dev-storage-default
            # EXTRA_OPT=$EXTRA_OPT' --automatic_restart false'
            echo 'default option'
            ;;
        'hotfix' )
            NAME=$NAME"-hotfix"
            # EXTRA_OPT=$EXTRA_OPT' --automatic_restart false'
            ;;
        'dep'|'deploy' )
            NAME=$NAME"-deploy"
            # EXTRA_OPT=$EXTRA_OPT' --automatic_restart false'
            ;;
        'feature' )
            NAME=$NAME"-feature"
            # EXTRA_OPT=$EXTRA_OPT' --automatic_restart false'
            ;;
        'navitime' )
            NAME=$NAME"-navitime-proxy"
            ;;
        'timestamp' )
            NAME=$NAME"-timestamp"
            WATCHER_IGNORE="--watcher_ignore_re=.*/(docs|static|tools|vender|etc|bin)/.*"
            ;;
        'showmail'|'--show_mail_body' )
            EXTRA_OPT=$EXTRA_OPT' --show_mail_body=true'
            echo "use $EXTRA_OPT"
            ;;
        'sendmail'|'--enable_sendmail' )
            EXTRA_OPT=$EXTRA_OPT' --enable_sendmail=true'
            echo "use $EXTRA_OPT"
            ;;
        'appidentity' )
            # EXTRA_OPT=$EXTRA_OPT' --appidentity_email_address='
            # EXTRA_OPT=$EXTRA_OPT' --appidentity_private_key_path='
            echo "use $EXTRA_OPT"
            ;;
        'clear_datastore'|'--clear_datastore' )
            echo 'clear datastore'
            # EXTRA_OPT=$EXTRA_OPT' --clear_datastore=true'
            # echo "use $EXTRA_OPT"
            ;;
        '-h'|'--help'|'help' )
            usage
            exit 1
            ;;
        * )
            echo "$PROGNAME: $1: No such options" 1>&2
            usage
            exit 1
            ;;
    esac
done

echo "use $WORKSPACE$NAME"

if ls $WORKSPACE$NAME/backend*.yaml > /dev/null 2>&1; then
    BACKEND_YAML=$WORKSPACE$NAME/backend*.yaml
    echo "use $BACKEND_YAML"
fi

cd $HOME/workspace/$NAME
pyenv version

./bin/dev_appserver \
    --application=${APP_ID} \
    --host=0.0.0.0 \
    --skip_sdk_update_check=true \
    --log_level=debug \
    --dev_appserver_log_level=info \
    --enable_console=true \
    --datastore_consistency_policy=consistent \
    --storage_path=$STORAGE_PATH \
    $WATCHER_IGNORE \
    $WORKSPACE$NAME \
    $BACKEND_YAML \
    $EXTRA_OPT

