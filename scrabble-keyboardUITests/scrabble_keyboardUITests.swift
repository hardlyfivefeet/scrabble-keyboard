import XCTest

class ScrabbleKeyboardUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testScrabbleKeybordEntersLettersCorrectly() {
        let textField = app.textFields["textField"]

        let HKey = app.otherElements["H"]
        HKey.press(forDuration: 0.5, thenDragTo: textField)
        let EKey = app.otherElements["E"]
        EKey.press(forDuration: 0.5, thenDragTo: textField)
        let LKey = app.otherElements["L"]
        LKey.press(forDuration: 0.5, thenDragTo: textField)
        LKey.press(forDuration: 0.5, thenDragTo: textField)
        let OKey = app.otherElements["O"]
        OKey.press(forDuration: 0.5, thenDragTo: textField)
        
        XCTAssertTrue(textField.value as? String == "HELLO")
    }
    
    func testScrabbleKeyboardEnterSpaceCorrectly() {
        let textField = app.textFields["textField"]

        let YKey = app.otherElements["Y"]
        YKey.press(forDuration: 0.5, thenDragTo: textField)
        let spaceKey = app.otherElements["Space"]
        spaceKey.press(forDuration: 0.5, thenDragTo: textField)
        let EKey = app.otherElements["E"]
        EKey.press(forDuration: 0.5, thenDragTo: textField)
        spaceKey.press(forDuration: 0.5, thenDragTo: textField)
        EKey.press(forDuration: 0.5, thenDragTo: textField)

        XCTAssertTrue(textField.value as? String == "Y E E")
    }
    
    func testScrabbleKeyboardDeletesLetterCorrectly() {
        let textField = app.textFields["textField"]

        let YKey = app.otherElements["Y"]
        YKey.press(forDuration: 0.5, thenDragTo: textField)
        let EKey = app.otherElements["E"]
        EKey.press(forDuration: 0.5, thenDragTo: textField)
        EKey.press(forDuration: 0.5, thenDragTo: textField)
        let deleteKey = app.otherElements["Delete"]
        deleteKey.press(forDuration: 0.5, thenDragTo: textField)

        XCTAssertTrue(textField.value as? String == "YE")
    }
}
