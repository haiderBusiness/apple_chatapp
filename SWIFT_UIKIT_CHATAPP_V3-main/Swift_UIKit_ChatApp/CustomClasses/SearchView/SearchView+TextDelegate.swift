//
//  SearchView+TextDelegate.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.10.2023.
//

import UIKit

extension SearchView {
    
    func textViewDidChange(_ textView: UITextView) {
//        print("the keyboard has been done")
        self.searchLabel.frame.size.height = textView.contentSize.height
        self.searchLabel.isScrollEnabled = false // textView.isScrollEnabled = false for swift 4.0
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        
        
        
        if updatedText.isEmpty {
            textView.text = self.searchLabelPlaceHolder
            textView.textColor = self.searchLabelPlaceHolderColor
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            // if there is nothing
            self.showSearchResults("")
        }
        
        

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
        else if textView.textColor == self.searchLabelPlaceHolderColor && !text.isEmpty {
             textView.textColor = self.searchLabelTextColor // this has to be called first for the text view indicator to be at the end of the text
             textView.text = text
             self.showSearchResults(text)
        }

        // For every other case, the text should change with the usual behavior...
        else {
            
            if let textOfTextView = textView.text, !text.isEmpty {
                // if there is new text
                self.showSearchResults(textOfTextView + text)
            } else if let _ = textView.text, text.isEmpty, textView.textColor != self.searchLabelPlaceHolderColor {
                // if there is no text

                self.showSearchResults(updatedText)
            }
            
//            if text.isEmpty {
//                print("isEmpty")
//            }
            
            return true
        }
        

            
        // ...otherwise return false since the updates have already been made
        return false
    }
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.window != nil {
            onSearchButtonClick()
            if textView.textColor == self.searchLabelPlaceHolderColor {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        
        }
    }
    
    
    
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        onSearchButtonClick()
    }
    
    
}
