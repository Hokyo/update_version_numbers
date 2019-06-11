#!/bin/bash
 
# Branch definition (requires Git flow)
developerBranch="develop"
masterBranch="master"

# Most recent tag from master branch
recentTag=$(git describe --tags $(git rev-list ${masterBranch} --tags --max-count=1))
recentTagArr=( ${recentTag//./ } )

# Major/Minor from tag name
tagMajorNumber="${recentTagArr[0]}"
tagMinorNumber="${recentTagArr[1]}"
tagPatchNumber="${recentTagArr[2]}"

# Build version string
[[ -z "$tagPatchNumber" ]] && VersionString="${tagMajorNumber}.${tagMinorNumber}" || VersionString="${tagMajorNumber}.${tagMinorNumber}.${tagPatchNumber}"

# Current build number
buildNumber=$(expr $(git rev-list $developerBranch --count) - $(git rev-list HEAD..$developerBranch --count))
#buildNumber=$(git log -n 1 --pretty=format:"%h")
#buildNumber=$(git describe --tags --always --dirty)

# Update Info.plist
echo "Updating marketing version number '${VersionString}' to ${PROJECT_DIR}/${INFOPLIST_FILE}."
xcrun agvtool new-marketing-version "${VersionString}"
echo "Updating build number '${buildNumber}' to ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}."
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
if [ -f "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist" ]; then
  echo "Will execute: Set :CFBundleVersion $buildNumber" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist"
  echo "Updating build number '${buildNumber}' to ${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist"
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist"
fi

# Update podspec
set +e
podspec-bump --write "${VersionString}" > /dev/null 2>&1 || echo "Podspec update skipped - file not found."
set -e