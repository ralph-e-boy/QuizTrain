/*
 Provides a property to return a details string for use in debugging.
 */


import Foundation



public protocol DebugDetails {
    var debugDetails: String { get }
}
