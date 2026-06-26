{{- define "shop-operator.name" -}}
{{- .Chart.Name }}
{{- end }}

{{- define "shop-operator.fullname" -}}
{{- printf "%s" (include "shop-operator.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "shop-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "shop-operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "shop-operator.labels" -}}
app.kubernetes.io/name: {{ include "shop-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
