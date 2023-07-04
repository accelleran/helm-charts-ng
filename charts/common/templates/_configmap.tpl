{{- define "accelleran.common.configMap" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common config map" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $name := get . "name" | default (include "accelleran.common.fullname" .) -}}
{{- $data := get . "data" | default dict -}}

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $name | quote }}
  labels:
    {{- include "accelleran.common.labels" . | nindent 4 }}
data:
  {{- $data | toYaml | nindent 2 -}}
{{- end -}}
