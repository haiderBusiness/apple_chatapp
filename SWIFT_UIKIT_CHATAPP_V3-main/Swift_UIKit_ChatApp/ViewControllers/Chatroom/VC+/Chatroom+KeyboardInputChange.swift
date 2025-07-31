//
//  KeyboardInputChange.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 24.6.2023.
//

import UIKit

extension ChatroomVC: UITextViewDelegate {

//    func textViewDidChange(_ textView: UITextView) {
//        let maxHeight = textView.font!.lineHeight * CGFloat(textView.textContainer.maximumNumberOfLines)
//        let contentSize = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
//
//        //textView.isScrollEnabled = contentSize.height > maxHeight
//        print(contentSize.height)
//    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
            if textView.contentSize.height >= self.messageInputViewMaxHeight {
                    textView.isScrollEnabled = true
            }
            else {
                //print("the keyboard has been done")
                textView.frame.size.height = textView.contentSize.height
                textView.isScrollEnabled = false // textView.isScrollEnabled = false for swift 4.0
            }

    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.text == Language.message {
//            textView.text = ""
//            textView.textColor = .black
//        }
//    }

//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = Language.message
//            textView.textColor = .lightGray
//        }
//    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            showSendImage(show: false)
            textView.text = Language.message
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
             showSendImage(show: true)
             textView.textColor = .label
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }
  
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    
    func showSendImage(show: Bool) {
        
        if !show {
            self.sendImageBackgroundView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.sendImageBackgroundView.alpha = 0
                self.sendImageBackgroundView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
        } else {
            self.sendImageBackgroundView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.sendImageBackgroundView.alpha = 1
                self.sendImageBackgroundView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
        
            self.view.layoutIfNeeded()
        
        
        
//        var sendIcon = ImageViewPro(names: )
    }
}
