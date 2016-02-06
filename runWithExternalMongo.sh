export HOSTNAME=`hostname`

if [ $HOSTNAME == "test.ingenio-promocionales.com" ]; then
    echo RUNNING APPLICATION IN PRODUCTION MODE
    export ROOT_URL=http://test.ingenio-promocionales.com
    export MONGO_URL=mongodb://test.ingenio-promocionales.com:27017/ingenio
    meteor --production --port 80 run
else
    echo RUNNING APPLICATION IN DEVELOPMENT MODE
    export ROOT_URL=http://localhost:3000
    export MONGO_URL=mongodb://localhost:27018/ingenio
    meteor --port 3000 run
fi
