//
//  JSBridgeSpec.swift
//  JSMixStarter
//


import Foundation
import Nimble
import Quick

@testable import JSMixStarter

/**
 Tests are ordered with the first test at the bottom and the latest test
 at the top.
*/
class JSBridgeSpec: QuickSpec {
    override func spec() {
        describe("The Javascript Bridge") {

            var bridge:JSBridge! = JSBridge("main");
        
            beforeEach {
                bridge = JSBridge("main")
            }

            afterEach {
                bridge = nil
            }

            xit("should load data from an api"){
                waitUntil(timeout: 4){ done in
                    let callback: ApiCompletionBlock = { result in
                        print("result = \(result)")
                        done()
                    }
                    bridge.callApi(callback);
                }
            }

            it("javascript should execute a callback function created in Swift"){
                waitUntil(timeout: 4){ done in
                    let callback: ExampleCompletionBlock = { result in
                        print("result = \(result)")
                        expect(result).toNot(beNil())
                        done()
                    }
                    bridge.callbackExample(callback);
                }
            }


            it("should load props- a JSON object from bridge"){
                waitUntil(timeout:4){ done in
                    let res = bridge.prop(name: "jsData")
                    expect(res).to(equal(["foo":"bar", "bar":"foo"]))
                    done()
                }
            }

            it("should call helloWorld via bridge"){
                expect(bridge.synchronousFunc(name:"helloWorld")).to(equal("Hello Wold from main.js !*!*!"))
            }

            it("should call a javascript method on JSBridge"){
                expect(bridge.foo()).to(equal("bar"));
            }

            it("the project should have a test method that passes") {
                let foo = "bar";
                expect(foo).to(equal("bar"))
            }

            context("has an embedded context in the spec") {
                it("has another passing example test") {
                    let you = "Me"
                    expect{you}.toEventually(equal("Me"))
                }
            }
        }
    }
}
