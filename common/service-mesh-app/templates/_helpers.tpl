{{/*
Expand the name of the chart.
*/}}
{{- define "service-mesh-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the deployment environment of the chart.
*/}}
{{- define "service-mesh-app.env" -}}
{{- default "dev" .Values.env }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "service-mesh-app.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "service-mesh-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "service-mesh-app.labels" -}}
helm.sh/chart: {{ include "service-mesh-app.chart" . }}
{{ include "service-mesh-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "service-mesh-app.selectorLabels" -}}
app: {{ include "service-mesh-app.name" . }}
app.kubernetes.io/name: {{ include "service-mesh-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Values.datadogAgent.enabled }}
tags.datadoghq.com/env: {{ include "service-mesh-app.env" . }}
tags.datadoghq.com/service: {{ include "service-mesh-app.serviceName" . }}
tags.datadoghq.com/version: {{ .Chart.AppVersion | toString | quote }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "service-mesh-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "service-mesh-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "service-mesh-app.serviceName" -}}
{{- default (include "service-mesh-app.fullname" .) .Values.serviceNameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the preview service to use
*/}}
{{- define "service-mesh-app.previewServiceName" -}}
{{- if .Values.rollout.previewService }}
{{- .Values.rollout.previewService | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" (include "service-mesh-app.fullname" .) "preview" }}
{{- end }}
{{- end }}
