import SwiftUI
import ComposableArchitecture
import SnapshotTesting
@testable import Github_Playgrounds

/// Due to subtle differences, must record on an iPhone 15.
func assertSnapshotOnDefaultDevices<Value: View>(
    _ view: Value,
    record: SnapshotTestingConfiguration.Record = .missing,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column
) {
    withSnapshotTesting(record: record) {
        let hostingVC = UIHostingController(rootView: view)
        assertSnapshot(of: hostingVC, as: .image(on: .iPhone13Mini(.landscape)), named: "iPhone13Mini-landscape", fileID: fileID, file: filePath, testName: testName, line: line, column: column)
        assertSnapshot(of: hostingVC, as: .image(on: .iPhone13Mini), named: "iPhone13Mini", fileID: fileID, file: filePath, testName: testName, line: line, column: column)
        assertSnapshot(of: hostingVC, as: .image(on: .iPhone13ProMax), named: "iPhone13ProMax", fileID: fileID, file: filePath, testName: testName, line: line, column: column)
        assertSnapshot(of: hostingVC, as: .image(on: .iPadMini), named: "iPadMini", fileID: fileID, file: filePath, testName: testName, line: line, column: column)
        assertSnapshot(of: hostingVC, as: .image(on: .iPadPro12_9(.landscape)), named: "iPadPro12_9-landscape", fileID: fileID, file: filePath, testName: testName, line: line, column: column)
    }
}
