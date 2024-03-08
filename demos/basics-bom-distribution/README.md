# Demo: Distribute RBv2

## Pre requisites

1. Install JFrog Distribution
2. Enable Mission Control on main Artifactory
3. Reference the Edge node on Mission Control using a pairing token
4. Upload signing key pair (GPG or PGP) to Artifactory
5. Propagate signing public key to th Edge node
6. Create a RBv2

## Distribution process

1. From "Artifactory" > "Release Bundles v2", select the Release Bundle you would like to distribute.
2. In the panel that lists the bundle's versions, hover to the right, click the three dots, and select "Distribute".
3. Select the distribution targets.
4. Check the "Auto create missing repositories" checkbox.
5. Click "Distribute".

You will be sent back to the "Actions" panel, where you will see the distribution action.
Hover over the action's row to the right, and click "View Details" to show the distribution's progress.
