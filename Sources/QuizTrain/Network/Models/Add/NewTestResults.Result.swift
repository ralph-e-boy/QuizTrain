extension NewTestResults {

    public struct Result: MutableCustomFields, Equatable {

        // MARK: Properties

        public var assignedtoId: User.Id?
        public var comment: String?
        public var defects: String?
        public var elapsed: String?
        public var statusId: Status.Id?
        public var testId: Test.Id
        public var version: String?
        var customFieldsContainer = CustomFieldsContainer.empty()
        public var customFields: JSONDictionary {
            get { return self.customFieldsContainer.customFields }
            set { customFieldsContainer.customFields = newValue }
        }

        // MARK: Init

        public init(assignedtoId: User.Id? = nil, comment: String? = nil, defects: String? = nil, elapsed: String? = nil, statusId: Status.Id? = nil, testId: Test.Id, version: String? = nil, customFields: JSONDictionary? = nil) {
            self.assignedtoId = assignedtoId
            self.comment = comment
            self.defects = defects
            self.elapsed = elapsed
            self.statusId = statusId
            self.testId = testId
            self.version = version
            if let customFields = customFields {
                customFieldsContainer.customFields = customFields
            }
        }

    }

}

// MARK: - Validatable

extension NewTestResults.Result: Validatable {

    /*
     A result is valid if it's assigned and/or commented on and/or is given a
     status.
     */
    var isValid: Bool {
        return (assignedtoId != nil || comment != nil || statusId != nil)
    }

}

// MARK: - JSON Keys

extension NewTestResults.Result {

    enum JSONKeys: JSONKey {
        case assignedtoId = "assignedto_id"
        case comment
        case defects
        case elapsed
        case statusId = "status_id"
        case testId = "test_id"
        case version
    }

}

extension NewTestResults.Result: AddRequestJSONKeys {

    var addRequestJSONKeys: [JSONKey] {
        var keys = [JSONKeys.assignedtoId.rawValue,
                    JSONKeys.comment.rawValue,
                    JSONKeys.defects.rawValue,
                    JSONKeys.elapsed.rawValue,
                    JSONKeys.statusId.rawValue,
                    JSONKeys.testId.rawValue,
                    JSONKeys.version.rawValue]
        customFields.forEach { item in keys.append(item.key) }
        return keys
    }

}

// MARK: - Serialization

extension NewTestResults.Result: JSONSerializable {

    private var serializedProperties: JSONDictionary {
        return [JSONKeys.assignedtoId.rawValue: assignedtoId as Any,
                JSONKeys.comment.rawValue: comment as Any,
                JSONKeys.defects.rawValue: defects as Any,
                JSONKeys.elapsed.rawValue: elapsed as Any,
                JSONKeys.statusId.rawValue: statusId as Any,
                JSONKeys.testId.rawValue: testId,
                JSONKeys.version.rawValue: version as Any]
    }

    func serialized() -> JSONDictionary {
        var json = serializedProperties
        customFields.forEach { item in json[item.key] = item.value }
        return json
    }

}

extension NewTestResults.Result: AddRequestJSON { }
