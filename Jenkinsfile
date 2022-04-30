pipeline {
    agent any

    environment {
        NEXUS_IP = '192.168.56.101'
        STAGE_IP = '192.168.56.102'
        PRODUCTION_IP = '192.168.56.103'
        NEXUS_REPOSITORY = 'word-cloud-build'
        ARTIFACT_ID = 'word-cloud-generator'
        NEXUS_CREDENTIALSID = '213dd042-007a-4878-8b63-890c258cc055'
        STAGE = credentials('66c5407b-9f69-4c88-8540-ff721e5343b9')
        PRODUCTION = credentials('66c5407b-9f69-4c88-8540-ff721e5343b9')
        INSTALL = ''' sshpass -p ${PASSWORD} ssh -T -o StrictHostKeyChecking=no ${USER}@${IP} << EOF
                      sudo service wordcloud stop
                      curl -X GET "http://${NEXUS_IP}:8081/repository/${NEXUS_REPOSITORY}/1/${ARTIFACT_ID}/1.$BUILD_NUMBER/${ARTIFACT_ID}-1.$BUILD_NUMBER.gz" -o /opt/wordcloud/${ARTIFACT_ID}.gz
                      gunzip -f /opt/wordcloud/${ARTIFACT_ID}.gz 
                      chmod +x /opt/wordcloud/${ARTIFACT_ID}
                      sudo service wordcloud start
                      exit 0'''
        TEST = '''res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://${STAGE_IP}:8888/version | jq '. | length'`
                if [ "1" != "$res" ]; then
                  exit 99
                fi
                res=`curl -s -H "Content-Type: application/json" -d '{"text":"ths is a really really really important thing this is"}' http://${STAGE_IP}:8888/api | jq '. | length'`
                if [ "7" != "$res" ]; then
                  exit 99
                fi'''
    }

    tools {
        go 'Go_1.16'
    }

    stages {

        stage('Clone git durectory') {
            steps {
                git url: 'https://github.com/Fenikks/word-cloud-generator'
            }
        }

        stage('Check code and test') {
            steps {
                sh '''make lint
                      make test '''
            }
        }

        stage('Shell script') {
            steps {
                sh '''export GOPATH=$WORKSPACE/go
                      export PATH="$PATH:$(go env GOPATH)/bin"
                      go get github.com/tools/godep   
                      go get github.com/smartystreets/goconvey
                      go get github.com/GeertJohan/go.rice/rice
                      go get github.com/wickett/word-cloud-generator/wordyapi
                      go get github.com/gorilla/mux

                      sed -i "s/1.DEVELOPMENT/1.$BUILD_NUMBER/g" static/version

                      GOOS=linux GOARCH=amd64 go build -o ./artifacts/${ARTIFACT_ID} -v .

                      gzip artifacts/${ARTIFACT_ID}
                      mv artifacts/${ARTIFACT_ID}.gz artifacts/${ARTIFACT_ID}

                      ls -l artifacts/'''
            }
        }

        stage('NEXUS upload') {
            steps {
                nexusArtifactUploader (
                    artifacts: 
                    [[artifactId: "${ARTIFACT_ID}", 
                    classifier: '', file: "artifacts/${ARTIFACT_ID}",
                    type: 'gz']],
                     credentialsId: "${NEXUS_CREDENTIALSID}", 
                     groupId: '1', nexusUrl: "${NEXUS_IP}:8081", 
                     nexusVersion: 'nexus3', protocol: 'http', 
                     repository: "${NEXUS_REPOSITORY}", version: '1.$BUILD_NUMBER'
                )
            }
        }

        stage('Install on staging server') {
            steps {
                withEnv(["USER=${STAGE_USR}", "PASSWORD=${STAGE_PSW}", "IP=${STAGE_IP}"]) {
                    sh " ${INSTALL} "
                }

            }

        }

        stage('Parallel Test staging') {
            steps {
                parallel (
                    "firstTask" : {
                        sh  " ${TEST} "
                    },
                    "secondTask" : {
                        sh  " ${TEST} "
                    }
                )
            }
        }

        stage('Install on production server') {
            steps {
                withEnv(["USER=${PRODUCTION_USR}", "PASSWORD=${PRODUCTION_PSW}", "IP=${PRODUCTION_IP}"]) {
                    sh " ${INSTALL} "
                }

            }
        }
    }
}
