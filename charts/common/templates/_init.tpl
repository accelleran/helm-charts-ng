{{/*
Init container check waiting until redis is available
*/}}
{{- define "accelleran.common.init.redis" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common init redis" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $bootstrapConfigMapName :=  get . "bootstrapConfigMapName" | default (include "accelleran.common.bootstrap.configMapName" .) -}}

name: check-redis
image: "{{ $values.initImage.repository }}:{{ tpl $values.initImage.tag $ }}"
imagePullPolicy: "{{ $values.initImage.pullPolicy }}"
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
{{- $values := get . "values" | default $.Values -}}

{{- $bootstrapConfigMapName := get . "bootstrapConfigMapName" | default (include "accelleran.common.bootstrap.configMapName" .)  -}}

name: check-nats
image: "{{ $values.initImage.repository }}:{{ $values.initImage.tag }}"
imagePullPolicy: "{{ $values.initImage.pullPolicy }}"
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
