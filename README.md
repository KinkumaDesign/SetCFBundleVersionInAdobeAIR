# Set CFBundleVersion of Adobe AIR app

## Apple don't approve same build number app when we submit to iTunesConnect

See this

ERROR ITMS-9000: “Redundant Binary Upload. There already exists a binary upload with build version '1.0' for train '1.0'” <http://stackoverflow.com/questions/25680604/error-itms-9000-redundant-binary-upload-there-already-exists-a-binary-upload>

We have to change the build number every time we upload it.

But we cannot change AIR app's build number directly by build settings in application-settings.xml.


## How to set AIR app's build number

I made shell script and you can use it.

### 1. Download set_build_no.sh in this repository

Configure settings following these steps

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
