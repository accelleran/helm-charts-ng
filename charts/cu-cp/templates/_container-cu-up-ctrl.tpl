{{- define "accelleran.cu-cp.cu-up-ctrl.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.cu-up-ctrl.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.cu-up-ctrl.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "cu-up-controller" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: cuUpController
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}