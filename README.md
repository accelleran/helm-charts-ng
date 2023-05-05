# Helm charts

This repository contains accelleran's helm charts.

## Chart dependencies

For helm chart dependencies the required repository needs to be added.
In case a new dependency repository is needed it should be added to `bin/add-repos`.
Otherwise the workflow will be broken as helm would be unable to build the chart dependencies.

To locally add all necessary repos:

```sh
./bin/add-repos
```

## New charts

A bit of setup is needed for release please when adding a new chart.
This is automated in `bin/add-chart`.

```sh
./bin/add-chart example 0.1.0
```

> The initial version is optional (default is `0.1.0`).

> **Note**
>
> When adding a new chart, the chart releaser action will always create an initial release without release please intervening.
> This means that the automatic changelog etc. will be missing in this initial GitHub release.
> Instead, chart releaser will use the description in `Chart.yaml` as the body of the GitHub release.

## Legacy charts

To add legacy helm charts, they need to be added to a release with the packaged chart as an asset.
This asset then needs to be linked to the `index.yaml` file for GitHub Pages.

The `release-legacy-chart` script expects either a directory of packaged charts or a single file (i.c.w. an index file).
The release tag etc. are derived from the file name.

```sh
 export GITHUB_TOKEN=abc-xyz

./bin/release-legacy-chart -f example-0.1.0.tgz -i index.yaml
./bin/release-legacy-chart -d charts
```

> Note the space to hide the token from history.
