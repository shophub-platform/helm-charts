{{- define "shop.name" -}}
{{- .Values.name | default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "shop.labels" -}}
app.kubernetes.io/name: shop
app.kubernetes.io/instance: {{ include "shop.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
