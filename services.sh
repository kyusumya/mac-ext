# for s in $(launchctl list | grep -i "diagnostic\|analytics\|submit\|crash" | awk '{print $3}'); do
#     echo "$s: $(launchctl print-disabled system | grep -q "\"$s\"" && launchctl print-disabled system | grep "$s" | awk '{print $3}' | tr -d ';' || echo not\ listed)"
# done

# com.apple.inputanalyticsd: not listed
# com.apple.diagnosticextensionsd: not listed
# com.apple.diagnostics_agent: not listed
# com.apple.diagnosticspushd: not listed
# com.apple.analyticsagent: not listed
# com.apple.DiagnosticsReporter: not listed
# com.apple.ReportCrash: not listed
# com.apple.geoanalyticsd: not listed



agents=(
    "com.apple.inputanalyticsd"

    "com.apple.geoanalyticsd"

    # "com.apple.siri.context.service"
    "com.apple.siriactionsd"
    "com.apple.siriknowledged"
    "com.apple.siriinferenced"
    "com.apple.sirittsd"
)

USER_ID=$(id -u)

for agent in "${agents[@]}"; do
    plist_path="/System/Library/LaunchAgents/$agent.plist"
    if [[ -f $plist_path ]]; then
        launchctl bootout gui/$USER_ID/$agent &>/dev/null && s1=SUCCESS || s1=FAILED
        launchctl disable gui/$USER_ID/$agent &>/dev/null && s2=SUCCESS || s2=FAILED
        echo "$agent: stop=$s1 disable=$s2"
    else
        echo "$agent: plist not found"
    fi
done
