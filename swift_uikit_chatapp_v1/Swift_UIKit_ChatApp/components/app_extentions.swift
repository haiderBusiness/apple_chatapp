//
//  LoadWebImage.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 31.5.2023.
//

import Foundation
import UIKit



//extension ImageViewPro {
//
//
//
//    @objc func load(urlString: String) {
//
//        //check if image is cached
//        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
//            self.image = image;
//            return
//        }
//
//        // check if received string prop is valid make it of type URL
//        guard let url = URL(string: urlString) else{
//            return
//        }
//
//
//
//        // load web image
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        imageCache.setObject(image, forKey: urlString as NSString)
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//
//
//    func icon() {
//        self.image = Empty.image
//    }
//
//
//}


extension UITextView {

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(0, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}


//extension UIButton {
//
//
//    func setBackground(target: Any, defaultBackgrond: UIColor?, highlightBackground: UIColor?) {
//        addTarget(target, action: #selector(highlightButton), for: .touchDown)
//        addTarget(target, action: #selector(unHighlightButton), for: .touchUpInside)
//
//    }
//
//    @objc func highlightButton() {
//        backgroundColor = .systemGray4
//        //addTarget(target, action: #selector(unHighlightButton), for: .touchUpInside)
//    }
//
//    @objc func unHighlightButton() {
//        backgroundColor = .systemBackground
//    }
//
//}



class HighlightedButton: UIButton {
    
    var highlightedColor: UIColor = .systemGray4
    var unhighlightedColor: UIColor = .secondarySystemBackground

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedColor : unhighlightedColor
        }
    }

}

extension UITableView {

    func setEmptyMessage(_ message: String, iconName: String?, afterIconText: String = "") {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    
        
        if let iconName = iconName {
            // Create Attachment
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName:iconName)
            // Set bound to reposition
            let imageOffsetY: CGFloat = -5.0
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
            // Create string with attachment
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            // Initialize mutable string
            let completeText = NSMutableAttributedString(string: message + " ")
            // Add image to mutable string
            completeText.append(attachmentString)
            // Add your text to mutable string
            let textAfterIcon = NSAttributedString(string: " " + afterIconText)
            completeText.append(textAfterIcon)
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont.systemFont(ofSize: 17)
            messageLabel.sizeToFit()
            messageLabel.attributedText = completeText
        } else {
            messageLabel.text = message
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 17)
            messageLabel.sizeToFit()
        }
        

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}






class FetchFromBotomTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}




var imageSizeCache = NSCache<AnyObject, AnyObject>();

let intrinsicContentSizeCache = NSCache<NSString, NSValue>()

class ScaledHeightImageView: ImageViewPro {
    private var cacheKey: NSString {
        return NSString(format: "%p", self)
    }

    override var intrinsicContentSize: CGSize {
        
//        if let cachedSize = intrinsicContentSizeCache.object(forKey: cacheKey)?.cgSizeValue {
//            return cachedSize
//        }

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth / myImageWidth
            let scaledHeight = myImageHeight * ratio

            let scaledSize = CGSize(width: myViewWidth * 1.5, height: scaledHeight * 1.5)
            
//            intrinsicContentSizeCache.setObject(NSValue(cgSize: scaledSize), forKey: cacheKey)
            return scaledSize
        }

        return CGSize(width: -1.0, height: -1.0)
    }
    
    
//    func imageToString(image: UIImage) -> String {
//            let base64String = image.pngData()!.base64EncodedString(options: .lineLength64Characters)
//            return base64String
//
//    }

    
//    override var intrinsicContentSize: CGSize {
//
//            if let myImage = self.image {
//
//                let myImageWidth = myImage.size.width * 0.1
//                let myImageHeight = myImage.size.height * 0.1
//
//                let aspectRatio = myImageWidth / myImageHeight
//
//                let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: aspectRatio, constant: 0)
//                widthConstraint.priority = UILayoutPriority(999)
//                widthConstraint.isActive = true
//
//                return super.intrinsicContentSize
//            }
//
//            return CGSize(width: -1.0, height: -1.0)
//        }
}
    






extension UIView {
    func isAnyViewAbove() -> Bool {
        guard let superview = superview else {
            return false
        }
        
        let _ = convert(bounds, to: superview)
        let viewsAbove = superview.subviews.filter { subview in
            let frameInSuperview = subview.convert(subview.bounds, to: superview)
            return frameInSuperview.intersects(frameInSuperview) && subview != self
        }
        
        return !viewsAbove.isEmpty
    }
}

    
extension UINavigationBar {
    func toggle() {
        if self.layer.zPosition == -1 {
            self.layer.zPosition = 0
            self.isUserInteractionEnabled = true
        } else {
            self.layer.zPosition = -1
            self.isUserInteractionEnabled = false
        }
    }
}




public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
  }
}
extension Int {
  var degreesToRadians: CGFloat {
    return CGFloat(self) * .pi / 180.0
  }
}
extension Double {
  var toTimeString: String {
    let seconds: Int = Int(self.truncatingRemainder(dividingBy: 60.0))
    let minutes: Int = Int(self / 60.0)
    return String(format: "%d:%02d", minutes, seconds)
  }
}


extension UIView {
    func copyView<T: UIView>() -> T? {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData) as? T
        } catch {
            print("Error copying view: \(error)")
            return nil
        }
    }
}
