#!/bin/sh -x

#how to use it
#https://github.com/KinkumaDesign/SetCFBundleVersionInAdobeAIR

# You must set this ===
CERT="iPhone Distribution: Ordinary Joe (ABC1DEF234)"
#===================

if [ $# != 2 ]; then
	echo "usage: ./set_build_no.sh {ipa file Name} {build no}"
	exit 1
fi

FILE_NAME=$1
BUILD_NO=$2
FILE_NAME_WITHOUT_EXT=${FILE_NAME%.*}
WORK_DIR="${FILE_NAME_WITHOUT_EXT}_${BUILD_NO}"
FILE_ZIP="${FILE_NAME_WITHOUT_EXT}.zip"
TEMP_VER_STR="temp_version_here"



# unzip ipa file -----------

mkdir ${WORK_DIR}

cp ${FILE_NAME} "${WORK_DIR}/${FILE_ZIP}"

cd ${WORK_DIR}

unzip ${FILE_ZIP}

echo "======================= zip"
rm ${FILE_ZIP}



# replace CFBundleVersion in Info.plist -------
echo "======================= replace CFBundleVersion"

cd "Payload/${FILE_NAME_WITHOUT_EXT}.app"

perl -0777 -i -p -e 's/(CFBundleVersion\<\/key\>)(.*?)(\<string\>)[\d]+\.[\d]+\.[\d]+/$1$2$3'${TEMP_VER_STR}'/s' Info.plist
perl -0777 -i -p -e 's/'${TEMP_VER_STR}'/'${BUILD_NO}'/s' Info.plist


# return 
cd ../../../


#code signing
echo "======================= code signing"

/usr/bin/codesign -f -s "${CERT}" "--resource-rules=${WORK_DIR}/Payload/${FILE_NAME_WITHOUT_EXT}.app/ResourceRules.plist" --entitlements "Entitlements.plist" "${WORK_DIR}/Payload/${FILE_NAME_WITHOUT_EXT}.app"


#symbolic link
#see http://stackoverflow.com/questions/3516300/update-iphone-app-coderesources-file-must-be-a-symoblic-link

cd "${WORK_DIR}/Payload/${FILE_NAME_WITHOUT_EXT}.app"
echo "======================= symbolic link"

rm CodeResources
ln -s _CodeSignature/CodeResources CodeResources

cd ../../

#zip option -y is VERY IMPORTANT!!!

echo "======================= unzip"
zip -y -r $FILE_NAME Payload

rm -r Payload

#return 
cd ../

