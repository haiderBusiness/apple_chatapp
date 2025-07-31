//
//  EmojisView+DidScroll.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 3.11.2023.
//

import UIKit

extension EmojisView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScrolling == false {
            detectCurrentSection()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.isScrolling = false
    }
    
    func detectCurrentSection() {
        let visibleIndexPaths = self.emojisCollectionView.indexPathsForVisibleItems
        DispatchQueue.global(qos: .userInitiated).async {
            var sectionCounts = [Int: Int]()
            
            for indexPath in visibleIndexPaths {
                let section = indexPath.section
                sectionCounts[section] = (sectionCounts[section] ?? 0) + 1
            }

            let mostVisibleSection = sectionCounts.max(by: { $0.1 < $1.1 })?.key ?? 0
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.focusedSection = mostVisibleSection
                
                if self.prevFocusedSection != self.focusedSection {
                    self.isScrolling = true
                    self.toolbar.updateSelection(sectionIndex: self.focusedSection, animated: true)
                    self.isScrolling = false
                }
                self.prevFocusedSection = self.focusedSection
            }
        }
    }
}
