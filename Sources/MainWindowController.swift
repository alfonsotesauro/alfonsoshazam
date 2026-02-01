import Cocoa

class MainWindowController: NSWindowController {
    
    convenience init() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 600, height: 500),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        
        window.title = "Alfonso's Shazam"
        window.center()
        
        self.init(window: window)
        
        // Create and set the main view controller
        let mainViewController = MainViewController()
        window.contentViewController = mainViewController
    }
}
