//
//  JSBridge.swift
//  JSMixStarter
//

import Foundation
import JavaScriptCore

typealias ExampleCompletionBlock = @convention(block) (_ result:String) -> Void
typealias ApiCompletionBlock = @convention(block) (_ result:Dictionary<String, String>) -> Void

/**
 This class will have examples of bridging Swift and Javascript code, allowing
 Javascript libraries to be called on with native Swift code.
*/
class JSBridge  {

    var context:JSContext! = JSContext()

    /**
     Initialize the bridge by passing the name of the target javascript
     file in the bundle. Once loaded, it will be used to instatiate a JSContext
     and store a reference to it.

     # Exception Handling #
     If the javascript throws and exception, it is caught and logged out.

    - parameters:
        - jsFileName: The target javascript file included in the main bundle

   */
    init(_ jsFileName:String) {

        loadScript("main")
        loadScript("api")
        loadScript("index")

        guard let commonJSPath = Bundle.main.path(forResource: jsFileName, ofType: "js") else {
            print("Unable to read resource files.")
            return
        }

        do {
            let common = try String(contentsOfFile: commonJSPath, encoding: String.Encoding.utf8)
            context.evaluateScript(common)

        } catch (let error) {
            print("Error while processing script file: \(error)")
        }

        context.exceptionHandler = { (ctx: JSContext!, value: JSValue!) in
            let stacktrace = value.objectForKeyedSubscript("stack").toString()
            let lineNumber = value.objectForKeyedSubscript("line")
            let column = value.objectForKeyedSubscript("column")
            let moreInfo = "in method \(stacktrace)Line number in file: \(lineNumber), column: \(column)"
            print("JS ERROR: \(value) \(moreInfo)")
        }

        print("'testProp' in context is defined as: \(context?.objectForKeyedSubscript("testProp"))")
        print("'helloApp' in context is defined as: \(context?.objectForKeyedSubscript("helloApp"))")
        print("'$' in context is defined as: \(context?.objectForKeyedSubscript("$"))")
        print("'jQuery' in context is defined as: \(context?.objectForKeyedSubscript("jQuery"))")

    }

    func loadScript(_ name:String){
        guard let path = Bundle.main.path(forResource: name, ofType: "js") else {
            print("could not load script with name = \(name)")
            return
        }

        do {
            let contents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            context.evaluateScript(contents)

        } catch (let error) {
            print("Error while processing script file: \(error)")
        }
    }

    func callApi(_ callback:ApiCompletionBlock) {
        guard let jsCallback = JSValue(object: callback, in: context),
              let jsFunc = context.objectForKeyedSubscript("apiCall"),
              let _ = jsFunc.call(withArguments:[jsCallback])
        else {
            print("unable to call function")
            return
        }
    }

    /**
     Example of an asynchronous Swift function callback being invoked by javascript
     in the local `JSContext`.  `callback` is passed to the `JSContext` instance as
     a javascript object.  The target javascript function in JSContext is retrieved
     by `objectForKeyedSubscript()` and then executed with `.call(withArguments:)`.

    - Returns: Void
    - Note: `ExampleCompletionBlock` expects a String to be returned in the callback
    
    - parameters:
        - callback: The Swift function intended for callback in javascript
        - Returns: Void
    */
    func callbackExample(_ callback: ExampleCompletionBlock) {
        guard let jsCallback = JSValue(object: callback, in: context),
              let jsFunc = context.objectForKeyedSubscript("callbackExample"),
              let _ = jsFunc.call(withArguments:[jsCallback])
        else {
                print("unable to call function")
                return
        }
    }


    /**
     Invokes a synchronous javascript function in JSContext that returns
     a JSON object.  This JSON object is then converted into a Dictionary
     with S

    - parameters:
        - name: The name of the javascript function that returns a JSON object

    - Todo:
        1. refactor method to use Dictionary of type <String, Any>
   */
    func prop(name:String)->Dictionary<String, String> {
        let funcToParse = context.objectForKeyedSubscript(name)
        guard let parsed = funcToParse?.call(withArguments: []) else {
            print("Unable to parse returned object")
            return ["":""]
        }

        guard let dict = parsed.toDictionary() as? Dictionary<String, String> else { return ["":""] }
        return dict
    }

    /**
     Invokes a synchronous javascript function in the local JSContext. A simple
     example
    
    - parameters:
        - name: Name of that function the local JSContext.

    - Returns: A simple string
    
    */
    func synchronousFunc(name:String)->String {
        let funcToParse = context.objectForKeyedSubscript(name)
        guard let parsed = funcToParse?.call(withArguments: []) else {
            print("Unable to parse function")
            return ""
        }

        return parsed.toString()
    }



    func foo() -> String {
        return "bar"
    }

}
