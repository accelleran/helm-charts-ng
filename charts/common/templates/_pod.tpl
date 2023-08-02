{{- define "accelleran.common.pod.tpl" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common pod tpl" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $restartPolicy := get . "restartPolicy" -}}
{{- $volumes := get . "volumes" | default list -}}
{{- $initContainers := get . "initContainers" | default list -}}
{{- $containers := get . "containers" -}}
{{- if not $containers -}}
{{/*
Cannot use default as then the template is always evaluated
*/}}
{{-  $containers = list (fromYaml (include "accelleran.common.container" .)) -}}
{{- end -}}

metadata:
  labels:
    {{- include "accelleran.common.labels" . | nindent 4 }}
    {{- with $values.podLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with $values.podAnnotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- include "accelleran.common.pod.imagePullSecrets" . | nindent 2 -}}
  {{- include "accelleran.common.pod.serviceAccountName" . | nindent 2 -}}

  {{- with $restartPolicy }}
  restartPolicy: {{ . }}
  {{- end }}

  {{- if or $volumes $values.extraVolumes }}
  volumes:
    {{- with $volumes }}
    {{- tpl (toYaml .) $ | nindent 4 }}
    {{- end }}
    {{- with $values.extraVolumes }}
    {{ tpl (toYaml .) $ | indent 4 }}
    {{- end }}
  {{- end }}

  {{- if gt (len $initContainers) 0 }}
  initContainers:
    {{- range $initContainers }}
    - {{- tpl (toYaml .) $ | nindent 6 }}
    {{- end }}
  {{- end }}

  containers:
    {{- range (required "A pod requires at least 1 container." $containers) }}
    - {{ tpl (toYaml .) $ | nindent 6 }}
    {{- end -}}

  {{- include "accelleran.common.pod.config" . | nindent 2 }}
{{- end -}}


{{- define "accelleran.common.pod.imagePullSecrets" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common pod image pull secret" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.imagePullSecrets -}}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.pod.serviceAccountName" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common pod service account name" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $serviceAccountName := include "accelleran.common.serviceAccount.name" . -}}
{{- with $serviceAccountName -}}
serviceAccountName: {{ . | quote }}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.pod.config" -}}
{{- include "accelleran.common.pod.securityContext" . -}}
{{- include "accelleran.common.pod.nodeSelector" . -}}
{{- include "accelleran.common.pod.affinity" . -}}
{{- include "accelleran.common.pod.tolerations" . -}}
{{- end -}}


{{- define "accelleran.common.pod.securityContext" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common pod security context" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.podSecurityContext -}}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.pod.nodeSelector" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common pod node selector" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if or $values.nodeSelector (eq (include "accelleran.common.drax.nodeSelector.enabled" .) "true") -}}
nodeSelector:
  {{- with $values.nodeSelector -}}
  {{- toYaml . | nindent 2 }}
  {{- end -}}
  {{- include "accelleran.common.drax.nodeSelector" . | nindent 2 }}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.pod.affinity" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common pod affinity" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.affinity -}}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.pod.tolerations" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common pod tolerations" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.tolerations -}}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- end -}}
