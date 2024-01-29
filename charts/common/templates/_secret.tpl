{{- define "accelleran.common.secret" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common secret" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $type := get . "type" | default "Opaque" -}}

{{- $data := get . "data" | default dict -}}
{{- $stringData := get . "stringData" | default dict -}}

apiVersion: v1
kind: Secret
type: {{ $type | quote }}
{{ include "accelleran.common.metadata" . }}
{{- with $data }}
data:
  {{- . | toYaml | nindent 2 -}}
{{- end }}
{{- with $stringData }}
stringData:
  {{- . | toYaml | nindent 2 -}}
{{- end }}
{{- end -}}
