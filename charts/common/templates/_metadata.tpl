{{- define "accelleran.common.metadata" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common metadata" -}}

metadata:
  name: {{ include "accelleran.common.fullname" . | quote }}
  labels:
    {{- include "accelleran.common.labels" . | nindent 4 }}
{{- end -}}
