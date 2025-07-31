//
//  ChatroomVC+CheickingWhichCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 28.9.2023.
//

import UIKit

struct PreviewShowInfo {
    var isAuth: Bool
    var snapshot: UIView
    var cellPosition: CGRect
    var cellWidth: CGFloat
    var cellHeight: CGFloat
}

private var completionWorkItem: DispatchWorkItem = DispatchWorkItem{}
extension ChatroomVC {
    
    func prepareCellForShow(indexPath: IndexPath, view: UIView) -> PreviewShowInfo?  {
        let cell = tableView.cellForRow(at: indexPath) as! CoreMessageCell
        
            let cellRectInWindow = cell.convert(cell.mainView.frame, to: view)
            
            guard let snapshot = cell.mainView.snapshotView(afterScreenUpdates: false) else { return nil }
        
            let previewWidth = cell.mainView.bounds.size.width
            let previewHeight = cell.mainView.bounds.size.height
        
            return PreviewShowInfo(isAuth: cell.isAuth, snapshot: snapshot, cellPosition: cellRectInWindow, cellWidth: previewWidth, cellHeight: previewHeight)
    }
    
//    func hideCellBeforeShow(indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? CTRMPhotoWithTextCell {
//            cell.alpha = 0
//        }
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMOnlyPhotoMessageCell {
//            cell.alpha = 0
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMLocationWithTextCell {
//            cell.alpha = 0
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMLocationMessageCell {
//            cell.alpha = 0
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMAudioMessageCell {
//            cell.alpha = 0
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMTextMessageCell {
//            cell.alpha = 0
//        }
//
//    }
//
//    func showCellInAfterShow(indexPath: IndexPath) {
//
//        if let cell = tableView.cellForRow(at: indexPath) as? CTRMPhotoWithTextCell {
//            cell.alpha = 1
//        }
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMOnlyPhotoMessageCell {
//            cell.alpha = 1
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMLocationWithTextCell {
//            cell.alpha = 1
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMLocationMessageCell {
//            cell.alpha = 1
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMAudioMessageCell {
//            cell.alpha = 1
//        }
//
//        else if let cell = tableView.cellForRow(at: indexPath) as? CTRMTextMessageCell {
//            cell.alpha = 1
//        }
//    }
    
}


extension ChatroomVC {
    
    
    // MARK: Animation
    
    func animateCell(indexPath: IndexPath , completion: @escaping (() -> Void) = {}) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CoreMessageCell
        
        UIView.animate(withDuration: 0.25, animations: {
            cell.mainView.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            self.view.layoutIfNeeded()
        }, completion: { _ in
            if cell.mainView.transform == CGAffineTransform(scaleX: 0.92, y: 0.92) {
                
                UIView.animate(withDuration: 0.25, animations: {
                    cell.mainView.transform = .identity
                    self.view.layoutIfNeeded()
                }, completion: { completed in
                    if completed {
                     //   completion()
                    }
                })
            }
        })
            
        completionWorkItem = DispatchWorkItem {
            print("isScrolling: ", self.isScrolling)
            if !self.isScrolling {
              completion()
            }
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: completionWorkItem)
    }
        
    
    
    // MARK: Reset Cell Animation
    
    func resetCellAnimation(indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CoreMessageCell
            cell.mainView.layer.removeAllAnimations()
            completionWorkItem.cancel()
            UIView.animate(withDuration: 0.25, animations: {
                    cell.mainView.transform = .identity
                    self.view.layoutIfNeeded()
                })
    }
    
    
    
    // MARK: ON CELL REMOVE
    func onCellRemove(indexPath: IndexPath) {
         let cell = tableView.cellForRow(at: indexPath) as! CoreMessageCell
            cell.longPressRecognizer = nil
    }
    
   
    
}

