./ci/setup_bundler.sh
pod install --project-directory=Example
set -o pipefail && xcrun xcodebuild test -workspace Example/Swifjection.xcworkspace -scheme Swifjection -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 7,OS=latest' ONLY_ACTIVE_ARCH=NO | xcpretty
