{{- define "accelleran.common.init.container" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common init container" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $name := get . "name"  | required "Name needs to be provided to common init container" -}}
{{- $command := get . "command"  | required "Command needs to be provided to common init container" -}}

{{ include "accelleran.common.container"
    (mergeOverwrite
      (deepCopy .)
      (dict
        "values" (mergeOverwrite
          (deepCopy $values)
          (include "accelleran.common.init.container.args" . | fromYaml)
        )
      )
    )
}}
{{- end -}}


{{- define "accelleran.common.init.container.args" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common init container" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $name := get . "name" | required "Name needs to be provided to common init container args" -}}
{{- $initImage := $values.initImage | required "Init image needs to be provided as part of the values to common init container args" -}}
{{- $command := get . "command" -}}

containerName: {{ $name | quote }}
image:
  {{- $initImage | toYaml | nindent 2 }}

{{- with $command }}
command:
  {{- $command | toYaml | nindent 2 }}
{{- end }}
{{- end -}}


{{/*
Init container check waiting until redis is available
*/}}
{{- define "accelleran.common.init.redis" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common init redis" -}}

{{ include "accelleran.common.init.container"
    (include "accelleran.common.init.redis.args" . | fromYaml)
}}
{{- end -}}


{{- define "accelleran.common.init.redis.args" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common init redis args" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $bootstrapConfigMapName :=  get . "bootstrapConfigMapName" | default (include "accelleran.common.bootstrap.configMapName" .) -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

name: check-redis
command:
- "/bin/bash"
- "-c"
- |
    until [ "$(redis-cli -h ${REDIS_HOSTNAME} -p ${REDIS_PORT} ping)" == "PONG" ]
    do
      sleep 1
    done
    echo "$(date) Redis ready"
env:
- name: REDIS_HOSTNAME
  valueFrom:
    configMapKeyRef:
      name: {{ $bootstrapConfigMapName | quote }}
      key: REDIS_HOSTNAME
- name: REDIS_PORT
  valueFrom:
    configMapKeyRef:
      name: {{ $bootstrapConfigMapName | quote }}
      key: REDIS_PORT
{{- end -}} 


{{/*
Init container check waiting until NATS is available
*/}}
{{- define "accelleran.common.init.nats" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common init nats" -}}

{{ include "accelleran.common.init.container"
    (include "accelleran.common.init.nats.args" . | fromYaml)
}}
{{- end -}}

{{- define "accelleran.common.init.nats.args" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common init nats args" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $bootstrapConfigMapName := get . "bootstrapConfigMapName" | default (include "accelleran.common.bootstrap.configMapName" .)  -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

name: check-nats
command:
  - "/bin/bash"
  - "-c"
  - |
    until nc -z -v -w1 ${NATS_HOSTNAME} ${NATS_PORT}
    do
      sleep 1
    done
    echo "$(date) NATS ready"
env:
  - name: NATS_HOSTNAME
    valueFrom:
      configMapKeyRef:
        name: {{ $bootstrapConfigMapName | quote }}
        key: NATS_HOSTNAME
  - name: NATS_PORT
    valueFrom:
      configMapKeyRef:
        name: {{ $bootstrapConfigMapName | quote }}
        key: NATS_PORT
{{- end -}} 
