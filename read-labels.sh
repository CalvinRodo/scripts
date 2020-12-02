#!/bin/bash

if [ $# -eq 0 ]; then
  echo "read-labels.sh orgname projname"
  exit 1
fi

gh api graphql -f query="
query { 
  organization(login:\"$1\"){
    repository(name:\"$2\"){
      labels(first:100){
        nodes{
          description,
          color,
          name
        }
      }
    }
  }
}" | jq -r '.data.organization.repository.labels.nodes[] | "- name: \(.name)
  description: \(.description)
  alias: []
  color: \"\(.color)\""'
