{{- define "accelleran.cu-cp.gnb-ctrl.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.gnb-ctrl.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.gnb-ctrl.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "gnb-controller" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: gnbController
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
