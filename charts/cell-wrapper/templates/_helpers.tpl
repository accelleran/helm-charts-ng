{{/*
Number of configured DUs
*/}}
{{- define "accelleran.cell-wrapper.duCount" -}}
{{- len .Values.global.config.dus -}}
{{- end -}}


{{/*
Number of configured RUs
*/}}
{{- define "accelleran.cell-wrapper.ruCount" -}}
{{- $nRus := 0 -}}
{{- range $index, $du := .Values.global.config.dus -}}
  {{- $nRus = add $nRus (len (default list $du.rus)) -}}
{{- end -}}
{{- $nRus -}}
{{- end -}}


{{- define "accelleran.cell-wrapper.netconf.service.name" -}}
{{- $ := . -}}
{{ $.Values.netconf.service.name | default (printf "%s-%s" (include "accelleran.common.name" (dict "top" $ "values" $.Values.netconf)) (include "accelleran.common.bootstrap.instanceId" (dict "top" $ "values" $.Values.netconf))) }}
{{- end -}}
