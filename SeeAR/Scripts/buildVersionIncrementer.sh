#!/bin/sh

#  Script.sh
#  TDDPlaces
#
#  Created by SLim on 12/12/18.
#  Copyright © 2018 SLim. All rights reserved.
#!/bin/bash
#branch=${1:-'master'}
#buildNumber=$(expr $(git rev-list $branch --count) - $(git rev-list HEAD..$branch --count))
#echo "Updating build number to $buildNumber using branch '$branch'."
#/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
#if [ -f "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist" ]; then
#/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}.dSYM/Contents/Info.plist"
#fi

buildNumber=$(git rev-list --count HEAD)
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $buildNumber" "$PRODUCT_SETTINGS_PATH"
# Use Build run script phase in project rather than bot. Xcode Server pre-integration hook in Xcode 10 no longer has access to the same environment variables and build resources? Changes in build steps.
