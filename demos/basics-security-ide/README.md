# Demo: Static Application Security Testing (SAST) & Software Composition Analysis (SCA) for IDE's

## Pre requisites

1. Java code sample
2. VS Code or IntelliJ with JFrog IDE plugin installed
3. Optional - 1 Watch + 1 Policy

## Demo

1. Open IDE with source code
2. Demo how to
    * configure the connection to the JFrog Platform (CLI)
    * trigger a scan (Refresh button) to display vulnerabilities (SAST + SCA)
3. Show SCA (vulnerabilities + exposures) + SAST
    * pick up a some vulnerabilities and SAST issues and show the vulnerability details
    * For SAST, you can ignore issues with adding a comment "jfrog-ignore"
4. To reduce the list of vulnerabilities, we'll display only violations (applicable) with remediations
5. Show a pre configured watch + policy to filter only high violations with remediation + applicable
    * explain that SAST issues aren't managed via Policies and Watches (only SCA issues)
6. Set the watch in the IDE
7. Show remaining violations in the IDE
