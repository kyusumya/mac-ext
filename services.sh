#!/bin/zsh

user_services=(
    "com.apple.inputanalyticsd"
    "com.apple.diagnosticextensionsd"
    "com.apple.diagnostics_agent"
    "com.apple.diagnosticspushd"
    "com.apple.analyticsagent"
    "com.apple.DiagnosticsReporter"
    "com.apple.ReportCrash"
    "com.apple.geoanalyticsd"

    "com.apple.siri.context.service"
    "com.apple.siriactionsd"
    "com.apple.siriknowledged"
    "com.apple.siriinferenced"
    "com.apple.sirittsd"
)

system_services=(
    "com.apple.diagnosticservicesd"
    "com.apple.diagnosticd"
    "com.apple.CrashReporterSupportHelper"
    "com.apple.diagnosticextensions.osx.spotlight.helper"
    "com.apple.wifianalyticsd"
    "com.apple.audioanalyticsd"
    "com.apple.InstallerDiagnostics.installerdiagd"
    "com.apple.SubmitDiagInfo"
    "com.apple.ecosystemanalyticsd"
    "com.apple.osanalytics.osanalyticshelper"
    "com.apple.diagnosticextensions.osx.timemachine.helper"
    "com.apple.InstallerDiagnostics.installerdiagwatcher"
    "com.apple.analyticsd"

    "com.apple.siri.acousticsignature"

    "com.apple.mDNSResponderHelper.reloaded"
    "com.apple.mDNSResponder.reloaded"
)

disable_service() {
  local scope=$1
  local svc=$2
  local svc_status

  sudo launchctl disable "$scope/$svc"

  svc_status=$(launchctl print-disabled "$scope" 2>/dev/null | grep "\"$svc\" => disabled")
  if [[ -n $svc_status ]]; then
    echo "[SUCCESS] $svc"
  else
    echo "[FAILED]  $svc"
  fi
}

for svc in $user_services; do
  disable_service "user/$(id -u)" $svc
done

for svc in $system_services; do
  disable_service "system" $svc
done

