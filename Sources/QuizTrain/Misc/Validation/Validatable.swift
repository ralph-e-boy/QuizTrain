/*
 Provides a way to determine if something is in a valid state. It is up to the
 conformer to determine what is valid or not.
 */


import Foundation


protocol Validatable {
    var isValid: Bool { get }
}
