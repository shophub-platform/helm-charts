{{- define "shophub.name" -}}
{{- .Chart.Name }}
{{- end }}

{{- define "shophub.fullname" -}}
{{- printf "%s" (include "shophub.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "shophub.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "shophub.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "shophub.labels" -}}
app.kubernetes.io/name: {{ include "shophub.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "shophub.postgresql.dsn" -}}
{{- printf "postgres://%s:%s@%s-postgresql:5432/%s?sslmode=disable"
    .Values.postgresql.auth.username
    .Values.postgresql.auth.password
    .Release.Name
    .Values.postgresql.auth.database }}
{{- end }}
