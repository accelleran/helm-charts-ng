{{- define "accelleran.common.service" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common service" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $name := get $values.service "name" | default (include "accelleran.common.fullname" .) -}}
{{- $type := $values.service.type | default "ClusterIP" -}}

{{- if $values.service.enabled -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $name | quote }}
  labels:
    {{- include "accelleran.common.labels" . | nindent 4 }}
spec:
  selector:
    {{- include "accelleran.common.selectorLabels" . | nindent 4 }}
  type: {{ $type }}
  ports:
    - {{- with $values.service.portName }}
      name: {{ . }}
      {{- end }}
      {{- with $values.service.protocol }}
      protocol: {{ . }}
      {{- end }}
      port: {{ $values.service.port }}
      {{- with $values.service.targetPort }}
      targetPort: {{ . }}
      {{- end }}
      {{- if eq $type "NodePort" -}}
      {{- with $values.service.nodePort }}
      nodePort: {{ . }}
      {{- end }}
      {{- end -}}
{{- end -}}

{{- end -}}
