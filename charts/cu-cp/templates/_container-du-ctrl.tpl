{{- define "accelleran.cu-cp.du-ctrl.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.du-ctrl.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.du-ctrl.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "du-controller" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: duController
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
