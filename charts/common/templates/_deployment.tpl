{{- define "accelleran.common.deployment" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common deployment" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $autoscaling := default (dict "enabled" false) (get $values "autoscaling") -}}

apiVersion: apps/v1
kind: Deployment
{{ include "accelleran.common.metadata" . }}
spec:
  {{- if not $autoscaling.enabled }}
  replicas: {{ $values.replicaCount | default 1 }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "accelleran.common.selectorLabels" . | nindent 6 }}
  template:
    {{- include "accelleran.common.pod.tpl" . | nindent 4 }}
{{- end -}}
