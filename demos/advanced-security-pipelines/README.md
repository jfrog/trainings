# Demo: Inject security in your CI pipelines

## Audit / Dependency scan

```bash
# scan dependencies before the build
jf audit --watches CI --fail=false --format=table
```

* Show steps in a CI pipeline (see ```secured-pipelines.sh```)
* Possibility to break a pipeline based on violations or vulnerabilities / compliance issues
* Show results (JSON, Array)

## On Demand scan

> On Demand scan performs recursive scans (while Audit doesn't)

```bash
   # scan the layers of the base image
   jf docker scan $MY_IMAGE --fail=false --format=table
```

* Show step in a CI pipeline (see ```secured-pipelines.sh```)
* Possibility to break a pipeline based on violations or vulnerabilities / compliance issues
* Show results (JSON, Array) + UI
