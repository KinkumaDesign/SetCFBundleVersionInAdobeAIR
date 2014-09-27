# Set CFBundleVersion of Adobe AIR app

## Apple don't approve same build number app when we submit to iTunesConnect

See this

ERROR ITMS-9000: “Redundant Binary Upload. There already exists a binary upload with build version '1.0' for train '1.0'” <http://stackoverflow.com/questions/25680604/error-itms-9000-redundant-binary-upload-there-already-exists-a-binary-upload>

We have to change the build number every time we upload it.

But we cannot change AIR app's build number directly by build settings in application-settings.xml.


## How to set AIR app's build number

I made shell script and you can use it.

### 1. Download two files in this repository

- Entitlements.plist
- set_build_no.sh

Configure settings following after these steps


### 2. Set up app ID in Entitlements.plist

Replace this to your app ID

ABC1DEF234.com.kumade.app.sample.airtest

### 3. Set up set_build_no.sh

Open Keychain.app

Search your Distribution Certificate file

e.g.

iPhone Distribution: Ordinary Joe (ABC1DEF234)

Copy and paste into CERT section in set_build_no.sh


### 4. Set up directory to execute shell script

```
WorkingDirectory
|- Entitlements.plist
|- set_build_no.sh
|- YourApp.ipa
```

Before you execute shell script you need to privilege it.

```
cd path/to/WorkingDirectory
chmod a+x ./set_build_no.sh
```


### 5. Execute shell script

```
./set_build_no.sh {your app .ipa file name} {build number}
```

e.g.

```
./set_build_no.sh YourApp.ipa 1.0.0.1
```

After this you will find new folder named like YourApp_1.0.0.1. There is a new ipa file with new build number.

### 6. Upload it using ApplicationLoader.app



## License
MIT License
