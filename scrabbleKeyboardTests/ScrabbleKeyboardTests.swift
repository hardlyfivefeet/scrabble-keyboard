import XCTest
@testable import scrabble_keyboard

class ScrabbleKeyboardTests: XCTestCase {

    func testScrabbleKeyStartsWithCorrectInitialValues() {
        let scrabbleKey = ScrabbleKey()
        XCTAssertNotNil(scrabbleKey.scrabbleLayer, "Scrabble key should have its own layer")
        XCTAssertNotNil(scrabbleKey.textLayer, "Scrabble text should have its own layer")
    }

    func testScrabbleKeyUpdatesEditablePropertiesCorrectly() {
        let scrabbleKey = ScrabbleKey()

        scrabbleKey.scrabbleKeyBackgroundColor = .red
        XCTAssertEqual(scrabbleKey.scrabbleLayer.backgroundColor, UIColor.red.cgColor, "Background color should go to scrabble layer")

        scrabbleKey.scrabbleKeyBorderColor = .yellow
        XCTAssertEqual(scrabbleKey.scrabbleLayer.borderColor, UIColor.yellow.cgColor, "Border color should go to scrabble layer")

        scrabbleKey.scrabbleKeyBorderWidth = 100
        XCTAssertEqual(scrabbleKey.scrabbleLayer.borderWidth, 100, "Border width should go to scrabble layer")

        scrabbleKey.scrabbleKeyLetter = "C"
        XCTAssertEqual(scrabbleKey.textLayer.string as! NSString, "C", "Letter should go to text layer")

        scrabbleKey.scrabbleKeyLetterColor = .green
        XCTAssertEqual(scrabbleKey.textLayer.foregroundColor, UIColor.green.cgColor, "Text color should go to text layer")
    }
}
