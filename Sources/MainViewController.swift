import Cocoa
import ShazamKit
import AVFoundation

class MainViewController: NSViewController, SHSessionDelegate {
    
    // UI Elements
    private var selectFileButton: NSButton!
    private var songTitleLabel: NSTextField!
    private var artistLabel: NSTextField!
    private var albumLabel: NSTextField!
    private var statusLabel: NSTextField!
    private var progressIndicator: NSProgressIndicator!
    
    // ShazamKit
    private var session: SHSession?
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 600, height: 500))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupShazamKit()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        // Title Label
        let titleLabel = NSTextField(labelWithString: "Alfonso's Shazam")
        titleLabel.font = NSFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Select File Button
        selectFileButton = NSButton(title: "Select Music File", target: self, action: #selector(selectFile))
        selectFileButton.translatesAutoresizingMaskIntoConstraints = false
        selectFileButton.bezelStyle = .rounded
        view.addSubview(selectFileButton)
        
        // Progress Indicator
        progressIndicator = NSProgressIndicator()
        progressIndicator.style = .spinning
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.isHidden = true
        view.addSubview(progressIndicator)
        
        // Status Label
        statusLabel = NSTextField(labelWithString: "Select a music file to identify")
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.alignment = .center
        statusLabel.textColor = .secondaryLabelColor
        view.addSubview(statusLabel)
        
        // Results Section Label
        let resultsLabel = NSTextField(labelWithString: "Song Information:")
        resultsLabel.font = NSFont.systemFont(ofSize: 16, weight: .semibold)
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultsLabel)
        
        // Song Title
        let titleFieldLabel = NSTextField(labelWithString: "Title:")
        titleFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        titleFieldLabel.font = NSFont.systemFont(ofSize: 12, weight: .medium)
        view.addSubview(titleFieldLabel)
        
        songTitleLabel = NSTextField(labelWithString: "-")
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.isEditable = false
        songTitleLabel.isBordered = false
        songTitleLabel.backgroundColor = .clear
        view.addSubview(songTitleLabel)
        
        // Artist
        let artistFieldLabel = NSTextField(labelWithString: "Artist:")
        artistFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        artistFieldLabel.font = NSFont.systemFont(ofSize: 12, weight: .medium)
        view.addSubview(artistFieldLabel)
        
        artistLabel = NSTextField(labelWithString: "-")
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.isEditable = false
        artistLabel.isBordered = false
        artistLabel.backgroundColor = .clear
        view.addSubview(artistLabel)
        
        // Album
        let albumFieldLabel = NSTextField(labelWithString: "Album:")
        albumFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        albumFieldLabel.font = NSFont.systemFont(ofSize: 12, weight: .medium)
        view.addSubview(albumFieldLabel)
        
        albumLabel = NSTextField(labelWithString: "-")
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.isEditable = false
        albumLabel.isBordered = false
        albumLabel.backgroundColor = .clear
        view.addSubview(albumLabel)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            // Title
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            
            // Select File Button
            selectFileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectFileButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            selectFileButton.widthAnchor.constraint(equalToConstant: 200),
            
            // Progress Indicator
            progressIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressIndicator.topAnchor.constraint(equalTo: selectFileButton.bottomAnchor, constant: 20),
            
            // Status Label
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: selectFileButton.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            // Results Section
            resultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            resultsLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            
            // Title Field
            titleFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            titleFieldLabel.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 20),
            titleFieldLabel.widthAnchor.constraint(equalToConstant: 80),
            
            songTitleLabel.leadingAnchor.constraint(equalTo: titleFieldLabel.trailingAnchor, constant: 10),
            songTitleLabel.centerYAnchor.constraint(equalTo: titleFieldLabel.centerYAnchor),
            songTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            // Artist Field
            artistFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            artistFieldLabel.topAnchor.constraint(equalTo: titleFieldLabel.bottomAnchor, constant: 15),
            artistFieldLabel.widthAnchor.constraint(equalToConstant: 80),
            
            artistLabel.leadingAnchor.constraint(equalTo: artistFieldLabel.trailingAnchor, constant: 10),
            artistLabel.centerYAnchor.constraint(equalTo: artistFieldLabel.centerYAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            // Album Field
            albumFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            albumFieldLabel.topAnchor.constraint(equalTo: artistFieldLabel.bottomAnchor, constant: 15),
            albumFieldLabel.widthAnchor.constraint(equalToConstant: 80),
            
            albumLabel.leadingAnchor.constraint(equalTo: albumFieldLabel.trailingAnchor, constant: 10),
            albumLabel.centerYAnchor.constraint(equalTo: albumFieldLabel.centerYAnchor),
            albumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    private func setupShazamKit() {
        session = SHSession()
        session?.delegate = self
    }
    
    @objc private func selectFile() {
        let openPanel = NSOpenPanel()
        openPanel.title = "Select a Music File"
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowsMultipleSelection = false
        openPanel.allowedContentTypes = [.audio, .mp3, .mpeg4Audio, .wav, .aiff]
        
        openPanel.begin { [weak self] response in
            guard let self = self else { return }
            
            if response == .OK, let url = openPanel.url {
                self.recognizeMusic(from: url)
            }
        }
    }
    
    private func recognizeMusic(from url: URL) {
        // Reset UI
        songTitleLabel.stringValue = "-"
        artistLabel.stringValue = "-"
        albumLabel.stringValue = "-"
        statusLabel.stringValue = "Analyzing audio file..."
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(nil)
        selectFileButton.isEnabled = false
        
        // Create audio file and generate signature
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            do {
                // Load audio file
                let audioFile = try AVAudioFile(forReading: url)
                
                // Create audio format
                guard let format = AVAudioFormat(
                    commonFormat: .pcmFormatFloat32,
                    sampleRate: audioFile.processingFormat.sampleRate,
                    channels: 1,
                    interleaved: false
                ) else {
                    throw NSError(
                        domain: "com.alfonsoshazam",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to create audio format"]
                    )
                }
                
                // Create audio converter
                guard let converter = AVAudioConverter(from: audioFile.processingFormat, to: format) else {
                    throw NSError(
                        domain: "com.alfonsoshazam",
                        code: 2,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to create audio converter"]
                    )
                }
                
                // Calculate buffer size (process up to 30 seconds)
                let maxFrames = min(AVAudioFrameCount(audioFile.length), AVAudioFrameCount(30 * format.sampleRate))
                
                guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: maxFrames) else {
                    throw NSError(
                        domain: "com.alfonsoshazam",
                        code: 3,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to create audio buffer"]
                    )
                }
                
                // Read and convert audio
                try audioFile.read(into: buffer, frameCount: maxFrames)
                
                var error: NSError?
                let inputBlock: AVAudioConverterInputBlock = { inNumPackets, outStatus in
                    outStatus.pointee = .haveData
                    return buffer
                }
                
                guard let convertedBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: maxFrames) else {
                    throw NSError(
                        domain: "com.alfonsoshazam",
                        code: 4,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to create converted buffer"]
                    )
                }
                
                converter.convert(to: convertedBuffer, error: &error, withInputFrom: inputBlock)
                
                if let error = error {
                    throw error
                }
                
                // Generate signature
                let signature = try SHSignatureGenerator().append(convertedBuffer, at: nil)
                
                // Match signature
                DispatchQueue.main.async {
                    self.session?.match(signature)
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.handleError(error)
                }
            }
        }
    }
    
    // MARK: - SHSessionDelegate
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.progressIndicator.stopAnimation(nil)
            self.progressIndicator.isHidden = true
            self.selectFileButton.isEnabled = true
            
            if let mediaItem = match.mediaItems.first {
                self.statusLabel.stringValue = "Song recognized successfully!"
                self.statusLabel.textColor = .systemGreen
                
                self.songTitleLabel.stringValue = mediaItem.title ?? "Unknown"
                self.artistLabel.stringValue = mediaItem.artist ?? "Unknown"
                self.albumLabel.stringValue = mediaItem.albumName ?? "Unknown"
            } else {
                self.statusLabel.stringValue = "No match found"
                self.statusLabel.textColor = .systemOrange
            }
        }
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.progressIndicator.stopAnimation(nil)
            self.progressIndicator.isHidden = true
            self.selectFileButton.isEnabled = true
            
            if let error = error {
                self.handleError(error)
            } else {
                self.statusLabel.stringValue = "No match found for this audio"
                self.statusLabel.textColor = .systemOrange
            }
        }
    }
    
    private func handleError(_ error: Error) {
        progressIndicator.stopAnimation(nil)
        progressIndicator.isHidden = true
        selectFileButton.isEnabled = true
        
        statusLabel.stringValue = "Error: \(error.localizedDescription)"
        statusLabel.textColor = .systemRed
        
        // Show alert for critical errors
        let alert = NSAlert()
        alert.messageText = "Recognition Error"
        alert.informativeText = error.localizedDescription
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
