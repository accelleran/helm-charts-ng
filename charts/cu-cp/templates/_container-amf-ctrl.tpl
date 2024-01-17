{{- define "accelleran.cu-cp.amf-ctrl.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.amf-ctrl.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.amf-ctrl.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "amf-controller" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: amfController
{{- with (include "accelleran.common.bootstrap.instanceId" (dict "top" $)) }}
  - name: INSTANCE_FILTER
    value: {{ . | quote }}
{{- end }}
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
