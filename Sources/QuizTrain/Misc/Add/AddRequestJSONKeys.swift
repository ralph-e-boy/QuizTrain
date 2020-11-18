/*
 Provides JSONKey's for all properties which can be submitted in an add request
 to the API.
 */

import Foundation

protocol AddRequestJSONKeys {
    var addRequestJSONKeys: [JSONKey] { get }
}
