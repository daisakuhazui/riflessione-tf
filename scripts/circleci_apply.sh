#!/bin/sh

terraform apply -input=false --auto-approve terraform.plan
