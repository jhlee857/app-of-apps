{{/*
Create the name of the service to use
*/}}
{{- define "service-mesh-gateway.gatewayName" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
