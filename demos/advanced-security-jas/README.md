# Demo: Contextual Analysis & Secret detection

## Pre requisites

1. The following repositories assigned to the JFrog Project

   Repo type | Repo key | Environment | Comment
   ---|---|--- |---
   LOCAL | green-maven-dev-local | DEV |
   LOCAL | green-maven-rc-local | DEV |
   LOCAL | green-maven-release-local | PROD |
   LOCAL | green-maven-prod-local | PROD |
   REMOTE | mavencentral-remote | DEV |
   VIRTUAL | green-maven  | DEV | include the 3 repos above and set default deployement to  green-rc-maven-local

2. 1 Xray policy & watch

## Demo

Show how to enable JAS
Explain JAS capabilities per package type
Select a package with vulnerabilities & exposure
Go over the dashboard :

* applicability
* exposures (secrets, services, applications)
