{{- define "accelleran.cu-cp.sctp-ng.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.sctp-ng.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.sctp-ng.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "sctp-ng" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: sctpNg
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
