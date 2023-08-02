{{- define "accelleran.cu-cp.pm-ctrl.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.pm-ctrl.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.pm-ctrl.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "pm-controller" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: pmController
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
