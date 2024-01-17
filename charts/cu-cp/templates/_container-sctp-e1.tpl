{{- define "accelleran.cu-cp.sctp-e1.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.sctp-e1.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.sctp-e1.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "sctp-e1" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: sctpE1
{{- with (include "accelleran.common.bootstrap.instanceId" (dict "top" $)) }}
  - name: INSTANCE_FILTER
    value: {{ . | quote }}
{{- end }}
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
