node {

    parameters
    {
    string(name:'BackendRevision', defaultValue:'master', description: 'Revision number to be included into docker image.'),
    /*BackendRevision  take the docker image from commit  and stan up in there*/

    string(name:'BackendBranch', defaultValue:'none')
    /*BackendBranch declarate the branch where the BackendRevision will be take the docker image*/

    }
    stages{

    stage('Build image')
    /*In this stage use the parameters for built the docker image in the direccion established*/
    {
        sh "/usr/bin/docker build -t backend-practica --build-arg BACKEND_REVISION=${params.BackendRevision} . "
        echo "current git revision ${params.BackendRevision}"
    }

    stage('Test image') {
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
            sh 'docker tag backend-practica dinocloud/backend-practica:$(echo $params.BackendBranch   | sed -e "s|origin/||g")'
            sh 'docker push dinocloud/backend-practica:$(echo $params.BackendBranch   | sed -e "s|origin/||g")'
        }

    }

    }
}

