# Demo: Access Federation & Mission Control

Describe the UI components of Mission Control:

* The Topology view
* The License Buckets view
* The Platform Management view

Then, from the Administration sidebar, navigate to "User Management" -> "Access Federation".

Explanation:

Each row in the table corresponds to a single JPD, which is specified in the "Source" column.

For each JPD, you can configure where it broadcasts security entities to, and what type of entities. You do this
by hovering on the right hand side of the row, and clicking the "Edit" button.

The UI contains useful shortcuts which allow you to apply commonly-used topologies:

* Star topology
* Mesh topology

You can apply as many topologies as you'd like.

When selecting a topology, you need to select the participants. For example, for a star topology,
you need to select which JPD is the source and which are the targets.

Then, you need to select the entity types.

Then, you can apply the topology.

There is a prerequisite to all of this: a circle of trust must be established ahead of time. This is already
done automatically for you in the SaaS offering. In the self-hosted offering, this is a process that you need to
perform yourself, as a post-installation step after you add additional JPD's.
