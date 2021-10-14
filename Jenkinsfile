pipeline {
    agent any
    environment {
        server_ip = "18.224.71.91"
        server_login = "ubuntu"
        awskey = "~/.ssh/awskey.pem"
    }
    stages {
        stage('get') {
            steps {
                sh "if [ -e ./spring-boot-hello-world-rest ];then cd ./spring-boot-hello-world-rest && git pull;else git clone https://github.com/wyona/spring-boot-hello-world-rest;fi;test -d wyona || mkdir wyona; wget https://raw.githubusercontent.com/jencvua1/deploy-wyona-spring-boot-hello-world-rest/main/wyona.st -O ./wyona/wyona.st"
            }
        }
        stage('build') {
            steps {
                sh "cd ./spring-boot-hello-world-rest; pwd;if [ -e ./target ]; then rm -rf ./target;fi; mvn clean install"
            }
        }
        stage('test') {
            steps {
                sh "screen -dmS hellow java -jar ./spring-boot-hello-world-rest/target/hello-world-webapp-1.0.0-SNAPSHOT.war; sleep 10; if netstat -lpntu | grep -q :8080; then echo test ok;else exit 123;fi;screen -S hellow -X quit"  
            }
        }
        stage('deploy') {
            steps {
                sh "cp ./spring-boot-hello-world-rest/target/hello-world-webapp-1.0.0-SNAPSHOT.war ./wyona; scp -oStrictHostKeyChecking=no -r -i $awskey ./wyona $server_login@$server_ip:./"

            }
        }
        stage('restart') {
            steps {
                sh "ssh -i $certaws $server_login@$server_ip 'if [ ! -w /opt/wyona ]; then sudo mkdir wyona; sudo chown '$server_login:$server_login' /opt/wyona;fi; cp ~/wyona/hello-world-webapp-1.0.0-SNAPSHOT.war /opt/wyona; chmod +x ~/wyona/wyona.st; ~/wyona/wyona.st restart'"      

            }
        }
    }
}
