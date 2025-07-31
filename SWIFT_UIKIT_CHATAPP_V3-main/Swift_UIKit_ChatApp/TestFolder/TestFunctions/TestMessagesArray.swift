//
//  TestMessagesArray.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 5.8.2023.
//

import UIKit



struct UnNestedMessage: Codable {
    var id: String
    var chatroomId: String
    var senderId: String // user id
    //var receiver: User
//    var messageType: MessageType? <- not included
    var textMessage: String?
    var audioMessage: String?
//    var photoMessage: PhotoMessage?
//    var videoMessage: VideoMessage?
    var fileMessage: String?
//    var locationMessage: Coordinates?
//    var replyMessage: MessageReply?
    var reactions: [String]? // reaction ids
    var isSelected: Bool = false
    var isSent: Bool = false
    var isRead: Bool = false
    var isEdited: Bool = false
    var isDeleted: Bool = false
    var sentAt: TimeInterval?
    var readAt: TimeInterval?
    var editedAt: TimeInterval?
    var deletedAt: TimeInterval?
    var mentions: [String]? // user ids
//    var coordinates: Coordinates?
    var hashtags: [String]?
    var isFlagged: Bool = false
    var flaggedAt: TimeInterval?
    var createdAt: TimeInterval
}


let thirdPhoto = PhotoMessage(
    photoUrl: "http://localhost/test-server-images/landscape_street.jpeg",
    placeHolderUrl: "http://localhost/test-server-images/landscape_street_placeholder.jpeg",
    photoSizeInPX: ImageSizeInPX(width: 608, height: 1136),
    photoSizeInBytes: "1.2 KB"
)



let firstVideo = VideoMessage(
    videoUrl: "http://localhost/test-server-images/white_man_using_the_phone_video.webm",
    videoImageUrl: "http://localhost/test-server-images/black_girl_runing.jpeg",
    videoPlaceHolderUrl: "http://localhost/test-server-images/black_girl_runing_placeholder.jpeg",
    photoSizeInPX: ImageSizeInPX(width: 3360, height: 1775),
    videoSizeInBytes: "47 KB"
    )

let cordinates: Coordinates = Coordinates(latitude: 63.08212227546709, longitude: 21.727480669488912);



func forLoopMessagesWithoutNestedArray() -> [UnNestedMessage] {
    
    var unNestedMessageArray: [UnNestedMessage] = []
    for i in 0..<10000 {
        unNestedMessageArray.append(UnNestedMessage(id: "\(UUID())", chatroomId: "\(UUID())", senderId: "DataStore.shared.user.id", textMessage: "That's my map \(i)", createdAt: currentTimeStamp()))
    }
    
    return unNestedMessageArray
}

func forLoopPhotoMessageArray() -> [PhotoMessage] {
    
    var array: [PhotoMessage] = []
    for _ in 0..<10000 {
        array.append(thirdPhoto)
    }
    
    return array
}

func forLoopVideoMessageArray() -> [VideoMessage] {
    
    var array: [VideoMessage] = []
    for _ in 0..<10000 {
        array.append(firstVideo)
    }
    
    return array
}

func forLoopCoordinatesMessageArray() -> [Coordinates] {
    
    var array: [Coordinates] = []
    for _ in 0..<10000 {
        array.append(cordinates)
    }
    
    return array
}

func forLoopMessagesWithNestedArries() -> [Message] {
 
    var nestedMessageArray: [Message] = []
    for i in 0..<10000 {
        nestedMessageArray.append(Message(id: "\(UUID())", chatroomId: "\(UUID())", senderId: "DataStore.shared.user.id", textMessage: "That's my map \(i)", photoMessage: thirdPhoto, videoMessage: firstVideo, locationMessage: cordinates, createdAt: currentTimeStamp()))
    }
    
    return nestedMessageArray
    
}

let messagesFileName = "messages.json"

func saveMessagesWithNestedArries() {
    let messages = forLoopMessagesWithNestedArries()
    
    let startTime = Date()
    saveMessagesToDisk(messages, fileName: "messages.json", folderName: "Test")
    let endTime = Date()
    
    let timeElapsed = endTime.timeIntervalSince(startTime)
    print("saving time spent: ", timeElapsed)
}


