# Common library charts

This chart contains templates for commonly used objects within the helm charts.

## Template interface

All templates in helm have the limitation that only one argument can be provided as input and
a string will be given back as output.
In accelleran's common templates the input is always a dictionary with named arguments.
This allows to pass multiple arguments to accelleran's common templates.

There is only one required argument for all templates, namely `"top"`.
It's value should always be the root context of the chart, namely `$`.
In order to retain access to the root context it needs to be passed down.
Because within templates `$` will evaluate to the single passed down argument
instead of the root context.

Optionally, `"values"` can be provided as a second argument to all of the templates.
By default it will fall back to the `.Values` within the root context.
This is mostly useful to conditionally overwrite some values or provide subchart values.

Other keys that are provided through the dictionary will depend on the template itself.

By using this structure consistently a user of these templates will know what to expect.
Also passing down arguments to dependency templates becomes easy as this can be done with just a dot (`.`).

## Values interface

The common library charts will dictate what the values files look like for the application charts that use it.
For example the image for a container needs specific keys in the values file:

```yaml
image:
  repository: accelleran/cuup-netconf
  tag: ""
```

This structure should either be present in the root level of a chart or in the custom values that are passed down (e.g. subchart values).
In the case of the image tag it will also fall back to the `.Chart.AppVersion` when providing an empty string.
The tag in the values file is then present to allow overriding that value.
A deeper look into the templates will be needed to know what has defaults and what they are.
