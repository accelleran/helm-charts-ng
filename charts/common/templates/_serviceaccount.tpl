{{- define "accelleran.common.serviceAccount" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service account" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if ($values.serviceAccount).create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "accelleran.common.serviceAccount.name" . | quote }}
  labels:
    {{- include "accelleran.common.labels" . | nindent 4 }}
  {{- with $values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.serviceAccount.name" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service account name" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if ($values.serviceAccount).create }}
  {{- ($values.serviceAccount).name | default (include "accelleran.common.fullname" .) }}
{{- else }}
  {{- ($values.serviceAccount).name | default "default" }}
{{- end }}
{{- end -}}
