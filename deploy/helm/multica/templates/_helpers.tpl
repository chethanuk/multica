{{/* Expand the chart name. */}}
{{- define "multica.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Create a full release name. */}}
{{- define "multica.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/* Chart label. */}}
{{- define "multica.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Common labels. */}}
{{- define "multica.labels" -}}
helm.sh/chart: {{ include "multica.chart" . }}
{{ include "multica.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.global.commonLabels }}
{{- $commonLabels := omit . "helm.sh/chart" "app.kubernetes.io/name" "app.kubernetes.io/instance" "app.kubernetes.io/version" "app.kubernetes.io/managed-by" }}
{{ toYaml $commonLabels }}
{{- end }}
{{- end }}

{{/* Selector labels. */}}
{{- define "multica.selectorLabels" -}}
app.kubernetes.io/name: {{ include "multica.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Service account name. */}}
{{- define "multica.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "multica.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* Frontend service name. */}}
{{- define "multica.frontendServiceName" -}}
{{- printf "%s-frontend" (include "multica.fullname" . | trunc 54 | trimSuffix "-") | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Backend service name. */}}
{{- define "multica.backendServiceName" -}}
{{- printf "%s-backend" (include "multica.fullname" . | trunc 55 | trimSuffix "-") | trunc 63 | trimSuffix "-" }}
{{- end }}
