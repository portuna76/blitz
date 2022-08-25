echo "> 현재 구동중인 애플리케이션 pid 확인"

CURRENT_PID=$(ps -ef | grep java | grep blitz | grep -v nohup | awk '{print $2}')

echo "$CURRENT_PID"

if [ -z ${CURRENT_PID} ]; then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> sudo kill -15 $CURRENT_PID"
  sudo kill -15 $CURRENT_PID
  sleep 10
fi

echo "> 새 어플리케이션 배포"

JAR_PATH=$(ls -t /home/ec2-user/2021-jujeol-jujeol/deploy/*.jar | head -1)

sudo nohup java -jar -DServer.port=80 -Dspring.profiles.active=dev ${JAR_PATH} >> /home/ec2-user/2021-jujeol-jujeol/logs/jujeol.log &
