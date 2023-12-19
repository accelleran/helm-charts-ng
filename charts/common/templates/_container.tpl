{{- define "accelleran.common.container" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $containerName := $values.containerName | default (include "accelleran.common.name" .) -}}

{{- $imageRepository := $values.image.repository | required "A valid container image repository is required" -}}
{{- $imageTag := include "accelleran.common.appVersion" . -}}

{{- $command := $values.command -}}
{{- $args := $values.args -}}

{{- $env := get . "env" | default list -}}
{{- with $values.extraEnvs -}}
{{- $env = append $env . -}}
{{- end -}}

{{- $envFrom := get . "envFrom" | default list -}}

{{- $volumeMounts := get . "volumeMounts" | default list -}}
{{- with $values.extraVolumeMounts -}}
{{- $volumeMounts = append $volumeMounts . -}}
{{- end -}}

name: {{ $containerName | quote }}
image: {{ printf "%s:%s" $imageRepository $imageTag | quote }}

{{- with $command }}
command:
  {{ toYaml . | nindent 2 }}
{{- end }}

{{- with $args }}
args:
  {{ toYaml . | nindent 2 }}
{{- end }}

{{- with $env }}
env:
  {{ toYaml . | nindent 2 }}
{{- end }}

{{- with $envFrom }}
envFrom:
  {{ toYaml . | nindent 2 }}
{{- end }}

{{- with $volumeMounts }}
volumeMounts:
  {{- tpl (toYaml .) $ | nindent 2 }}
{{- end }}

{{- include "accelleran.common.container.ports" . }}
{{- include "accelleran.common.container.probes" . }}
{{- include "accelleran.common.container.config" . }}
{{- end -}}


{{- define "accelleran.common.container.probes" -}}
{{- include "accelleran.common.container.startupProbe" . -}}
{{- include "accelleran.common.container.livenessProbe" . -}}
{{- include "accelleran.common.container.readinessProbe" . -}}
{{- end -}}


{{- define "accelleran.common.container.startupProbe" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container startup probe" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.startupProbe }}
startupProbe:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}


{{- define "accelleran.common.container.livenessProbe" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container liveness probe" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.livenessProbe }}
livenessProbe:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}


{{- define "accelleran.common.container.readinessProbe" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container readiness probe" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.readinessProbe }}
readinessProbe:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}


{{- define "accelleran.common.container.config" -}}
{{- include "accelleran.common.container.imagePullPolicy" . -}}
{{- include "accelleran.common.container.resources" . -}}
{{- include "accelleran.common.container.securityContext" . -}}
{{- end -}}


{{- define "accelleran.common.container.imagePullPolicy" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container iamge pull policy" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.image.pullPolicy }}
imagePullPolicy: {{ . }}
{{- end }}
{{- end -}}


{{- define "accelleran.common.container.resources" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container resources" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}


{{- define "accelleran.common.container.securityContext" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container security context" -}}
{{- $values := get . "values" | default $.Values -}}

{{- with $values.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}


{{- define "accelleran.common.container.ports" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common container ports" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if $values.service }}
ports:
  - {{ with ($values.service).portName }}
    name: {{ . }}
    {{- end }}
    {{- with ($values.service).protocol }}
    protocol: {{ . }}
    {{- end }}
    containerPort: {{ ($values.service).containerPort | default (int ($values.service).targetPort) | default ($values.service).port }}
{{- end }}
{{- end -}}
