#!/bin/bash

# --- Private 서버 정보 ---
PRIVATE_HOST="10.10.20.6"          # 실제 Private 서버 IP
PRIVATE_USER="root"                 # Private 서버 계정
PRIVATE_KEY="/root/.ssh/id_rsa"     # Public 서버에서 Private 서버 접속용 키

# --- 실행 후 로그 남기기 ---
exec > /root/app/deploy_private.log 2>&1
echo "Starting deployment to Private server..."


eval $(ssh-agent -s)
ssh-add $PRIVATE_KEY


ssh -o StrictHostKeyChecking=no $PRIVATE_USER@$PRIVATE_HOST "mkdir -p /root/app" # -p : 이미 해당 디렉토리가 있으면 pass

# scp : 파일 전송 명령어 /root/app/build/libs*.jar 파일을 /root/app/app.jar라는 이름으로 저장
scp -o StrictHostKeyChecking=no /root/app/build/libs*.jar $PRIVATE_USER@$PRIVATE_HOST:/root/app/app.jar


ssh -o StrictHostKeyChecking=no $PRIVATE_USER@$PRIVATE_HOST "nohup java -jar /root/app/app.jar > /root/app/app.log 2>&1 &"

ssh -o StrictHostKeyChecking=no $PRIVATE_USER@$PRIVATE_HOST "bash </root/deploy.sh"

ssh-agent -k

echo "Deployment to Private server completed."