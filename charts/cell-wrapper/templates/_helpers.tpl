{{- define "accelleran.cell-wrapper.netconf.service.name" -}}
{{- $ := . -}}
{{ $.Values.netconf.service.name | default (printf "%s-%s" (include "accelleran.common.name" (dict "top" $ "values" $.Values.netconf)) (include "accelleran.common.bootstrap.instanceId" (dict "top" $ "values" $.Values.netconf))) }}
{{- end -}}
