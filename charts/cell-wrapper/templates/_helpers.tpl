{{/*
Number of configured DUs
*/}}
{{- define "cell-wrapper.nDus" -}}
{{- len .Values.global.config.dus -}}
{{- end -}}

{{/*
Number of configured RUs
*/}}
{{- define "cell-wrapper.nRus" -}}
{{- $nRus := 0 -}}
{{- range $index, $du := .Values.global.config.dus -}}
  {{- $nRus = add $nRus (len $du.rus) -}}
{{- end -}}
{{- $nRus -}}
{{- end -}}

{{/*
Bootstrap ConfigMap name
*/}}
{{- define "cell-wrapper.bootstrap.configMapName" -}}
{{- $component := . -}}
{{ default (include "acc-common.fullname" .)-bootstrap $component.env.configMapName }}
{{- end -}}

{{/*
Replicas for the cw-inst deployment
*/}}
{{- define "cell-wrapper.instance.replicas" -}}
{{- default (add (len .Values.global.config.dus) .Values.spareInstanceCount) .Values.replicaCount -}}
{{- end }}
