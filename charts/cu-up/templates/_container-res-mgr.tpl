{{- define "accelleran.cu-up.res-mgr.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-up.res-mgr.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-up.res-mgr.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "res-mgr-up" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: resourceManagerUp
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
