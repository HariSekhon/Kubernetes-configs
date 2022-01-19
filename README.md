Kubernetes configs
====================

[![Validation](https://github.com/HariSekhon/Kubernetes-config/actions/workflows/validate.yaml/badge.svg)](https://github.com/HariSekhon/Kubernetes-config/actions/workflows/validate.yaml)
[![Pluto](https://github.com/HariSekhon/Kubernetes-config/actions/workflows/pluto.yaml/badge.svg)](https://github.com/HariSekhon/Kubernetes-config/actions/workflows/pluto.yaml)
[![CI Builds Overview](https://img.shields.io/badge/CI%20Builds-Overview%20Page-blue?logo=circleci)](https://bitbucket.org/harisekhon/devops-bash-tools/src/master/STATUS.md)
[![Travis CI](https://img.shields.io/badge/TravisCI-legacy-lightgrey?logo=travis&label=Travis%20CI)](https://github.com/HariSekhon/Kubernetes-configs/blob/master/.travis.yml)

[![Repo on Azure DevOps](https://img.shields.io/badge/repo-Azure%20DevOps-0078D7?logo=azure%20devops)](https://dev.azure.com/harisekhon/GitHub/_git/Kubernetes-configs)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-2088FF?logo=github)](https://github.com/HariSekhon/Kubernetes-configs)
[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-FCA121?logo=gitlab)](https://gitlab.com/HariSekhon/Kubernetes-configs)
[![Repo on BitBucket](https://img.shields.io/badge/repo-BitBucket-0052CC?logo=bitbucket)](https://bitbucket.org/HariSekhon/Kubernetes-configs)

[![GitHub Last Commit](https://img.shields.io/github/last-commit/HariSekhon/Kubernetes-configs?logo=github)](https://github.com/HariSekhon/Kubernetes-configs/commits/master)
[![Lines of Config](https://img.shields.io/badge/lines%20of%20config-12k-lightgrey?logo=codecademy)](https://github.com/HariSekhon/Kubernetes-configs)
[![GitHub stars](https://img.shields.io/github/stars/HariSekhon/Kubernetes-configs?logo=github)](https://github.com/HariSekhon/Kubernetes-configs//stargazers)
[![GitHub forks](https://img.shields.io/github/forks/HariSekhon/Kubernetes-configs?logo=github)](https://github.com/HariSekhon/Kubernetes-configs/network)

[git.io/k8s-configs](https://git.io/k8s-configs)

## Intro

Advanced Kubernetes YAML configurations & templates, based on my experiences running Kubernetes in production at different companies.

Contains various Best Practices, Tips & Tricks learned over time in production environments.

## Templates

Start with [deployment.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/deployment.yaml) / [statefulset.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/statefulset.yaml), for advanced users see [kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/kustomization.yaml).

The [service.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/service.yaml) contains config for using static public IP and locking down your GKE generated GCP firewall rules, Cloudflare proxied IPs etc.

## Apps

Real-world app deployment examples, tuning and patches are found in the more specific `<app>-kustomization.yaml` and `<app>-*.yaml` configs.

## CI/CD

Advanced auto-scaling production-grade CI/CD on Kubernetes:

- [ArgoCD](https://argoproj.github.io/cd/) - deployment, configs and optimizations. Start here: [argocd-kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/argocd-kustomization.yaml)
- [Jenkins](https://www.jenkins.io/) - jenkins server and dynamically scaling agents on kubernetes. Start here: [jenkins-kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/jenkins-kustomization.yaml)
  - see also: [Jenkins](https://github.com/HariSekhon/Jenkins) repo with advanced Jenkinsfile & Jenkins Shared Library
- [TeamCity](https://www.jetbrains.com/teamcity/) - teamcity server and dynamically scaling agents on kubernetes. Start here: [teamcity-kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/teamcity-kustomization.yaml)
- [Selenium Grid](https://www.selenium.dev/documentation/grid/) - simple and distributed auto-scaling deployments. Start here: [selenium-grid-kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/selenium-grid-kustomization.yaml) / [selenium-grid-distributed-kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/selenium-grid-distributed-kustomization.yaml)

## Helm + Kustomize integration

See [kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/kustomization.yaml) for 2 methods provided:

1. template the Helm chart using a `values.yaml` to Git and serve from there (see [DevOps Bash Tools](https://github.com/harisekhon/devops-bash-tools) for the `helm_template.sh` convenience script)
2. dynamically load the Helm chart from upstream with a `values.yaml`

...then patch override anything the chart doesn't directly support using the standard Kustomize patching examples given in the [kustomization.yaml](https://github.com/HariSekhon/Kubernetes-configs/blob/master/kustomization.yaml).

## Further Documention

The best documentation links are provided at the top of each yaml for fast referencing (my advanced [.vimrc](https://github.com/HariSekhon/DevOps-Bash-tools/blob/master/.vimrc) can open these URLs from the current file via a hotkey!)

## Environment Enhancements

[.envrc](https://github.com/HariSekhon/Kubernetes-configs/blob/master/.envrc) - use with `direnv` to auto-load correct Kubernetes context isolated to current shell to avoid race conditions between shells and scripts caused by naively changing the global `~/.kube/config` context

Shortcut symlinks are for faster instantiation from these configs using the standard kubernetes shortcuts such as `new pvc.yaml` - see the [Templates](https://github.com/HariSekhon/Templates) repo for more details on the `new` command to fast create new files from templates.

## History

Forked from the [DevOps Perl tools](https://github.com/HariSekhon/DevOps-Perl-tools) repo, this is now a submodule of the [Templates](https://github.com/HariSekhon/Templates) repo which is a submodule of the DevOps [Bash](https://github.com/harisekhon/devops-bash-tools), [Perl](https://github.com/HariSekhon/DevOps-Perl-tools) and [Python](https://github.com/harisekhon/devops-python-tools) tools repos.

### See Also

- [DevOps Bash Tools](https://github.com/harisekhon/devops-bash-tools) - 700+ DevOps Bash Scripts, Advanced `.bashrc`, `.vimrc`, `.screenrc`, `.tmux.conf`, `.gitconfig`, CI configs & Utility Code Library - AWS, GCP, Kubernetes, Docker, Kafka, Hadoop, SQL, BigQuery, Hive, Impala, PostgreSQL, MySQL, LDAP, DockerHub, Jenkins, Spotify API & MP3 tools, Git tricks, GitHub API, GitLab API, BitBucket API, Code & build linting, package management for Linux / Mac / Python / Perl / Ruby / NodeJS / Golang, and lots more random goodies

- [Jenkins](https://github.com/harisekhon/jenkins) - Advanced Jenkinsfile & Jenkins Shared Library

- [GitHub-Actions](https://github.com/HariSekhon/GitHub-Actions) - GitHub Actions master template & GitHub Actions Shared Workflows library

- [Templates](https://github.com/HariSekhon/Templates) - dozens of Code & Config templates - AWS, GCP, Docker, Jenkins, Terraform, Vagrant, Puppet, Python, Bash, Go, Perl, Java, Scala, Groovy, Maven, SBT, Gradle, Make, GitHub Actions Workflows, CircleCI, Jenkinsfile, Makefile, Dockerfile, docker-compose.yml, M4 etc.

- [SQL Scripts](https://github.com/HariSekhon/SQL-scripts) - 100+ SQL Scripts - PostgreSQL, MySQL, AWS Athena, Google BigQuery

- [DevOps Python Tools](https://github.com/harisekhon/devops-python-tools) - 80+ DevOps CLI tools for AWS, GCP, Hadoop, HBase, Spark, Log Anonymizer, Ambari Blueprints, AWS CloudFormation, Linux, Docker, Spark Data Converters & Validators (Avro / Parquet / JSON / CSV / INI / XML / YAML), Elasticsearch, Solr, Travis CI, Pig, IPython

- [DevOps Perl Tools](https://github.com/harisekhon/perl-tools) - 25+ DevOps CLI tools for Hadoop, HDFS, Hive, Solr/SolrCloud CLI, Log Anonymizer, Nginx stats & HTTP(S) URL watchers for load balanced web farms, Dockerfiles & SQL ReCaser (MySQL, PostgreSQL, AWS Redshift, Snowflake, Apache Drill, Hive, Impala, Cassandra CQL, Microsoft SQL Server, Oracle, Couchbase N1QL, Dockerfiles, Pig Latin, Neo4j, InfluxDB), Ambari FreeIPA Kerberos, Datameer, Linux...

- [The Advanced Nagios Plugins Collection](https://github.com/harisekhon/nagios-plugins) - 450+ programs for Nagios monitoring your Hadoop & NoSQL clusters. Covers every Hadoop vendor's management API and every major NoSQL technology (HBase, Cassandra, MongoDB, Elasticsearch, Solr, Riak, Redis etc.) as well as message queues (Kafka, RabbitMQ), continuous integration (Jenkins, Travis CI) and traditional infrastructure (SSL, Whois, DNS, Linux)

- [HAProxy Configs](https://github.com/HariSekhon/HAProxy-configs) - 80+ HAProxy Configs for Hadoop, Big Data, NoSQL, Docker, Elasticsearch, SolrCloud, HBase, Cloudera, Hortonworks, MapR, MySQL, PostgreSQL, Apache Drill, Hive, Presto, Impala, ZooKeeper, OpenTSDB, InfluxDB, Prometheus, Kibana, Graphite, SSH, RabbitMQ, Redis, Riak, Rancher etc.

- [Dockerfiles](https://github.com/HariSekhon/Dockerfiles) - 50+ DockerHub public images for Docker & Kubernetes - Hadoop, Kafka, ZooKeeper, HBase, Cassandra, Solr, SolrCloud, Presto, Apache Drill, Nifi, Spark, Mesos, Consul, Riak, OpenTSDB, Jython, Advanced Nagios Plugins & DevOps Tools repos on Alpine, CentOS, Debian, Fedora, Ubuntu, Superset, H2O, Serf, Alluxio / Tachyon, FakeS3

[![Stargazers over time](https://starchart.cc/HariSekhon/Kubernetes-configs.svg)](https://starchart.cc/HariSekhon/Kubernetes-configs)

[git.io/k8s-configs](https://git.io/k8s-configs)
