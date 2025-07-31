//
//  Chatroom+didScroll.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.8.2023.
//



import UIKit

extension ChatroomVC {

    
    // MARK: here

    func fetchMessages() -> [Message]? {
        if messagesDiskPath != nil, let savedMessages = retrieveNumberOfMessagesFromDatabaseOnDisk(fileName: fileName, folderName: messagesDiskPath, limit: limit, offset: messagesOffset, tableName: DataStore.shared.messagesTable) {
            messagesOffset += limit

            return savedMessages
        } else {
            
            return nil
        }

    }
    
    
    
    
    
    func updateTableView(fetchedMessages: [Message]) {
            
            DispatchQueue.main.async{ [weak self] in
                guard let self = self else { return }
                
//                let startTime = Date()
                
                
//                var testSectionTitle: String = ""
                
                let numberOfSectionsBeforeUpdate = self.sections.count
                let lastSectionTitleBeforeUpdate = self.sections.last!
                
                
                var indexPathsArray: [IndexPath] = []
//                var sectionIndexArray: [Int] = []
                
//                var sectionIndexStartNumber = 0
    
                let messages = fetchedMessages.sorted { $0.createdAt < $1.createdAt }
                let groupedFetchedMessages = Dictionary(grouping: messages) { (message) -> String in
                    return getSectionDateString(date: message.createdAt)
                }
    
    //            let fetchedSections = Array(groupedFetchedMessages.keys)
                let fetchedSections = Array(groupedFetchedMessages.keys).sorted { (dateString1, dateString2) in
                    let date1 = convertStringToDate(dateString1)
                    let date2 = convertStringToDate(dateString2)
                    return date1 > date2
                }
                
                let fetchedSectionMessages = groupedFetchedMessages
            //            print("groupedFetchedMessages",groupedFetchedMessages)
                var sectionLoopIndex = 0
//                var messageLoopIndex = 0
                for sectionTitle in fetchedSections {
                    
                    let oldDataSectionIndex = sectionLoopIndex + numberOfSectionsBeforeUpdate - 1
//                    let oldDataSectionIndex = numberOfSectionsBeforeUpdate - 1
                    
                    // insert index paths
                    let lastSectionMessages = self.sectionMessages[lastSectionTitleBeforeUpdate]
                    let newSectionMessages = fetchedSectionMessages[sectionTitle]!
                    
                    // test
//                    testSectionTitle = fetchedSections.last ?? ""
                    
                    
                    for i in 0..<newSectionMessages.count {
                        
                        if lastSectionTitleBeforeUpdate == sectionTitle {
                            
                            // update datasource specefic section messages
                            self.sectionMessages[sectionTitle]?.append(newSectionMessages[i])
                            self.messages.append(newSectionMessages[i])
                            // get the number of message row in section
                            let number = lastSectionMessages!.count + i
                            // append the row to indexPathsArray
//                            let indexPath = IndexPath(row: number, section: oldDataSectionIndex)
                            let indexPath = IndexPath(row: i, section: self.sections.count - 1)
                                indexPathsArray.append(indexPath)
                            
                            print("row: number: ", number, "section: oldDataSection: ",  oldDataSectionIndex)
                            
                        } else {
                            // append message to datasource messages
                            self.messages.append(newSectionMessages[i])
                            if i == 0 {
                                // append the new section to datasource sections only once
                                self.sections.append(sectionTitle)
                            }
                            
                            // if the datasource sectionMessages contains the section, append message to that section
                            if var existingArray = self.sectionMessages[sectionTitle] {
                                existingArray.append(newSectionMessages[i])
                                self.sectionMessages[sectionTitle] = existingArray
                            } else { // else create new datasource's section and append message to it
                                self.sectionMessages[sectionTitle] = [newSectionMessages[i]]
                            }
                            
                            // append new index path to indexPathsArray
//                            let indexPath = IndexPath(row: i, section: oldDataSectionIndex)
                            let indexPath = IndexPath(row: i, section: self.sections.count - 1)
                                indexPathsArray.append(indexPath)
                        }
                       
    
                    }
    
                    
                    sectionLoopIndex += 1
                }
                
                
//                print("indexPathsArray.count", indexPathsArray)
//                print("self.sectionMessages[testSectionTitle]", self.sectionMessages[testSectionTitle]?[0] ?? "nil")
                
                let sectionIndexEndNumber = numberOfSectionsBeforeUpdate + fetchedSections.filter({$0 != lastSectionTitleBeforeUpdate}).count - 1

//                self.tableView.performBatchUpdates({
                self.tableView.beginUpdates()
                    //update datasource first
//                    self.messages.append(contentsOf: fetchedMessages)

                    // Insert new sections if there are new!
                    if numberOfSectionsBeforeUpdate <= sectionIndexEndNumber {
                        self.tableView.insertSections(IndexSet(integersIn: numberOfSectionsBeforeUpdate...sectionIndexEndNumber), with: .none)
                    }
                    // Insert new rows
                    self.tableView.insertRows(at: indexPathsArray, with: .none)
//                }, completion: nil)
                self.tableView.endUpdates()
                
                self.isFetchingItems = false
                
//                self.messages.append(contentsOf: fetchedMessages)
//                self.fetchAndAppendNewData(newMessages: fetchedMessages)
//                let endTime = Date()
                
//                let timeElapsed = endTime.timeIntervalSince(startTime)
//                print("updated table view in: ", timeElapsed)
            }
    
    //        print("indexPaths: ", indexPathsArray)

    
        }
    
    
    
    // This method is called when the dragging ends
//      func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//          if !decelerate {
//              print("ScrollView has stopped dragging")
////              isScrolling = false
//          }
//      }
    
    // This method is called when the deceleration (momentum) stops
   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       isScrolling = false
   }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { // if the delecrate stops
            isScrolling = false
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.isDecelerating {
            // TODO:
        }
    }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
       if scrollView.isDragging { // set first render to false on the first drag
           firstRender = false
        }
        
        if !firstRender {
            isScrolling = true
        }
        
//        print("scrolling")
        // reset long press on scroll
//        if let longPressRecognaizer = self.longPressGestrueRecognaizer {
//            print("cancelled")
//            longPressRecognaizer.state = .cancelled
//        }
        
//        if let longPressGestureRecognizer = self.longPressGestrueRecognaizer, longPressGestureRecognizer.state == .began || longPressGestureRecognizer.state == .changed {
////                longPressGestureRecognizer.isEnabled = false
////                longPressGestureRecognizer.isEnabled = true
//            print("cancelled")a
//            scrollView.panGestureRecognizer.shouldRequireFailure(of: longPressGestureRecognizer)
//            }
        
        let offset = scrollView.contentOffset.y //<- scrolling position

//        if offset < 100 { // <- if the list was flipped than do this

        if offset > (tableView.contentSize.height - 200 - scrollView.frame.size.height) {
                
                guard !isFetchingItems else {
                    // we are fetching data: return
                    return
                }
            
                isFetchingItems = true
            
                if let fetchedMessages = fetchMessages() {
                    self.updateTableView(fetchedMessages: fetchedMessages)

                }

        }

    }

    
}

