function NBCheckVersion() {
}

NBCheckVersion.prototype.check = function (successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "NBCheckVersion", "check", []);
};

NBCheckVersion.prototype.toUpdate = function (successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "NBCheckVersion", "toUpdate", []);
};

NBCheckVersion.install = function () {
  if (!window.plugins) {
    window.plugins = {};
  }
  window.plugins.NBCheckVersion = new NBCheckVersion();
  return window.plugins.NBCheckVersion;
};

cordova.addConstructor(NBCheckVersion.install);