//
//  GenerateRandomChatRooms.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 1.6.2023.
//

import UIKit


    
func randomDate() -> Date {
    let randomTimeInterval = TimeInterval.random(in: 0...100000)
    return Date().addingTimeInterval(randomTimeInterval)
}

func randomTimestamp() -> TimeInterval {
    let currentDate = Date()
    let currentTimestamp = currentDate.timeIntervalSince1970
    let oldestTimestamp: TimeInterval = 1577836800 // Timestamp for January 1, 2020, 00:00:00 UTC
    
    let randomTimeInterval = TimeInterval.random(in: oldestTimestamp...currentTimestamp)
    
    return randomTimeInterval
}

//        let avatarURLs = [
//                     "https://randomuser.me/api/portraits/women/1.jpg",
//                     "https://randomuser.me/api/portraits/men/2.jpg",
//                     "https://randomuser.me/api/portraits/men/3.jpg",
//                     "https://randomuser.me/api/portraits/men/4.jpg",
//                     "https://randomuser.me/api/portraits/women/5.jpg",
//                     "https://randomuser.me/api/portraits/men/6.jpg",
//                     "https://randomuser.me/api/portraits/women/7.jpg",
//                     "https://randomuser.me/api/portraits/men/8.jpg",
//                     "https://randomuser.me/api/portraits/women/9.jpg",
//                     "https://randomuser.me/api/portraits/men/10.jpg",
//                     "https://randomuser.me/api/portraits/women/11.jpg",
//                     "https://randomuser.me/api/portraits/men/12.jpg",
//                     "https://randomuser.me/api/portraits/women/13.jpg",
//                     "https://randomuser.me/api/portraits/men/14.jpg",
//                     "https://randomuser.me/api/portraits/women/15.jpg",
//                     "https://randomuser.me/api/portraits/men/16.jpg",
//                     "https://randomuser.me/api/portraits/women/17.jpg"
//                ]



