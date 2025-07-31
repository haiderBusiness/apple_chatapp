
import UIKit
import FDWaveformView
import AVFoundation

struct AudioUrlObject {
    var audioFolderName: String
    var audioFileName: String
}

class AudioPlayerView: UIView {
    
    
    
    
    let waveformView = FDWaveformView()
//    var audioPlayer: AVAudioPlayer?
    var audioPlayer: AVAudioPlayerNode?
    
    var cachedAudioElements: CachedAudioData?
    
    var onPausPlay: (() -> Void) = {}
    
    
    public var playButtonColor: UIColor = .systemGray2 {
        didSet {
            playPauseImageView.tintColor = playButtonColor
        }
    }
    
    public var audioSpeedButtonColor: UIColor = .systemGray2 {
        didSet {
            audioSpeedButton.backgroundColor = audioSpeedButtonColor
        }
    }
    
    public var audioSpeedTextColor: UIColor = .systemGray4 {
        didSet {
            audioSpeedLabel.textColor = audioSpeedTextColor
        }
    }
    
    public var audioUrlObject: AudioUrlObject? {
        didSet {
            if let audioUrlObject = audioUrlObject {
                loadAudio(folderName: audioUrlObject.audioFolderName, fileName: audioUrlObject.audioFileName)
            }
        }
    }
    
    
    
    public var audioSpeed: Float = 1.0
    
    var audioSpeedLabel = UILabel()
    
    var audioSpeedLabelWidthConstraint: NSLayoutConstraint?
    
    var playPauseImageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.image = UIImage(systemName: "play.circle.fill")
        view.tintColor = .systemGray4
        return view
    }();
    
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
//        label.text = "00:00"
        return label
    }();
    
    
    var audioSpeedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }();
    
    
    
    var durationLabelViewWidth: NSLayoutConstraint!
    var durationLabelWidth: NSLayoutConstraint!
    
    let durationView = UIView();
    
    let circleLineView = CircleLineView();
    
    var playPauseButton = UIButton(type: .system)
    
    var timer: Timer?
    
    var panGestureRecognizer: UIPanGestureRecognizer!
    var previousHighlightedSamples: Int = 0
    var accumulatedTranslation: CGPoint = .zero
    var isDragging = false
    
    var previousDraggedValue: CGFloat = 0
    
    var circle = UIView()
    
    public var showPointer = true {
        didSet {
            if showPointer {
                circle.alpha = 1
            } else {
                circle.alpha = 0
            }
        }
    }
    
    public var wavesColor: UIColor = .systemGray4 {
        didSet {
            waveformView.wavesColor = wavesColor
            circleLineView.fillColor = wavesColor
        }
    }
    
    public var wavesProgressColor: UIColor = .systemGray2 {
        didSet {
            waveformView.progressColor = wavesProgressColor
        }
    }
    
    public var pointerColor: UIColor = .systemGray {
        didSet {
            circle.backgroundColor = pointerColor
        }
    }
    
    
    public var durationLabelColor: UIColor = .systemGray2 {
        didSet {
            durationLabel.textColor = durationLabelColor
        }
    }
    
    
    var audioDidFinish = false
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
       
    }
    
    
    init(frame: CGRect, audioUrlObject: AudioUrlObject) {
        self.audioUrlObject = audioUrlObject
        super.init(frame: frame)
        setupUI()
//        loadAudio(folderName: audioUrlObject.audioFolderName, fileName: audioUrlObject.audioFileName)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    // MARK: call UI functions
    func setupUI() {
        setupPlayPauseButton()
        
        addSubview(audioSpeedButton)
        addSubview(durationView)
        setupWaves()
//        setupCircleLineView()
        configureCircle()
        setupDurationLabel()
        self.backgroundColor = .clear
        
        //configure speed button
        configureAudioSpeedButton()
    }
    
}




