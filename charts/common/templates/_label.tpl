{{- define "accelleran.common.selectorLabels" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common selector labels" -}}

app.kubernetes.io/name: {{ include "accelleran.common.name" . }}
app.kubernetes.io/instance: {{ include "accelleran.common.instance" . }}
{{- end -}}


{{- define "accelleran.common.labels" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common labels" -}}

helm.sh/chart: {{ include "accelleran.common.chart" . }}
{{ include "accelleran.common.selectorLabels" . }}
app.kubernetes.io/version: {{ include "accelleran.common.appVersion" . | quote }}
app.kubernetes.io/managed-by: {{ $.Release.Service }}
drax/helm-version: {{ include "accelleran.common.helmVersion" . | quote }}
{{- with (include "accelleran.common.drax.role" .) }}
drax/role: {{ . | quote }}
{{- end }}
{{- with (include "accelleran.common.drax.technology" .) }}
drax/technology: {{ . | quote }}
{{- end }}
{{- with (include "accelleran.common.bootstrap.instanceId" .) }}
drax/instanceId: {{ . | quote }}
{{- end }}
{{- end -}}
