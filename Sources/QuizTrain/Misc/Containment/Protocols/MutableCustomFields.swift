/*
 Provides read-write CustomField support.
 */


import Foundation



public protocol MutableCustomFields: CustomFields {
    var customFields: JSONDictionary { get set }
}
