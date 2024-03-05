# Demo: Binding Tokens & Federated Repositories

## Pre requisites

1. 2 JPDs with at least 1 Mission Control enabled
2. Circle Of Trust via binding tokens
3. The following repositories :

   Repo type | Repo key | Environment | Comment
   ---|---|--- |---
   FEDERATED | green-oci-dev-fed | DEV |

## Demo

First, demonstrate how to use binding tokens:

1. In the Administration menu, navigate to "Platform Management" -> "Deployment Bindings".
2. Focus on the "Federated Repositories" tab, and click "Add Binding" -> "Federated Repository".
3. Select the main JPD and any other JPD to create bindings for. NOTE - you can only select full
   Artifactory instances; Artifactory Edge can't host federated repositories.
4. Click "Apply", then "Create".
