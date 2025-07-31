
import UIKit
import AVFoundation

class AudioRecorderView: UIView, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var onEndPress: (() -> Void) = {}
    
    var onLongPressStart: (() -> Void) = {}
    var onLongPressEnd: (() -> Void) = {}
    
    var onDragStart: (() -> Void) = {}
    var onDragEnd: (() -> Void) = {}
    
    var AudioRecordingDelegate: AudioRecordingDelegate?
    
    var audioFolderName: String!
    var audioFileName: String?
    var audioFullPathURL: URL?
    
    
    
    var playButton = UIButton(type: .system)
    var recordButton = UIButton(type: .system)
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var blubAndTimerView = UIView()
    
    var timerLabel = UILabel()
    
    var timer: Timer?
    var counter: Decimal = 0.00
    
    var blubView = UIButton()
    
    var cancelButton = UIButton(type: .system)
    let cancelLabel = UILabel()
    
    var micButton = UIButton()
    
    var micIconImage: UIImageView = {
        var pinMark = UIImageView()
        pinMark.translatesAutoresizingMaskIntoConstraints = false;
        pinMark.image = UIImage(systemName: "mic")
        pinMark.tintColor = .white
        return pinMark
    }();
    
    
    // lock icon and arrow icon button
    
    var lockAndArrowButton = UIButton()
    
    let lockAndArrowBackgroundView = UIView()
    
    var lockIconImage: UIImageView = {
        var pinMark = UIImageView()
        pinMark.translatesAutoresizingMaskIntoConstraints = false;
        pinMark.image = UIImage(systemName: "lock.open.fill")
        pinMark.tintColor = AppTheme.primaryColor
        return pinMark
    }();
    
    var arrowIconImage: UIImageView = {
        var pinMark = UIImageView()
        pinMark.translatesAutoresizingMaskIntoConstraints = false;
        pinMark.image = UIImage(systemName: "chevron.up")
        pinMark.tintColor = AppTheme.primaryColor
        return pinMark
    }();
    
    
    
    //
    var micButtonWidthConstraint: NSLayoutConstraint?
    var micButtonHeightConstraint: NSLayoutConstraint?
    var micButtonTrailingConstraint: NSLayoutConstraint?
    
    //
    var blubAndTimerViewLeadingConstraint: NSLayoutConstraint?
    
    //
    var cancelButtonCenterXAnchor: NSLayoutConstraint?
    
    //
    var lockIconImageBottomConstraint: NSLayoutConstraint?
    var arrowIconImageTopConstraint: NSLayoutConstraint?
    var lockAndArrowButtonBottomConstraint: NSLayoutConstraint? 
    
    
    
    var pauseBlubAnimation = false
    var stopCancelAnimation = false
    
    
    var shouldAllowDraggingPan: Bool = true
    
    var stopCancelLoop = false
    var stopArrowAndLockLoop = false
    
    var cancelRecording = false
    var isRecordingLocked = false
    
    override init(frame: CGRect) {
//            locationPin = MKPointAnnotation()
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        
        // setup logic
        setupRecorder()
        
        // configure UI
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.backgroundColor = .systemGray6
//
//        // setup logic
//        setupRecorder()
//
//        // configure UI
//        configureUI()
//
//    }
    
    
    


}
