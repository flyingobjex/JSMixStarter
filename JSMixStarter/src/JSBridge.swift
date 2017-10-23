//
//  JSBridge.swift
//  JSMixStarter
//


import Foundation
import JavaScriptCore

class JSBridge  {

    var js:JSContext! = JSContext()

    init() {
        initializeJS()
    }


    func jsProp(name:String)->Dictionary<String, String> {
        let funcToParse = js.objectForKeyedSubscript(name)
        print("parseFunciton = \(funcToParse)")
        guard let parsed = funcToParse?.call(withArguments: [funcToParse]) else {
            print("Unable to parse function")
            return ["":""]
        }

//        JSValue
        guard let dict = parsed.toDictionary() as? Dictionary<String, String> else {
            return ["":""]
        }
        return dict
    }

    func jsFunc(name:String)->String {
        let funcToParse = js.objectForKeyedSubscript(name)
        print("parseFunciton = \(funcToParse)")
        guard let parsed = funcToParse?.call(withArguments: [funcToParse]) else {
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
            js.evaluateScript(common)
            print("script evaluated")

        } catch (let error) {
            print("Error while processing script file: \(error)")
        }
    }

    func foo() -> String {
        return "bar"
    }

}
