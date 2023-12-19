{{- define "accelleran.common.service" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if $values.service.enabled -}}

{{- $name := include "accelleran.common.service.name" . -}}
{{- $annotations := include "accelleran.common.service.annotations" . | fromYaml -}}
{{- $type := $values.service.type | default "ClusterIP" -}}

apiVersion: v1
kind: Service
{{ include "accelleran.common.metadata" (mergeOverwrite (deepCopy .) (dict "name" $name "annotations" $annotations)) }}
spec:
  selector:
    {{- include "accelleran.common.selectorLabels" . | nindent 4 }}
  type: {{ $type }}
  {{- with $values.service.externalTrafficPolicy }}
  externalTrafficPolicy: {{ . }}
  {{- end }}
  {{- include "accelleran.common.service.ports" . | nindent 2 }}
  {{- if eq $type "LoadBalancer" -}}
  {{- with $values.service.loadBalancerIP }}
  loadBalancerIP: {{ . }}
  {{- end }}
  {{- end -}}
{{- end -}}

{{- end -}}


{{- define "accelleran.common.service.name" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service name" -}}
{{- $values := get . "values" | default $.Values -}}

{{- get . "name" | default (get $values.service "name") | default (include "accelleran.common.fullname" .) -}}
{{- end -}}


{{- define "accelleran.common.service.annotations" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service annotations" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with (get $values.service "annotations") -}}
{{- . | toYaml -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.service.ports" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service ports" -}}
{{- $values := get . "values" | default $.Values -}}
{{- $type := ($values.service).type | default "ClusterIP" -}}

ports:
  - {{- with ($values.service).portName }}
    name: {{ . }}
    {{- end }}
    {{- with ($values.service).appProtocol }}
    appProtocol: {{ . }}
    {{- end }}
    {{- with ($values.service).protocol }}
    protocol: {{ . }}
    {{- end }}
    port: {{ ($values.service).port }}
    {{- with ($values.service).targetPort }}
    targetPort: {{ . }}
    {{- end }}
    {{- if eq $type "NodePort" -}}
    {{- with ($values.service).nodePort }}
    nodePort: {{ . }}
    {{- end }}
    {{- end -}}
{{- end -}}
