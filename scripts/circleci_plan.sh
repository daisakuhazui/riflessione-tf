#!/bin/sh

if [ ${CIRCLE_BRANCH} == "master" ]; then
  terraform plan -input=false -out=terraform.plan
  terraform plan | ./scripts/tfnotify --config ./tfnotify.yml plan
else
  terraform plan -input=false -out=terraform.plan
  terraform plan | ./scripts/tfnotify --config ./tfnotify_github.yml plan
fi
