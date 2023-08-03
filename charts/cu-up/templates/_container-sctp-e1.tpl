{{- define "accelleran.cu-up.sctp-e1.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-up.sctp-e1.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-up.sctp-e1.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "e1-sctp-up" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: e1SctpUp
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
