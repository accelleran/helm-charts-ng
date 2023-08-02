{{- define "accelleran.cu-cp.sctp-f1.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.sctp-f1.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.sctp-f1.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "sctp-f1" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: sctpF1
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
