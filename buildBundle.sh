#!/bin/bash
export DEVEL_DIR=/var/www/ingenio_devel
export RELEASE_DIR=/var/www/ingenio_release
export TMP_DIR=/tmp/meteor_build

rm -rf $TMP_DIR
rm -rf $RELEASE_DIR
cd $DEVEL_DIR
meteor build $TMP_DIR --server http://test.ingenio-promocionales.comm

cd $TMP_DIR
tar xfz ingenio_devel.tar.gz

mv bundle $RELEASE_DIR

cd $RELEASE_DIR
(cd programs/server && npm install)

cat << EOF > $RELEASE_DIR/run.sh

pkill -9 node

cd $RELEASE_DIR
export HOSTNAME=`hostname`
export ROOT_URL=http://test.ingenio-promocionales.com
export MONGO_URL=mongodb://test.ingenio-promocionales.com:27017/ingenio
export PORT=80

nohup node main.js &> /var/log/node.log &
disown

EOF

chmod 755  $RELEASE_DIR/run.sh
echo APPLICATION READY TO BE RUN!
