//
//  JSBridge.swift
//  JSMixStarter
//


import Foundation
import JavaScriptCore

class JSBridge  {

    var jsContext:JSContext! = JSContext()

    init() {
        initializeJS()
    }

    func jsApiCall(_ apiCallback:((_ result:String) -> Void)){
        guard let convertedCallbackToJS = JSValue(object: apiCallback, in: jsContext) else { return }
        print("convertedCallbackToJS = \(convertedCallbackToJS)")

        guard let funcToParse = jsContext.objectForKeyedSubscript("apiCall") else { return }
        print("funcToParse = \(funcToParse)")

        funcToParse.invokeMethod("apiCall", withArguments: [funcToParse])

        guard let res = funcToParse.call(withArguments:[convertedCallbackToJS]) else {
            print("unable to call function")
            return
        }
        print("res = \(res)")
        print("res = \(funcToParse.call(withArguments:[convertedCallbackToJS]))")
    }

    func jsProp(name:String)->Dictionary<String, String> {
        let funcToParse = jsContext.objectForKeyedSubscript(name)
        guard let parsed = funcToParse?.call(withArguments: []) else {
            print("Unable to parse returned object")
            return ["":""]
        }

//        JSValue
        guard let dict = parsed.toDictionary() as? Dictionary<String, String> else {
            return ["":""]
        }
        return dict
    }

    func jsFunc(name:String)->String {
        let funcToParse = jsContext.objectForKeyedSubscript(name)
        guard let parsed = funcToParse?.call(withArguments: []) else {
            print("Unable to parse function")
            return ""
        }

        return parsed.toString()
    }

    func initializeJS() {
        guard let commonJSPath = Bundle.main.path(forResource: "main", ofType: "js") else {
            print("Unable to read resource files.")
            return
        }

        do {
            let common = try String(contentsOfFile: commonJSPath, encoding: String.Encoding.utf8)
            jsContext.evaluateScript(common)
            print("script evaluated")

        } catch (let error) {
            print("Error while processing script file: \(error)")
        }
    }

    func foo() -> String {
        return "bar"
    }

}
