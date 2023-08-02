{{- define "accelleran.cu-cp.amfCount" -}}
{{- .Values.global.numOfAmfs -}}
{{- end -}}


{{- define "accelleran.cu-cp.cuUpCount" -}}
{{- .Values.global.numOfCuUps -}}
{{- end -}}


{{- define "accelleran.cu-cp.duCount" -}}
{{- .Values.global.numOfDus -}}
{{- end -}}


{{- define "accelleran.cu-cp.cellCount" -}}
{{- .Values.global.numOfCells -}}
{{- end -}}


{{- define "accelleran.cu-cp.ueCount" -}}
{{- .Values.global.numOfUes -}}
{{- end -}}


{{- define "accelleran.cu-cp.netconf.service.name" -}}
{{- $ := . -}}
{{ $.Values.netconf.service.name | default (printf "%s-%s" (include "accelleran.common.name" (dict "top" $ "values" $.Values.netconf)) (include "accelleran.common.bootstrap.instanceId" (dict "top" $ "values" $.Values.netconf))) }}
{{- end -}}


{{- define "accelleran.cu-cp.e1.service.name" -}}
{{- $ := . -}}
{{ index $.Values "sctp-e1" "service" "name" | default (include "accelleran.common.fullname" (dict "top" $ "values" (index $.Values "sctp-e1"))) }}
{{- end -}}


{{- define "accelleran.cu-cp.f1.service.name" -}}
{{- $ := . -}}
{{ index $.Values "sctp-f1" "service" "name" | default (include "accelleran.common.fullname" (dict "top" $ "values" (index $.Values "sctp-f1"))) }}
{{- end -}}
