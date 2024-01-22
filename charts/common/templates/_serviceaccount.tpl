{{- define "accelleran.common.serviceAccount" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service account" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if ($values.serviceAccount).create -}}

{{- $name := include "accelleran.common.serviceAccount.name" . -}}
{{- $annotations := include "accelleran.common.serviceAccount.annotations" . | fromYaml -}}

apiVersion: v1
kind: ServiceAccount
{{ include
      "accelleran.common.metadata"
      (mergeOverwrite
        (deepCopy .)
        (dict "name" $name "annotations" $annotations)
      )
}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.serviceAccount.name" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service account name" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if ($values.serviceAccount).create }}
  {{- ($values.serviceAccount).name | default (include "accelleran.common.fullname" .) }}
{{- else }}
  {{- ($values.serviceAccount).name | default "default" }}
{{- end }}
{{- end -}}


{{- define "accelleran.common.serviceAccount.annotations" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service account annotations" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with (get $values.serviceAccount "annotations") -}}
{{- . | toYaml -}}
{{- end -}}
{{- end -}}
