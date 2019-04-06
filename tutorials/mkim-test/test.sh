#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export fly_target=${fly_target:-tutorial}
echo "Concourse API target ${fly_target}"
echo "Tutorial $(basename $DIR)"

pushd $DIR
  fly -t ${fly_target} set-pipeline -p test-job -c test-job.yml -n
  fly -t ${fly_target} unpause-pipeline -p test-job
  fly -t ${fly_target} trigger-job -w -j test-job/job-hello-world
popd
