{{- define "accelleran.common.bootstrap.configMap" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap config map" -}}

{{- include
      "accelleran.common.configMap"
      (fromYaml (include "accelleran.common.bootstrap.configMap.args" .))
-}}
{{- end -}}


{{- define "accelleran.common.bootstrap.configMap.args" -}}
{{- $ := get . "top" | required "The top context needs to be provided common bootstrap config map args" -}}
{{- $values := get . "values" | default $.Values -}}

top:
  {{ $ | toYaml | nindent 2 }}
values:
  {{ $values | toYaml | nindent 2 }}

name: {{ include "accelleran.common.bootstrap.configMapName" . | quote }}

data:
  {{- with (include "accelleran.common.bootstrap.instanceId" .) }}
  INSTANCE_FILTER: {{ . | quote }}
  {{- end }}
  {{- with (include "accelleran.common.bootstrap.redis.hostname" .) }}
  REDIS_HOSTNAME: {{ . | quote }}
  {{- end }}
  {{- with (include "accelleran.common.bootstrap.redis.port" .) }}
  REDIS_PORT: {{ . | quote }}
  {{- end }}
  {{- with ( include "accelleran.common.bootstrap.nats.hostname" .) }}
  NATS_HOSTNAME: {{ . | quote }}
  {{- end }}
  {{- with ( include "accelleran.common.bootstrap.nats.port" .) }}
  NATS_PORT: {{ . | quote }}
  {{- end }}
  {{- with ( include "accelleran.common.bootstrap.kafka.hostname" .) }}
  KAFKA_HOSTNAME: {{ . | quote }}
  {{- end }}
  {{- with ( include "accelleran.common.bootstrap.kafka.port" .) }}
  KAFKA_PORT: {{ . | quote }}
  {{- end }}
{{- end -}}


{{- define "accelleran.common.bootstrap.configMapName" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap config map name" -}}
{{ ($.Values.bootstrap).configMapName | default (printf "%s-bootstrap" (include "accelleran.common.fullname" .))  }}
{{- end -}}


{{- define "accelleran.common.bootstrap.instanceId" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap instance id" -}}
{{- $values := get . "values" | default $.Values -}}
{{- $instanceId := ($.Values.bootstrap).instanceId -}}
{{- if not $instanceId -}}
{{- /* ignore instance id if not set */ -}}
{{- else if not (and (regexMatch "^[a-z]([a-z0-9-]*[a-z0-9])?$" $instanceId) (le (len $instanceId) 16)) }}
{{- required "The Instance ID you have chosen is invalid! The Instance ID must consist of lower case alphanumeric characters or '-', start with an alphabetic character, and end with an alphanumeric character (e.g. 'my-name',  or 'abc-123', regex used for validation is '^[a-z]([a-z0-9-]*[a-z0-9])?$'). The Instance ID also cannot be longer than 16 alphanumeric characters!" nil }}
{{- else -}}
{{- $instanceId -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.redis.hostname" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap redis hostname" -}}
{{- if (($.Values.bootstrap).redis).enabled -}}
{{- (($.Values.bootstrap).redis).hostname | default (printf "%s-redis-master" $.Release.Name) -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.redis.port" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap redis port" -}}
{{- if (($.Values.bootstrap).redis).enabled -}}
{{- (($.Values.bootstrap).redis).port | default 6379 -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.nats.hostname" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap nats hostname" -}}
{{- if (($.Values.bootstrap).nats).enabled -}}
{{- (($.Values.bootstrap).nats).hostname | default (printf "%s-nats" $.Release.Name) -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.nats.port" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap nats port" -}}
{{- if (($.Values.bootstrap).nats).enabled -}}
{{- (($.Values.bootstrap).nats).port | default 4222 -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.kafka.hostname" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap kafka hostname" -}}
{{- if (($.Values.bootstrap).kafka).enabled -}}
{{- (($.Values.bootstrap).kafka).hostname | default (printf "%s-kafka" $.Release.Name) -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.kafka.port" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap kafka port" -}}
{{- if (($.Values.bootstrap).kafka).enabled -}}
{{- (($.Values.bootstrap).kafka).port | default 9092 -}}
{{- end -}}
{{- end -}}
