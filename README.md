# No longer need to use this script

Adobe AIR 18 was released. It can set Build Number. So you no longer need to use this script. Set CFBundleVersion into your application-settings.xml directly.

Adobe AIR 18 release note

https://helpx.adobe.com/flash-player/release-note/fp_18_air_18_release_notes.html


> Build Number in AIR iOS
This feature allows developers to simply update the build number while keeping the version number the same so that their application is available quickly on Apple’s Testflight for beta testing.

---
---


# Set CFBundleVersion of Adobe AIR app

## Apple don't approve same build number app when we submit to iTunesConnect

See this

ERROR ITMS-9000: “Redundant Binary Upload. There already exists a binary upload with build version '1.0' for train '1.0'” <http://stackoverflow.com/questions/25680604/error-itms-9000-redundant-binary-upload-there-already-exists-a-binary-upload>

We have to change the build number every time we upload it.

But we cannot change AIR app's build number directly by build settings in application-settings.xml.


## How to set AIR app's build number

I made shell script and you can use it.

### 1. Set up Entitlements.plist

Open provisioning profile with text editor, it contains entitlements section. It helps settings to Entitlements.plist file.

### 2. Set up set_build_no.sh

**IPA**  
path to .ipa file


**APP_FILE_NAME**  
.app file name (without extension)

**PROVISION**  
path to .mobileprovision = provisioning file

**CERT**  
Open Keychain.app and search your Distribution Certificate file

e.g. iPhone Distribution: Ordinary Joe (ABC1DEF234)

**ENTITLEMENTS**  
path to Entitlement.plist


### 3. Set up to execute shell script

Before you execute shell script you need to privilege it. (only first time)

```
cd path/to/directory
chmod a+x ./set_build_no.sh
```


### 4. Execute shell script

```
./set_build_no.sh {build number}
```

e.g.

```
./set_build_no.sh 1.0.0.1
```

After this you will find new folder named like YourApp_1.0.0.1. There is a new ipa file with new build number.

### 5. Upload new build number app using ApplicationLoader.app



## License
MIT License
