import XCTest
@testable import QuizTrain

class NewMultiselectCaseFieldTests: XCTestCase, AddModelTests, CodableTests {

    typealias Object = NewCaseField<NewCaseFieldMultiselectData>

    func testAddRequestJSON() {
        _testAddRequestJSON()
    }

    func testEquatable() {
        _testEquatable()
    }

    func testInit() {
        _testInit()
    }

    func testInitWithOptionalProperties() {
        _testInitWithOptionalProperties()
    }

    func testJSONSerializingSingleObjects() {
        _testJSONSerializingSingleObjects()
    }

    func testJSONSerializingMultipleObjects() {
        _testJSONSerializingMultipleObjects()
    }

    func testVariableProperties() {
        _testVariableProperties()
    }

    func testCodable() {
        _testCodable()
    }

    func testThrows() {

        XCTAssertThrowsError(try Object(description: nil, label: "", name: "", includeAll: true, templateIds: [], isGlobal: true, projectIds: [], isRequired: true, items: []))
        XCTAssertNoThrow(try Object(description: nil, label: "", name: "", includeAll: true, templateIds: [], isGlobal: true, projectIds: [], isRequired: true, items: ["A"]))

        continueAfterFailure = false
        let object = objectWithRequiredProperties
        guard var config = object.configs.first else {
            XCTFail("Config cannot be nil.")
            return
        }
        continueAfterFailure = true

        XCTAssertThrowsError(try config.options.set(items: []))
        XCTAssertNoThrow(try config.options.set(items: ["A"]))
    }

}

// MARK: - Data

extension NewMultiselectCaseFieldTests {

    struct Properties {

        struct Required {
            static let label = "Label"
            static let name = "quiztrain_name"
            static let includeAll = true
            static let templateIds = [Int]()
            static let isGlobal = true
            static let projectIds = [Int]()
            static let isRequired = false
            static let items = ["A", "B", "C"]
        }

        struct Optional {
            static let description = "Description"
        }

    }

}

// MARK: - Objects

extension NewMultiselectCaseFieldTests: ObjectProvider {

    static var objectWithRequiredProperties: Object {
        // swiftlint:disable:next force_try
        return try! Object(description: nil,
                           label: Properties.Required.label,
                           name: Properties.Required.name,
                           includeAll: Properties.Required.includeAll,
                           templateIds: Properties.Required.templateIds,
                           isGlobal: Properties.Required.isGlobal,
                           projectIds: Properties.Required.projectIds,
                           isRequired: Properties.Required.isRequired,
                           items: Properties.Required.items)
    }

    static var objectWithRequiredAndOptionalProperties: Object {
        // swiftlint:disable:next force_try
        return try! Object(description: Properties.Optional.description,
                           label: Properties.Required.label,
                           name: Properties.Required.name,
                           includeAll: Properties.Required.includeAll,
                           templateIds: Properties.Required.templateIds,
                           isGlobal: Properties.Required.isGlobal,
                           projectIds: Properties.Required.projectIds,
                           isRequired: Properties.Required.isRequired,
                           items: Properties.Required.items)
    }

}

// MARK: - Assertions

extension NewMultiselectCaseFieldTests: AssertAddRequestJSON { }

extension NewMultiselectCaseFieldTests: AssertCodable { }

extension NewMultiselectCaseFieldTests: AssertEquatable { }

extension NewMultiselectCaseFieldTests: AssertJSONSerializing { }

extension NewMultiselectCaseFieldTests: AssertProperties {

    func assertRequiredProperties(in object: Object) {

        // NewCaseField
        XCTAssertEqual(object.label, Properties.Required.label)
        XCTAssertEqual(object.name, Properties.Required.name)
        XCTAssertEqual(object.includeAll, Properties.Required.includeAll)
        XCTAssertEqual(object.templateIds, Properties.Required.templateIds)

        // NewCaseField.Configs
        XCTAssertEqual(object.type, NewCaseFieldType.multiselect)

        // NewCaseField.Configs[0]
        continueAfterFailure = false
        XCTAssertNotNil(object.configs.first)
        continueAfterFailure = true
        let config = object.configs[0]

        // NewCaseField.Configs[0].Context
        XCTAssertEqual(config.context.isGlobal, Properties.Required.isGlobal)
        XCTAssertEqual(config.context.projectIds, Properties.Required.projectIds)

        // NewCaseField.Configs[0].Options
        XCTAssertEqual(config.options.isRequired, Properties.Required.isRequired)
        XCTAssertEqual(config.options.items, Properties.Required.items)
    }

    func assertOptionalProperties(in object: Object, areNil: Bool) {
        if areNil {
            XCTAssertNil(object.description)
        } else {
            XCTAssertEqual(object.description, Properties.Optional.description)
        }
    }

    func assertVariablePropertiesCanBeChanged(in object: inout Object) {

        // Properties

        // NewCaseField
        object.description = "New Description"
        object.label = "New Label"
        object.name = "new_name"
        object.includeAll = false
        object.templateIds = [1, 2, 3]

        // NewCaseField.Configs
        continueAfterFailure = false
        XCTAssertNotNil(object.configs.first)
        continueAfterFailure = true
        var config = object.configs[0]

        // NewCaseField.Configs[0].Context
        config.context.isGlobal = false
        config.context.projectIds = [1, 2, 3]

        // NewCaseField.Configs[0].Options
        config.options.isRequired = true
        continueAfterFailure = false
        do {
            try config.options.set(items: ["One", "Two", "Three"])
        } catch {
            XCTFail(String(describing: error))
        }
        continueAfterFailure = true

        // Update Context/Options through .data.
        object.data = NewCaseFieldMultiselectData(configs: [config])

        // Assertions

        XCTAssertNotEqual(object.description, Properties.Optional.description)
        XCTAssertNotEqual(object.label, Properties.Required.label)
        XCTAssertNotEqual(object.name, Properties.Required.name)
        XCTAssertNotEqual(object.includeAll, Properties.Required.includeAll)
        XCTAssertNotEqual(object.templateIds, Properties.Required.templateIds)
        XCTAssertNotEqual(object.configs[0].context.isGlobal, Properties.Required.isGlobal)
        XCTAssertNotEqual(object.configs[0].context.projectIds, Properties.Required.projectIds)
        XCTAssertNotEqual(object.configs[0].options.isRequired, Properties.Required.isRequired)
        XCTAssertNotEqual(object.configs[0].options.items, Properties.Required.items)

        XCTAssertEqual(object.description, "New Description")
        XCTAssertEqual(object.label, "New Label")
        XCTAssertEqual(object.name, "new_name")
        XCTAssertEqual(object.includeAll, false)
        XCTAssertEqual(object.templateIds, [1, 2, 3])
        XCTAssertEqual(object.configs[0].context.isGlobal, false)
        XCTAssertEqual(object.configs[0].context.projectIds, [1, 2, 3])
        XCTAssertEqual(object.configs[0].options.isRequired, true)
        XCTAssertEqual(object.configs[0].options.items, ["One", "Two", "Three"])
    }

}
