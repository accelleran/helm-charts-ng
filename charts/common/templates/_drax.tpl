{{/*
The Radio Access Technology provided by this component
*/}}
{{- define "accelleran.common.drax.technology" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax technology" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if (($values).drax).technology -}}
{{- tpl $values.drax.technology . -}}
{{- end -}}
{{- end -}}


{{/*
The Role this component serves in the overall application
*/}}
{{- define "accelleran.common.drax.role" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax role" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if (($values).drax).role -}}
{{- tpl $values.drax.role . -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.drax.nodeSelector.enabled" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax node selector enabled" -}}
{{- $values := get . "values" | default $.Values -}}

{{- (eq (tpl (toString ($values.draxNodeSelectorEnabled)) $) "true") | default (eq (toString (($.Values).global).draxNodeSelectorEnabled) "true") -}}
{{- end -}}


{{- define "accelleran.common.drax.nodeSelector" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax node selector" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if eq (tpl (toString ($values.draxNodeSelectorEnabled)) $) "true" -}}
{{- tpl (toYaml $values.draxNodeSelector) $ }}
{{- else if eq (toString (($.Values).global).draxNodeSelectorEnabled) "true" -}}
{{- toYaml (($.Values).global).draxNodeSelector }}
{{- end -}}
{{- end -}}
