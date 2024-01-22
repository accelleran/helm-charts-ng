{{- define "accelleran.common.cronjob" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common cronjob" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $successfulJobsHistoryLimit := get . "successfulJobsHistoryLimit" -}}
{{- $failedJobsHistoryLimit := get . "failedJobsHistoryLimit" -}}

apiVersion: batch/v1
kind: CronJob
{{ include "accelleran.common.metadata" . }}
spec:
  schedule: {{ $values.schedule | quote }}
  {{- if ne $successfulJobsHistoryLimit nil }}
  successfulJobsHistoryLimit: {{ $successfulJobsHistoryLimit }}
  {{- end }}
  {{- if ne $failedJobsHistoryLimit nil }}
  failedJobsHistoryLimit: {{ $failedJobsHistoryLimit }}
  {{- end }}
  jobTemplate:
    {{- include "accelleran.common.job.tpl" . | nindent 4 }}
{{- end -}}
