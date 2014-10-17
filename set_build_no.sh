#!/bin/sh -x

#settings ==========
IPA="/path/to/App.ipa"
APP_FILE_NAME="AppName" #not required .app extension string
PROVISION="/path/to/some.mobileprovision"
CERT="iPhone Distribution: Ordinary Joe (ABC1DEF234)"
#===================





if [ $# != 1 ]; then
	echo "usage: ./set_build_no {build no}"
	exit 1
fi

IPA_FILE_NAME=${IPA##*/}
BUILD_NO=$1
IPA_FILE_NAME_WITHOUT_EXT=${IPA_FILE_NAME%.*}
WORK_DIR="${IPA_FILE_NAME_WITHOUT_EXT}_${BUILD_NO}"
FILE_ZIP="${IPA_FILE_NAME_WITHOUT_EXT}.zip"
TEMP_VER_STR="temp_version_here"



# unzip ipa file ====

mkdir ${WORK_DIR}

cp ${IPA} "${WORK_DIR}/${FILE_ZIP}"

cd ${WORK_DIR}

unzip ${FILE_ZIP}

rm ${FILE_ZIP}



# replace CFBundleVersion in Info.plist ====

cd "Payload/${APP_FILE_NAME}.app"

perl -0777 -i -p -e 's/(CFBundleVersion\<\/key\>)(.*?)(\<string\>)[\d]+\.[\d]+\.[\d]+/$1$2$3'${TEMP_VER_STR}'/s' Info.plist
perl -0777 -i -p -e 's/'${TEMP_VER_STR}'/'${BUILD_NO}'/s' Info.plist



cd ../../

# ========
# Signing certificate code is made by Richard Bronosky on Stackoverflow and github
# http://stackoverflow.com/questions/5160863/how-to-re-sign-the-ipa-file
# https://github.com/RichardBronosky/ota-tools

# remove the signature
rm -rf Payload/*.app/_CodeSignature Payload/*.app/CodeResources
# replace the provision
cp "$PROVISION" Payload/*.app/embedded.mobileprovision
# sign with the new certificate
/usr/bin/codesign -f -s "${CERT}" --resource-rules Payload/*.app/ResourceRules.plist Payload/*.app

# ========



zip -qr $IPA_FILE_NAME Payload

rm -r Payload

#return 
cd ../

exit 0
