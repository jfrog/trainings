# Demo: Package types & Repository types

Go to Artifactory > Repositories screen, click on "Create a repository" button

Show the pre-built Setup

Select Local and present all the package types

+ Highlight recent features : Hugging Face for ML, OCI repo for Container image and Helm Chart
+ Some package types have specificities such retention mechanism for maven & Container images (Docker & OCI)

Select OCI package type and present basic config :

+ layout
+ include /exclude patterns
+ environments (for Release Lifecycle Management & JFrog Project)

Cancel the creation and create a remote repository. Present remonte config:

+ authentication (pass or client certi)
+ offline mode
+ cleanup unused artifacts
+ remote updates from source
+ store artifacts locally

Cancel the creation and create a virtual repository. Present virtual config:

+ aggregation of local and remote
+ set order per repo type
+ default deployment
+ specific config per package type (maven, npm)

For the release bundle & federated and repositories, we'll deep dive later during the session
