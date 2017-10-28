"use strict"
const secretModule = require("@socialtables/secret-module")
// for older devices with Safari < 9.0
require("babel-polyfill")
global.getSearchResults = secretModule.getSearchResults
global.nameToColor = secretModule.nameToColor


function apiCall(callback){
    callback({"foo": "bar", "bar":"foo"})
}