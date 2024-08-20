# Lab: Configure Push/Pull Replications

## Goals

Put in place a push and a pull replication

## Create a local generic repository in the source artifactory using the UI

Name it `<USERNAME>-test-generic-src-local`

## Create a local generic repository in the target artifactory using the UI

Name it `<USERNAME>-test-generic-target-local`

## Create a remote generic repository in the target artifactory using the UI

Name it `<USERNAME>-test-generic-target-remote`

## Push Replication
### Using the UI

1. Go in the Replication Properties of `<USERNAME>-test-generic-src-local` repository (Artifactory > Repositories > local > `Your repository` > Replications)
2. Select `+ Add Replication icon`
3. Complet mandatory field has done Here
4. Press `Test` (to check the connectivity) and `Save`
5. Enter a Cron Expression (to determines when the next replication will be triggered) `Ex: 0 15 10 * * ? *`
6. Select `Event replication`
7. Run the Replication
8. Check replication status (Platfom configuration > Topology > Replication)
![Alt text](../../images/course-3/configure_push_pull/topo_check.png)
9. Upload a simple text file to test the sync

### Pull replication

1. Go in the Replication Properties of `<USERNAME>-test-generic-src-remote` repository (Artifactory > Repositories > remote > <USERNAME>-test-generic-target-remote)
2. Change the URL with the artifactory url of `<USERNAME>-test-generic-src-local` (use the URL to file) fill `User Name` and `Password`
3. Press Test
4. Go on the `Replication` tab
5. Select `Enable Active Replication of this Repository`
6. Enter a Cron Expression (to determines when the next replication will be triggered) `Ex: 0 15 10 * * ? *`
7. Select `Event replication`
![Alt text](../../images/course-3/configure_push_pull/pull_repl.png)
8. Press `Test` (to check the connectivity) and `Save`
9. Upload a simple text file to test the sync
10. Run the Replication
11. Check replication status (Platfom configuration > Topology > Replication)
