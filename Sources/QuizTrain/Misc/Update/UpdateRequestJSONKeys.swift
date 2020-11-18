/*
 Provides JSONKey's for all properties which can be submitted in an update
 request to the API.
 */


import Foundation



protocol UpdateRequestJSONKeys {
    var updateRequestJSONKeys: [JSONKey] { get }
}
