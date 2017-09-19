# Aexoden's Gentoo Overlay

Welcome to my Gentoo overlay. The primary purpose of this overlay is to provide
fixed version of packages that currently do not build on Gentoo. (This is
surprisingly common, and the problems will often languish unfixed for months,
despite patches being available even in the Gentoo Bugzilla.)

Versioning will mostly follow a pattern that will maximize the chance that the
official Gentoo version will take over when it is uploaded. In other words, a
fixed package will almost certainly have the exact same version as the package
it fixes. Build fixes in the official repository will not always result in a
revbump, however, so ebuilds in this repository may occasionally mask fixed
versions in the official repository. I will remove these as I become aware of
them.

There may also be occasional ebuilds that do not merely fix build issues, but
these should be limited to either minor version bumps or packages that are not
otherwise available.

