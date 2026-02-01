# UI Design Documentation

## Application Window

**Title**: Alfonso's Shazam  
**Window Size**: 600x500 pixels  
**Style**: Standard macOS window with title bar, close/minimize/maximize buttons

## Layout Description

```
┌─────────────────────────────────────────────────────────────┐
│  ○  ○  ○                    Alfonso's Shazam                │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│                      Alfonso's Shazam                         │
│                    (Large, Bold Title)                        │
│                                                               │
│                  ┌──────────────────────┐                    │
│                  │  Select Music File   │                    │
│                  └──────────────────────┘                    │
│                      (Rounded Button)                         │
│                                                               │
│                    ⊙ Progress Indicator                      │
│                 (Spinning, hidden by default)                 │
│                                                               │
│            Select a music file to identify                    │
│               (Status message, centered)                      │
│                                                               │
│  ────────────────────────────────────────────────────        │
│                                                               │
│   Song Information:                                           │
│   (Section heading, bold)                                     │
│                                                               │
│     Title:     -                                              │
│                (Song title appears here)                      │
│                                                               │
│     Artist:    -                                              │
│                (Artist name appears here)                     │
│                                                               │
│     Album:     -                                              │
│                (Album name appears here)                      │
│                                                               │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## UI States

### 1. Initial State
- Status: "Select a music file to identify"
- Progress Indicator: Hidden
- Song Info: All fields show "-"
- Button: Enabled

### 2. Processing State
- Status: "Analyzing audio file..."
- Progress Indicator: Visible and spinning
- Song Info: All fields show "-"
- Button: Disabled

### 3. Success State
- Status: "Song recognized successfully!" (Green text)
- Progress Indicator: Hidden
- Song Info: Populated with actual data
  - Title: "Song Name"
  - Artist: "Artist Name"
  - Album: "Album Name"
- Button: Enabled

### 4. No Match State
- Status: "No match found for this audio" (Orange text)
- Progress Indicator: Hidden
- Song Info: All fields show "-"
- Button: Enabled

### 5. Error State
- Status: "Error: [error message]" (Red text)
- Progress Indicator: Hidden
- Song Info: All fields show "-"
- Button: Enabled
- Alert Dialog: Shows detailed error message

## File Picker Dialog

When "Select Music File" is clicked:
```
┌─────────────────────────────────────────────────┐
│  Select a Music File                            │
├─────────────────────────────────────────────────┤
│                                                  │
│  [File Browser Interface]                        │
│                                                  │
│  Files shown:                                    │
│  - Audio files (.mp3, .m4a, .wav, .aiff)       │
│                                                  │
│                        ┌────────┐  ┌────────┐  │
│                        │ Cancel │  │  Open  │  │
│                        └────────┘  └────────┘  │
└─────────────────────────────────────────────────┘
```

## Color Scheme

- **Background**: Standard macOS window background (light gray/white)
- **Text**: System label colors
  - Primary text: Black (light mode)
  - Secondary text: Gray
  - Success: System green
  - Warning: System orange
  - Error: System red
- **Button**: Standard macOS rounded button style
- **Progress Indicator**: System blue spinning indicator

## Typography

- **App Title**: 24pt, Bold, System Font
- **Section Headers**: 16pt, Semibold, System Font
- **Field Labels**: 12pt, Medium, System Font
- **Field Values**: 12pt, Regular, System Font
- **Status Text**: System default, Center aligned

## Spacing

- **Top margin**: 40px
- **Between elements**: 15-30px
- **Side margins**: 40px for labels, 60px for field labels
- **Button width**: 200px

## Accessibility

- All text fields are labeled
- Button has clear action text
- Status messages provide context
- Error alerts provide detailed information
- Standard macOS keyboard navigation support

## Example Interaction Flow

1. **User launches app** → Sees initial state
2. **User clicks "Select Music File"** → File picker opens
3. **User selects song.mp3** → File picker closes
4. **App shows processing state** → Progress indicator spins
5. **ShazamKit recognizes song** → Success state with song info
6. **User can select another file** → Returns to step 2

## Notes

- The UI is built entirely with AppKit (no SwiftUI)
- All layout uses Auto Layout constraints
- UI updates happen on the main thread
- File selection uses standard NSOpenPanel
- Clean, minimal design focusing on functionality
