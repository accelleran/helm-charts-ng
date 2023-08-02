{{- define "accelleran.cu-cp.res-mgr.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-cp.res-mgr.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-cp.res-mgr.container.args" -}}
{{- $ := . -}}
{{- $values := index $.Values "res-mgr" -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: resourceManager
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
