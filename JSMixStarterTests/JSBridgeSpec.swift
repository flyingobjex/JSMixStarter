//
//  JSBridgeSpec.swift
//  JSMixStarter
//


import Foundation
import Nimble
import Quick

@testable import JSMixStarter

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

            it("should load data from an api"){

            }

            it("javascript should execute a callback function created in Swift"){
                waitUntil(timeout: 4){ done in
                    let callback: ExampleCompletionBlock = { result in
                        print("result = \(result)")
                        done()
                    }
                    bridge.callbackExample(callback);
                }
            }


            it("should load a JSON object from bridge"){
                let res = bridge.prop(name: "jsData")
                expect(res).to(equal(["foo":"bar", "bar":"foo"]))
            }

            it("should call helloWorld via bridge"){
                expect(bridge.synchronousFunc(name:"helloWorld")).to(equal("Hello World from main!!"))
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