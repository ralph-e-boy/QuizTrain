/*
 Provides read-only CustomField support.
 */


import Foundation



public protocol CustomFields {
    var customFields: JSONDictionary { get }
}
