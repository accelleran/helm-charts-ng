{{- define "accelleran.common.rbac" -}}
{{ include "accelleran.common.role" . }}
---
{{ include "accelleran.common.roleBinding" . }}
{{- end -}}


{{- define "accelleran.common.role" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common role" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if ($values.rbac).enabled -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
{{ include "accelleran.common.metadata" . }}
rules:
  {{- tpl (toYaml $values.rbac.rules) $ | nindent 2 -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.roleBinding" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common role binding" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $serviceAccountName := get . "serviceAccountName" | default (include "accelleran.common.serviceAccount.name" .) -}}

{{- if ($values.rbac).enabled -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
{{ include "accelleran.common.metadata" . }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: {{ include "accelleran.common.fullname" . | quote }}
subjects:
- kind: ServiceAccount
  name: {{ $serviceAccountName | quote }}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.clusterRbac" -}}
{{ include "accelleran.common.clusterRole" . }}
---
{{ include "accelleran.common.clusterRoleBinding" . }}
{{- end -}}


{{- define "accelleran.common.clusterRole" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common role" -}}
{{- $values := get . "values" | default $.Values -}}

{{- if ($values.rbac).enabled -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
{{ include "accelleran.common.metadata" . }}
rules:
  {{- tpl (toYaml $values.rbac.rules) $ | nindent 2 -}}
{{- end -}}
{{- end -}}


{{- define "accelleran.common.clusterRoleBinding" -}}
{{- $ := get . "top" | required "The top context needs to be provided to common role binding" -}}
{{- $values := get . "values" | default $.Values -}}

{{- $serviceAccountName := get . "serviceAccountName" | default (include "accelleran.common.serviceAccount.name" .) -}}

{{- if ($values.rbac).enabled -}}
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
{{ include "accelleran.common.metadata" . }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ include "accelleran.common.fullname" . | quote }}
subjects:
- kind: ServiceAccount
  name: {{ $serviceAccountName | quote }}
  namespace: {{ $.Release.Namespace }}
{{- end -}}
{{- end -}}
