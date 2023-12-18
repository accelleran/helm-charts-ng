{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "accelleran.service-monitor.name" -}}
{{- $name := printf "%s-%s" .Chart.Name .Chart.Version -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "accelleran.service-monitor.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default (include "accelleran.service-monitor.name" .) .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "accelleran.service-monitor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "accelleran.service-monitor.labels" -}}
helm.sh/chart: {{ include "accelleran.service-monitor.chart" . }}
{{ include "accelleran.service-monitor.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
drax/role: ric
drax/name: ServiceMonitor
drax/component-name: {{ .Chart.Name }}
drax/component-version: {{ .Chart.Version }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "accelleran.service-monitor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "accelleran.service-monitor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "accelleran.service-monitor.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "accelleran.service-monitor.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
