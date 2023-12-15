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
  REDIS_HOSTNAME: {{ include "accelleran.common.bootstrap.redis.hostname" . | quote }}
  REDIS_PORT: {{ include "accelleran.common.bootstrap.redis.port" . | quote }}
  INSTANCE_FILTER: {{ include "accelleran.common.bootstrap.instanceId" . | quote }}
  NATS_HOSTNAME: {{ include "accelleran.common.bootstrap.nats.hostname" . | quote }}
  NATS_PORT: {{ include "accelleran.common.bootstrap.nats.port" . | quote }}
{{- end -}}


{{- define "accelleran.common.bootstrap.configMapName" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap config map name" -}}
{{ $.Values.global.bootstrap.configMapName | default (printf "%s-bootstrap" (include "accelleran.common.fullname" .))  }}
{{- end -}}


{{- define "accelleran.common.bootstrap.instanceId" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap instance id" -}}
{{- $values := get . "values" | default $.Values -}}
{{- $instanceId := tpl ((($values).drax).instanceId | default (($.Values.global).bootstrap).instanceId | default ($.Values.global).instanceId) $ -}}
{{- if not (and (regexMatch "^[a-z]([a-z0-9-]*[a-z0-9])?$" $instanceId) (le (len $instanceId) 16)) }}
{{- required "The Instance ID you have chosen is invalid! The Instance ID must consist of lower case alphanumeric characters or '-', start with an alphabetic character, and end with an alphanumeric character (e.g. 'my-name',  or 'abc-123', regex used for validation is '^[a-z]([a-z0-9-]*[a-z0-9])?$'). The Instance ID also cannot be longer than 16 alphanumeric characters!" nil }}
{{- else -}}
{{- $instanceId -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.redis.hostname" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap redis hostname" -}}
{{- ((($.Values.global).bootstrap).redis).hostname | default (($.Values.global).redis).hostname | default (printf "%s-redis-master" $.Release.Name) -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.redis.port" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap redis port" -}}
{{- ((($.Values.global).bootstrap).redis).port | default (($.Values.global).redis).port | default 6379 -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.nats.hostname" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap nats hostname" -}}
{{- ((($.Values.global).bootstrap).nats).hostname | default (($.Values.global).nats).hostname | default (printf "%s-nats" $.Release.Name) -}}
{{- end -}}


{{- define "accelleran.common.bootstrap.nats.port" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common bootstrap nats port" -}}
{{- ((($.Values.global).bootstrap).nats).port | default (($.Values.global).nats).port | default 4222 -}}
{{- end -}}
