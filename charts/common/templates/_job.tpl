{{- define "accelleran.common.job" -}}
apiVersion: batch/v1
kind: Job
{{ toYaml (merge
    (fromYaml (include "accelleran.common.job.name" .))
    (fromYaml (include "accelleran.common.job.tpl" .))
) }}
{{- end -}}


{{- define "accelleran.common.job.name" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common job name" -}}

{{- $name := get . "name" | default (include "accelleran.common.fullname" .) -}}

metadata:
  name: {{ $name | quote }}
{{- end -}}


{{- define "accelleran.common.job.tpl" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common job tpl" -}}

{{- $backoffLimit := get . "backoffLimit" -}}

metadata:
  labels:
    {{- include "accelleran.common.labels" . | nindent 4 }}
spec:
  # ttlSecondsAfterFinished: 600 # k8s v1.23
  {{- with $backoffLimit }}
  backoffLimit: {{ . }}
  {{- end }}
  template:
    {{- include "accelleran.common.pod.tpl" (mergeOverwrite (deepCopy .) (fromYaml (include "accelleran.common.job.pod.restartPolicy" .))) | nindent 4 }}
{{- end -}}

{{- define "accelleran.common.job.pod.restartPolicy" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common job pod restart policy" -}}

{{- $restartPolicy := get . "restartPolicy" -}}

{{- if not (or (eq $restartPolicy "Never") (eq $restartPolicy "OnFailure")) -}}
restartPolicy: OnFailure
{{- end -}}
{{- end -}}
