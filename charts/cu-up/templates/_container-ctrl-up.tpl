{{- define "accelleran.cu-up.ctrl-up.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-up.ctrl-up.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-up.ctrl-up.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "controller-up" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: controllerUp
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