func saveMessagesWihoutNestedArries() {
//    let messages = forLoopMessagesWithoutNestedArray()
//    let photos = forLoopPhotoMessageArray()
//    let videos = forLoopVideoMessageArray()
//    let coordinates = forLoopCoordinatesMessageArray()
    
    let startTime = Date()
//      savePhotoToDiskUnNested(thirdPhoto, fileName: "photo", folderName: "Test")
//    let photoObject = readPhotoFromDisk(fileName: "photo", folderName: "Test")
//    print("photo: ", photoObject?.photoUrl ?? "nil")
//    messagesToDiskUnNested(messages, fileName: "messages.json", folderName: "Test")
//    photosToDiskUnNested(photos, fileName: "photos.json", folderName: "Test")
//    videosToDisk(videos, fileName: "videos.json", folderName: "Test")
//    coordinatesToDisk(coordinates, fileName: "coordinates.json", folderName: "Test")
    let endTime = Date()
    
    let timeElapsed = endTime.timeIntervalSince(startTime)
    print("saving time spent: ", timeElapsed)
}

func SaveMessagesToDiskTest() {
    
    //saveMessagesWithNestedArries()
    saveMessagesWihoutNestedArries()
    
}




func getDirectoryURLTest(folderName: String) -> URL? {
    let fileManager = FileManager.default
    
    // Get the app's Documents directory
    guard let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
    }

    // Append a folder name for cached Messages
    let cachedMessagesFolderName = folderName
    let cachedMessagesDirectoryURL = documentsDirectoryURL.appendingPathComponent(cachedMessagesFolderName)

    do {
        // Create the directory if it doesn't exist
        try fileManager.createDirectory(at: cachedMessagesDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        return cachedMessagesDirectoryURL
    } catch {
        print("Error in creating cached messages directory: \(error)")
        return nil
    }
}




// Step 2: Save the serialized data to a file on disk
func messagesToDiskUnNested(_ messages: [UnNestedMessage], fileName: String, folderName: String) {
    
    guard let cachedMessagesDirectoryURL = getDirectoryURLTest(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return
    }
    
    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)

    
    do {
        let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
        let data = try encoder.encode(messages)
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        print("messages successfully saved, ")
    } catch {
        print(error)
    }
}



// Step 2: Save the serialized data to a file on disk
func photosToDiskUnNested(_ photos: [PhotoMessage], fileName: String, folderName: String) {
    
    guard let cachedMessagesDirectoryURL = getDirectoryURLTest(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return
    }
    
    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)

    
    do {
        let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
        let data = try encoder.encode(photos)
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        print("messages successfully saved, ")
    } catch {
        print(error)
    }
}

// Step 2: Save the serialized data to a file on disk
func videosToDisk(_ videos: [VideoMessage], fileName: String, folderName: String) {
    
    guard let cachedMessagesDirectoryURL = getDirectoryURLTest(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return
    }
    
    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)

    
    do {
        let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
        let data = try encoder.encode(videos)
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        print("messages successfully saved, ")
    } catch {
        print(error)
    }
}

// Step 2: Save the serialized data to a file on disk
func coordinatesToDisk(_ coordinates: [Coordinates], fileName: String, folderName: String) {
    
    guard let cachedMessagesDirectoryURL = getDirectoryURLTest(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return
    }
    
    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)

    
    do {
        let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
        let data = try encoder.encode(coordinates)
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        print("messages successfully saved, ")
    } catch {
        print(error)
    }
}



func readPhotoFromDisk(fileName: String, folderName: String) -> PhotoMessage? {

    guard let cachedMessagesDirectoryURL = getDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return nil
    }

    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)

    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let photoMessage = try decoder.decode(PhotoMessage.self, from: data)
        print("found saved messages")
        return photoMessage
    } catch {
        print(error)
    }


    return nil
}


func savePhotoToDiskUnNested(_ photo: PhotoMessage, fileName: String, folderName: String) {
    
    guard let cachedMessagesDirectoryURL = getDirectoryURLTest(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return
    }
    
    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)

    
    do {
        let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
        let data = try encoder.encode(photo)
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        print("messages successfully saved, ")
    } catch {
        print(error)
    }
}
