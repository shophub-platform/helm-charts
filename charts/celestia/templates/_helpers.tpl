{{- define "celestia.fullname" -}}
{{- printf "%s-celestia" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "celestia.labels" -}}
app.kubernetes.io/name: celestia
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