func generateRandomChatrooms(data: [User]) -> [ChatRoom] {

    let me: User = DataStore.shared.user
    
    let chatroom0 = ChatRoom(id: "\(1111)", usersIds:["\(me.id)", "\(data[0].id)"],messagesIds:[], lastMessage: "Hey, how are you doing?, is it today that we said we should make the social media app on youtube or am I mistaken", unreadCount: 13, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom1 = ChatRoom(id: "\(2222)", usersIds:["\(me.id)", "\(data[1].id)"],messagesIds:[], lastMessage: "Did you see the latest episode? this shloud be pinned first", unreadCount: 0, lastMessageDate: randomTimestamp(),selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom2 = ChatRoom(id: "\(3333)", usersIds:["\(me.id)", "\(data[2].id)"],messagesIds:[], lastMessage: "I have a surprise for you!", unreadCount: 1, lastMessageDate: randomTimestamp(),selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom3 = ChatRoom(id: "\(4444)", usersIds:["\(me.id)", "\(data[3].id)"],messagesIds:[],  lastMessage: "Let's meet up later pinned second.", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom4 = ChatRoom(id: "\(5555)", usersIds:["\(me.id)", "\(data[4].id)"],messagesIds:[], lastMessage: "What are you up to?", unreadCount: 3, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom5 = ChatRoom(id: "\(6666)", usersIds:["\(me.id)", "\(data[5].id)"],messagesIds:[], lastMessage: "I need your help with something.", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom6 = ChatRoom(id: "\(7777)", usersIds:["\(me.id)", "\(data[6].id)"],messagesIds:[], lastMessage: "How was your weekend?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom7 = ChatRoom(id: "\(8888)", usersIds:["\(me.id)", "\(data[7].id)"],messagesIds:[], lastMessage: "Check out this link pinned third.", unreadCount: 1, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom8 = ChatRoom(id: "\(9999)", usersIds:["\(me.id)", "\(data[8].id)"],messagesIds:[], lastMessage: "You won't believe what I just saw.", unreadCount: 2, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom9 = ChatRoom(id: "\(1000)", usersIds:["\(me.id)", "\(data[9].id)"],messagesIds:[], lastMessage: "Are you free today?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom10 = ChatRoom(id: "\(1001)", usersIds:["\(me.id)", "\(data[10].id)"],messagesIds:[], lastMessage: "I miss you.", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom11 = ChatRoom(id: "\(1002)", usersIds:["\(me.id)", "\(data[11].id)"],messagesIds:[], lastMessage: "Can you do me a favor?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
    let chatroom12 = ChatRoom(id: "\(1003)", usersIds:["\(me.id)", "\(data[12].id)"],messagesIds:[], lastMessage: "Did you get my email?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())

        
//        chatroom0.messages = addMessages(chatroom: chatroom0, otherUser: data[0])
//        chatroom1.messages = addMessages(chatroom: chatroom1, otherUser: data[1])
//        chatroom2.messages = addMessages(chatroom: chatroom2, otherUser: data[2])
//        chatroom3.messages = addMessages(chatroom: chatroom3, otherUser: data[3])
//        chatroom4.messages = addMessages(chatroom: chatroom4, otherUser: data[4])
//        chatroom5.messages = addMessages(chatroom: chatroom5, otherUser: data[5])
//        chatroom6.messages = addMessages(chatroom: chatroom6, otherUser: data[6])
//        chatroom7.messages = addMessages(chatroom: chatroom7, otherUser: data[7])
//        chatroom8.messages = addMessages(chatroom: chatroom8, otherUser: data[8])
//        chatroom9.messages = addMessages(chatroom: chatroom9, otherUser: data[9])
//        chatroom10.messages = addMessages(chatroom: chatroom10, otherUser: data[10])
//        chatroom11.messages = addMessages(chatroom: chatroom11, otherUser: data[11])
//        chatroom12.messages = addMessages(chatroom: chatroom12, otherUser: data[12])
    
       let chatRooms: [ChatRoom] = [
            chatroom0,
            chatroom1,
            chatroom2,
            chatroom3,
            chatroom4,
            chatroom5,
            chatroom6,
            chatroom7,
            chatroom8,
            chatroom9,
            chatroom10,
            chatroom11,
            chatroom12
          ]
        return chatRooms
}

func addMessages(chatroom: ChatRoom?, otherUserId: String? ) -> [Message] {
    
    let chatroom = chatroom
//    let currentDate = Date()
//    let currentTimestamp = currentDate.timeIntervalSince1970
    
    //update chat room unreadCount to 0
    //chatroom?.unreadCount = 0
    
    var messages: [Message] = []
    
    let receivedUserId = otherUserId
    
    
    if let unWrappedChatroom = chatroom {
        // update chat room in the previous screen
//        updateCurrentChatroom?.updatedChatroom(chatroom: unWrappedChatroom)
        
   
        
        //fake photo and video size in px and in bytes
        let firstPhoto = PhotoMessage(
            photoUrl: "http://localhost/test-server-images/wide_landscape_steet.jpeg",
            placeHolderUrl: "http://localhost/test-server-images/wide_landscape_steet_placeholder.jpeg",
            photoSizeInPX: ImageSizeInPX(width: 1000, height: 1500),
            photoSizeInBytes: "1 KB"
        )
        

        
        let secondPhoto = PhotoMessage(
            photoUrl: "http://localhost/test-server-images/horizontal_street.jpeg",
            placeHolderUrl: "http://localhost/test-server-images/horizontal_street_placeholder.jpeg",
            photoSizeInPX: ImageSizeInPX(width: 1000, height: 667),
            photoSizeInBytes: "1.2 KB"
        )
        

        
        
        let thirdPhoto = PhotoMessage(
            photoUrl: "http://localhost/test-server-images/landscape_street.jpeg",
            placeHolderUrl: "http://localhost/test-server-images/landscape_street_placeholder.jpeg",
            photoSizeInPX: ImageSizeInPX(width: 608, height: 1136),
            photoSizeInBytes: "1.2 KB"
        )
        

        
        
        let cordinates: Coordinates = Coordinates(latitude: 63.08212227546709, longitude: 21.727480669488912);
        

        
        let videoUrl1 = "http://localhost/test-server-images/white_man_using_the_phone_video.webm"
        
        let firstVideo = VideoMessage(
            videoUrl: videoUrl1,
            videoImageUrl: "http://localhost/test-server-images/black_girl_runing.jpeg",
            videoPlaceHolderUrl: "http://localhost/test-server-images/black_girl_runing_placeholder.jpeg",
            photoSizeInPX: ImageSizeInPX(width: 3360, height: 1775),
            videoSizeInBytes: "47 KB"
            )
        
        let videoUrl2 = "http://localhost/test-server-images/white_man_using_the_phone_video.webm"
        
        let secondVideo = VideoMessage(
            videoUrl: videoUrl2,
            videoImageUrl: "http://localhost/test-server-images/white_man_using_the_phone.jpeg" ,
            videoPlaceHolderUrl: "http://localhost/test-server-images/white_man_using_the_phone_placeholder.jpeg",
            photoSizeInPX: ImageSizeInPX(width: 3360, height: 1775),
            videoSizeInBytes: "35 KB"
        )
        
        
        
        
        // Create a calendar instance
          let calendar = Calendar.current
          
          // Get the current date
          let now = Date()
          
          // Create a date of last month
        let lastMonthDate = calendar.date(byAdding: .year, value: -2, to: now)
          
          // Set the start date as last month
          var currentDate = lastMonthDate
          
          var timestamp: TimeInterval!
        
        
        if let otherUserId = receivedUserId {
            for i in 0...10000 {
                
                if let unWrappedCurrentDate = currentDate {
                     timestamp = unWrappedCurrentDate.timeIntervalSince1970
                    currentDate = calendar.date(byAdding: .hour, value: 1, to: unWrappedCurrentDate) ?? currentDate
//                    print("date: ", getSectionDate(date: timestamp))
                }
                
                if (i == 9500) {
                    messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: nil, photoMessage: firstPhoto, createdAt: timestamp))
                }
                else if (i == 9600) {
                   messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: nil, photoMessage: nil, videoMessage: firstVideo, createdAt: timestamp))
                }
                else if (i == 9700) {
                   messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: "This video is from shutterstock", photoMessage: nil, videoMessage: secondVideo, createdAt: timestamp))
                }
                
                if i == 9800 {
                    messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: nil, audioMessage: "audio_with_id_3C56A9E6-17FD-4C7D-88AC-FCA99B34791D.m4a", createdAt: timestamp))
                }
                else if (i == 9850) {
                    messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: nil, photoMessage: firstPhoto, createdAt: timestamp))
                }
                else if (i == 9999) {
                   messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: nil, photoMessage: nil, videoMessage: firstVideo, createdAt: timestamp))
                }
                else if (i == 9997) {
                   messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: nil, audioMessage: "audio_with_id_3C56A9E6-17FD-4C7D-88AC-FCA99B34791D.m4a", createdAt: timestamp))
                }
               messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, textMessage: "message number \(i)", createdAt: timestamp))
            }
            
           messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: otherUserId, locationMessage: cordinates, createdAt: timestamp))
            
            
            
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: "HI!", createdAt: currentTimeStamp()))
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: "don't you have an enternet", createdAt: currentTimeStamp()))
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: "What is wrong?", createdAt: currentTimeStamp()))
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: "don't you have an enternet", createdAt: currentTimeStamp()))
            
            
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: nil, photoMessage: firstPhoto, createdAt: currentTimeStamp()))
            
            
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: "photo with message test", photoMessage: secondPhoto, createdAt: currentTimeStamp()))
            
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: nil, photoMessage: thirdPhoto, createdAt: currentTimeStamp()))
            
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: "I will send you message on cell phone  asjdlfjals dfljals dflkjalksjd flkjaslkdjf lkajsdlkfj alksjdflk jaslkdjfl kasldkfj laksjdflk jaslkdfj laksjdflk alskdjflkajsdlkf laksjdflk jaslkdfjlkasjdlf jalksdjflkajsdlfj ", createdAt: currentTimeStamp()))
            
            messages.append(Message(id: "\(UUID())", chatroomId: unWrappedChatroom.id, senderId: DataStore.shared.user.id, textMessage: "That's my map", locationMessage: cordinates, createdAt: currentTimeStamp()))
            
        }
    }
    

    return messages
}


