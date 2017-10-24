//
//  AppSpec.swift
//  JSMixStarter
//


import Foundation
import Quick
import Nimble

class AppSpec: QuickSpec {
    override func spec() {
        describe("The Application") {
            it("has an initial passing example test") {
                expect(1).to(equal(1))
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
