
# ymchat-react-native

## Getting started

`$ npm install ymchat-react-native --save`

### Mostly automatic installation

`$ react-native link ymchat-react-native`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `ymchat-react-native` and add `YMChat.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libYMChat.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.YMChatPackage;` to the imports at the top of the file
  - Add `new YMChatPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':ymchat-react-native'
  	project(':ymchat-react-native').projectDir = new File(rootProject.projectDir, 	'../node_modules/ymchat-react-native/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':ymchat-react-native')
  	```


## Usage
```javascript
import YMChat from 'ymchat-react-native';

// TODO: What to do with the module?
YMChat;
```
  