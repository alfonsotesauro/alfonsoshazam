# Alfonso's Shazam

A macOS application that uses ShazamKit to recognize music files stored on disk.

## Features

- 🎵 Select local music files (MP3, M4A, WAV, AIFF)
- 🔍 Recognize songs using ShazamKit
- 📋 Display song information (Title, Artist, Album)
- ⚠️ Comprehensive error handling for unsupported formats

## Requirements

- macOS 12.0 or later
- Xcode 13.0 or later
- Swift 5.9 or later

## Building the Application

### Using Xcode

1. Open Terminal and navigate to the project directory
2. Generate the Xcode project:
   ```bash
   swift package generate-xcodeproj
   ```
3. Open the generated `.xcodeproj` file in Xcode
4. Select the "AlfonsosShazam" scheme
5. Build and run (⌘R)

### Using Swift Package Manager

Build from command line:
```bash
swift build
```

Run the application:
```bash
swift run
```

## Usage

1. Launch the application
2. Click the "Select Music File" button
3. Choose a music file from your disk
4. Wait for ShazamKit to analyze and recognize the song
5. View the song information (title, artist, album) displayed in the app

## Supported File Formats

- MP3 (.mp3)
- M4A/AAC (.m4a)
- WAV (.wav)
- AIFF (.aiff)

## Error Handling

The app includes error handling for:
- Unsupported file formats
- Files that cannot be recognized by ShazamKit
- Audio processing errors
- Network connectivity issues (ShazamKit requires internet)

## Technical Details

- **Framework**: AppKit (native macOS UI)
- **Language**: Swift
- **Music Recognition**: ShazamKit
- **Audio Processing**: AVFoundation
- **Architecture**: MVC (Model-View-Controller)

## Project Structure

```
Sources/
├── AppDelegate.swift           # Application lifecycle
├── MainWindowController.swift  # Window management
├── MainViewController.swift    # Main UI and ShazamKit integration
└── Info.plist                  # App configuration
```

## License

MIT License
