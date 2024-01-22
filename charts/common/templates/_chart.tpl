{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "accelleran.common.chart" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common chart" -}}
{{- $name := include "accelleran.common.name" . -}}
{{- $helmVersion := include "accelleran.common.helmVersion" . -}}
{{- printf "%s-%s" $name $helmVersion | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
The name of a higher level application this one is part of. This is only relevant to subcharts, and should be the name of the top level chart.
*/}}
{{- define "accelleran.common.topChart.name" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common top chart name" -}}
{{- if ((($.Values).global).topChart).name -}}
{{- $.Values.global.topChart.name -}}
{{- end -}}
{{- end -}}


{{/*
The version of the umbrella chart this is part of. This is only relevant to subcharts, and should be the version of the top level chart.
*/}}
{{- define "accelleran.common.topChart.helmVersion" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common top chart helm version" -}}
{{- if ((($.Values).global).topChart).helmVersion -}}
{{- $.Values.global.topChart.helmVersion -}}
{{- end -}}
{{- end -}}
