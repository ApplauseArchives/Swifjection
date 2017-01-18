DEVICE_NAME="iPhone 7"
DEVICE_ID="$(instruments -s devices | grep "${DEVICE_NAME} (" | grep -v -E "Watch" | tail -1 | cut -d "[" -f2 | cut -d "]" -f1)"
set -o pipefail && xcrun xcodebuild test -workspace Example/Swifjection.xcworkspace -scheme Swifjection -sdk iphonesimulator -destination id=$DEVICE_ID ONLY_ACTIVE_ARCH=NO | xcpretty
