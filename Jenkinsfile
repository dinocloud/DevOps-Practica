node {
    def app

    parameters
    {
    string(name:'BACKEND_REVISION', defaultValue:'none', description: 'Revision number to be included into docker image.'),
    string(name:'BACKEND_BRANCH', defaultValue:'none')
    }
    stages{
    stage('Checkout')
    {
        checkout([$class: 'GitSCM', branches: [[name: '*']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/dinocloud/DevOps-Practica']]])
        echo "current git revision ${env.BACKEND_REVISION}"
        echo "current branch revision ${env.BACKEND_BRANCH}"
    }

    stage('Build image')
    {
        sh "/usr/bin/docker build -t backend-practica --build-arg BACKEND_REVISION=${env.BACKEND_REVISION} . "
    }

    stage('Test image') {
        echo "credential ${env.DOCKER_REGISTRY_CREDENTIAL}"
        //app.inside {
        //    sh 'echo "Tests passed"'
        //}
    }

    stage('Push image')
    {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */

        withCredentials([usernamePassword(credentialsId: '48253a45-d82c-43c8-b39e-031c511bc475', passwordVariable: 'DOCKER_REGISTRY_PASS', usernameVariable: 'DOCKER_REGISTRY_USER')]) {
            sh "docker login --username=${DOCKER_REGISTRY_USER} --password=${DOCKER_REGISTRY_PASS}"
            sh 'docker tag backend-practica dinocloud/backend-practica:$(echo $BACKEND_BRANCH   | sed -e "s|origin/||g")'
            sh 'docker push dinocloud/backend-practica:$(echo $BACKEND_BRANCH   | sed -e "s|origin/||g")'
        }

    }

    }
}

