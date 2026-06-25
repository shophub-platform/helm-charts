{{- define "bitcoin.fullname" -}}
{{- printf "%s-bitcoin" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "bitcoin.labels" -}}
app.kubernetes.io/name: bitcoin
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
