{{- define "accelleran.cu-up.netconf.container" -}}
{{- include
      "accelleran.common.container"
      (fromYaml (include "accelleran.cu-up.netconf.container.args" .))
-}}
{{- end -}}


{{- define "accelleran.cu-up.netconf.container.args" -}}
{{- $ := . -}}
{{- $values := $.Values.netconf -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

env:
  - name: __APPNAME
    value: cuUpNetconf
envFrom:
  - configMapRef:
      name: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
