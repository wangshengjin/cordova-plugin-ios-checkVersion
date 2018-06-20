# cordova-plugin-ios-checkVersion
ios 自检测是否需要更新，并跳转到app store
## Supported Platforms
- iOS

## Installation

The plugin can be installed with the Cordova CLI:

```shell
cordova plugin add https://github.com/wangshengjin/cordova-plugin-ios-checkVersion.git
```

## Usage

```javascript
window.plugins.NBCheckVersion.check((boo)=>{
  if(boo){
    window.plugins.NBCheckVersion.toUpdate();
  }
});
```
