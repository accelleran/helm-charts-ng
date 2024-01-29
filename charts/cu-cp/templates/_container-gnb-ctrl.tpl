{{- define "accelleran.cu-cp.gnb-ctrl.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.gnb-ctrl.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.gnb-ctrl.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "gnb-ctrl" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: gnbController
{{- with (include "accelleran.common.bootstrap.instanceId" (dict "top" $)) }}
  - name: INSTANCE_FILTER
    value: {{ . | quote }}
{{- end }}
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
