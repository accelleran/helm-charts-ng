{{/*
The Radio Access Technology provided by this component
*/}}
{{- define "accelleran.common.drax.technology" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax technology" -}}
{{- $values := get . "values" | default $.Values -}}

{{- ($values.drax).technology | default ($.Values.drax).technology -}}
{{- end -}}


{{/*
The Role this component serves in the overall application
*/}}
{{- define "accelleran.common.drax.role" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax role" -}}
{{- $values := get . "values" | default $.Values -}}

{{- ($values.drax).role | default ($.Values.drax).role -}}
{{- end -}}
