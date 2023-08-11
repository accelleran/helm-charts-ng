{{- define "accelleran.common.selectorLabels" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common selector labels" -}}

app.kubernetes.io/name: {{ include "accelleran.common.name" . }}
app.kubernetes.io/instance: {{ include "accelleran.common.instance" . }}
{{- end -}}


{{- define "accelleran.common.labels" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common labels" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $labels := get . "labels" -}}

{{- if $labels -}}
{{- $labels | toYaml }}
{{- else -}}
helm.sh/chart: {{ include "accelleran.common.chart" . }}
{{ include "accelleran.common.selectorLabels" . }}
app.kubernetes.io/version: {{ include "accelleran.common.appVersion" . | quote }}
{{- with (include "accelleran.common.partOf" .) }}
app.kubernetes.io/part-of: {{ . | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ $.Release.Service }}
drax/helm-version: {{ include "accelleran.common.helmVersion" . | quote }}
{{- with (include "accelleran.common.drax.name" .) }}
drax/name: {{ . | quote }} # Deprecated
{{- end -}}
{{- with (include "accelleran.common.drax.role" .) }}
drax/role: {{ . | quote }}
{{- end }}
{{- with (include "accelleran.common.drax.technology" .) }}
drax/technology: {{ . | quote }}
{{- end }}
{{- with (include "accelleran.common.bootstrap.instanceId" .) }}
drax/instanceId: {{ . | quote }}
{{- end }}
drax/component-name: {{ include "accelleran.common.name" . | quote }} # Deprecated - use app.kubernetes.io/name instead
drax/component-version: {{ include "accelleran.common.helmVersion" . | quote }} # Deprecated - use drax/helm-version instead
{{- with $values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}
{{- end -}}
