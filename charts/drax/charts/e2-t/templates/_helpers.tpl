{{- define "accelleran.e2-t.e2NodeCount" -}}
{{- .Values.numOfE2Nodes -}}
{{- end -}}


{{- define "accelleran.e2-t.init.args" -}}
{{- $ := . -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $.Values | toYaml | nindent 2 }}

bootstrapConfigMapName: {{ include "accelleran.common.bootstrap.configMapName" (dict "top" $) | quote }}
{{- end -}}
