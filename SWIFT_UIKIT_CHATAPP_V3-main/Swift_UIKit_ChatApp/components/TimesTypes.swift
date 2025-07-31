//
//  File.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 31.5.2023.
//

import UIKit

    
func getLastMessageTime(received_timestamp: TimeInterval) -> String {
    
    let converted_to_date = Date(timeIntervalSince1970: received_timestamp)
    
     var targetDate: Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: converted_to_date)
            //components.hour = 9 // Set the desired hour
            //components.minute = 30 // Set the desired minute
            return calendar.date(from: components)!
        }
        
   
        var isToday: Bool {
            let calendar = Calendar.current
            return calendar.isDateInToday(targetDate)
        }
    
        
        
         var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter
        }
        
         var formattedDateTime: String {
            let calendar = Calendar.current
            
            if isToday {
                //print("its today date: ", dateFormatter.string(from: targetDate))
                return dateFormatter.string(from: targetDate)
            } else if calendar.isDate(targetDate, equalTo: Date(), toGranularity: .weekOfYear) {
                let dayOfWeek = calendar.component(.weekday, from: targetDate)
                //print("its days or weeks ago: ", calendar.weekdaySymbols[dayOfWeek - 1])
                return calendar.weekdaySymbols[dayOfWeek - 1]
            } else {
                let formatter = DateFormatter()
                //formatter.dateStyle = .short
                formatter.dateFormat = "d.M.yyyy"
//                    formatter.timeStyle = .none
//                    print("target date: ", targetDate)
//                    print("its months or years ago: ", formatter.string(from: targetDate))
                return formatter.string(from: targetDate).replacingOccurrences(of: "/", with: ".")
            }
        }
    
    return formattedDateTime;
}






func getLastSeenDate(received_date: Date) -> String {
     var targetDate: Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: received_date)
            //components.hour = 9 // Set the desired hour
            //components.minute = 30 // Set the desired minute
            return calendar.date(from: components)!
        }
        
        var isToday: Bool {
            let calendar = Calendar.current
            return calendar.isDateInToday(targetDate)
        }
        
         var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter
        }
        
         var formattedDateTime: String {
            let calendar = Calendar.current
            
            if isToday {
                return Language.last_seen + " " + String(dateFormatter.string(from: targetDate)).replacingOccurrences(of: ":", with: ".")
            } else if calendar.isDate(targetDate, equalTo: Date(), toGranularity: .weekOfYear) {
                let dayOfWeek = calendar.component(.weekday, from: targetDate)
                //return calendar.weekdaySymbols[dayOfWeek - 1]
                return Language.last_seen + " " + String(calendar.weekdaySymbols[dayOfWeek - 1])
            } else {
                let formatter = DateFormatter()
//                    formatter.dateStyle = .short
                formatter.timeStyle = .none
                formatter.dateFormat = "d.M.yyyy"
                //return formatter.string(from: targetDate)
                return Language.last_seen + " " + String(formatter.string(from: targetDate)).replacingOccurrences(of: "/", with: ".")
            }
        }
    
    return formattedDateTime;
}



    
func currentTimeStamp() -> TimeInterval {
        let currentDate = Date()
        let timestamp = currentDate.timeIntervalSince1970
        return timestamp
    }



    
 func getSectionDateString (date: TimeInterval) -> String {
        let calendar = Calendar.current
        let messageDate = Date(timeIntervalSince1970: date)
        
        if calendar.isDateInToday(messageDate) {
            return "Today"
        } else if calendar.isDateInYesterday(messageDate) {
            return "Yesterday"
        } else if calendar.isDate(messageDate, equalTo: Date(), toGranularity: .weekOfYear) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: messageDate)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d.M.yyyy"
            return dateFormatter.string(from: messageDate)
            
        }
//            else if calendar.isDate(messageDate, equalTo: Date(), toGranularity: .mon) {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "d.M.yyyy"
//                return dateFormatter.string(from: messageDate)
//            }
    }


//func getSectionDate (date: TimeInterval) -> SectionDate {
//       let calendar = Calendar.current
//       let messageDate = Date(timeIntervalSince1970: date)
//       
//       if calendar.isDateInToday(messageDate) {
//           return SectionDate(sectionTitle: "Today", timestamp: date)
//       } else if calendar.isDateInYesterday(messageDate) {
//           return SectionDate(sectionTitle: "Yesterday", timestamp: date)
//       } else if calendar.isDate(messageDate, equalTo: Date(), toGranularity: .weekOfYear) {
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = "EEEE"
//           return SectionDate(sectionTitle: dateFormatter.string(from: messageDate), timestamp: date)
//       } else {
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = "d.M.yyyy"
//           return SectionDate(sectionTitle: dateFormatter.string(from: messageDate), timestamp: date)
//           
//       }
//
//   }
    
    func getTimeStampTime(date: TimeInterval) -> String {
        
        
        let converted_to_date = Date(timeIntervalSince1970: date)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: converted_to_date)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        if let  targetDate = calendar.date(from: components) {
            return String(formatter.string(from: targetDate))
        } else {
            return ""
        }
        //components.hour = 9 // Set the desired hour
        //components.minute = 30 // Set the desired minute
        
    }

    
    func convertStringToDate(_ dateString: String) -> Date {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        
        let weekdays = calendar.weekdaySymbols.map { $0.lowercased() }
        
        if dateString.lowercased() == "today" {
            return calendar.startOfDay(for: Date())
        } else if dateString.lowercased() == "yesterday" {
            return calendar.date(byAdding: .day, value: -1, to: Date())!
        } else if let index = weekdays.firstIndex(of: dateString.lowercased()) {
    //        let currentWeekday = calendar.component(.weekday, from: Date())
    //        let daysDifference = currentWeekday
    //        print("days: ", daysDifference)
    //        let date = calendar.date(byAdding: .day, value: -daysDifference, to: Date())!
            let currentDate = Date()
            let currentWeekday = calendar.component(.weekday, from: currentDate)
            let daysToSubtract = (currentWeekday + 5 - (index)) % 7 + 1
            let date = calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate)!
            print(dateFormatter.string(from: date))
            return date
            
        } else {
            return dateFormatter.date(from: dateString)!
        }
    }
    //
    func lastWeekday(_ weekday: String) -> Date {
        let calendar = Calendar.current
        let weekdays = calendar.weekdaySymbols.map { $0.lowercased() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"

        let index = weekdays.firstIndex(of: weekday.lowercased())!
        let currentDate = Date()
        let currentWeekday = calendar.component(.weekday, from: currentDate)
        let daysToSubtract = (currentWeekday + 5 - (index)) % 7 + 1
        let date = calendar.date(byAdding: .day, value: -daysToSubtract, to: currentDate)!
    //    print(dateFormatter.string(from: date))
        return date
    }

