"use strict";

import { $ } from 'jquery';
// for older devices with Safari < 9.0
require("babel-polyfill");

global.jquery = $;

const helloApp = function helloApp(){
    $.each(["one", "two", "three"], function(key, value){
        console.log("key = " + key);
        console.log("value 454545 = " + value);

    });
    return "Hello App";
};

const testProp = {"hello":"world"};

global.helloApp = helloApp;
global.testProp = testProp;