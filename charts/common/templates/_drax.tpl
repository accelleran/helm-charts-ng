{{- define "accelleran.common.drax.license.enabled" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax license enabled" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if ($values.accelleranLicense).enabled -}}
{{- tpl (toString ($values.accelleranLicense).enabled) $ -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.drax.license.name" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax license name" -}}
{{- $values := get . "values" | default $.Values -}}

{{ tpl $values.accelleranLicense.licenseSecretName $ }}
{{- end -}}


{{- define "accelleran.common.drax.license.volume" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax license volume" -}}

name: accelleran-license
secret:
  secretName: {{ include "accelleran.common.drax.license.name" . | quote }}
{{- end -}}


{{- define "accelleran.common.drax.license.volumeMount" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common drax license volumeMount" -}}

name: accelleran-license
subPath: "license.crt"
mountPath: "/etc/license/license.crt"
readOnly: true
{{- end -}}


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