struct ChatroomsAndMessages {
    var chatrooms: [ChatRoom]
    var messages: [Message]?
    var messagesWithPhotosOrVideo: [Message]?
}

func getChatroomsWithPhotoMessages(data: [User]) -> [ChatRoom] {
//    let chatRooms = generateRandomChatrooms(data: data)
//
//    // Create an array to store chatrooms with photo messages
//    var chatroomsWithPhotoMessages: [ChatRoom] = []
//
//    // Iterate through each chatroom
//    for chatroom in chatRooms {
//        // Filter messages to get the ones with non-nil photoMessage
//        let photoMessages = chatroom.messages.filter { $0.photoMessage != nil }
//
//        // Check if there are any photo messages in this chatroom
//        if !photoMessages.isEmpty {
//            // Append the chatroom to the result array
//            chatroomsWithPhotoMessages.append(chatroom)
//        }
//    }
//
//    return chatroomsWithPhotoMessages
    
    let chatRooms = generateRandomChatrooms(data: data)
    
    
    // Create an array to store chatrooms with photo messages
    var chatroomsWithPhotoMessages: [ChatRoom] = []
    
    
    // Iterate through each chatroom
    var index = -1
    for chatroom in chatRooms {
        
        index += 1
        // Filter messages to get the ones with non-nil photoMessage
        let messages = addMessages(chatroom: chatroom, otherUserId: "\(data[index].id)")
        
        let photoMessages = messages.filter { $0.photoMessage != nil }
        
        // Check if there are any photo messages in this chatroom
        if !photoMessages.isEmpty {
            // Append the chatroom to the result array
            chatroomsWithPhotoMessages.append(chatroom)
        }
    }
    
    return chatroomsWithPhotoMessages
}

