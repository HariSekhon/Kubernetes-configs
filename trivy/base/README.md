# Trivy Server on Kubernetes

This massively speeds up Trivy scans by avoiding each agent having to spend 15 minutes downloading vulnerability DBs on each ephemeral Jenkins agent for every pipeline run.

For how to use this Trivy Server in CI/CD, see:

https://github.com/HariSekhon/Jenkins#readme

and specifically:

https://github.com/HariSekhon/Jenkins/blob/master/Jenkinsfile

and `trivy*.groovy` under:

https://github.com/HariSekhon/Jenkins/tree/master/vars
