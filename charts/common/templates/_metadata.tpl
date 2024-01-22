{{- define "accelleran.common.metadata" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common metadata" -}}

{{- $name := get . "name" | default (include "accelleran.common.fullname" .) -}}
{{- $labels := include "accelleran.common.labels" . -}}
{{- $annotations := include "accelleran.common.annotations" . -}}

metadata:
  name: {{ $name | quote }}
  {{- with  $labels }}
  labels:
    {{- . | nindent 4 }}
  {{- end  }}
  {{- with  $annotations }}
  annotations:
    {{- . | nindent 4 }}
  {{- end  }}
{{- end -}}
