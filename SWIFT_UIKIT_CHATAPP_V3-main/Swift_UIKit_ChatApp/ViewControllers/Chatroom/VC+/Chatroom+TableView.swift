//
//  Chatroom+tableView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.8.2023.
//

import UIKit
 
extension ChatroomVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func setupSectionsAndMessages() {
        // Sort messages by createdAt timestamp
        let sortedMessages = messages.sorted { $0.createdAt > $1.createdAt }

        // Group messages by date
        let groupedMessages = Dictionary(grouping: sortedMessages) { (message) -> String in
            getSectionDateString(date: message.createdAt)
        }
        // Store section titles in an array
        sections = Array(groupedMessages.keys).sorted { (dateString1, dateString2) in
            let date1 = convertStringToDate(dateString1)
            let date2 = convertStringToDate(dateString2)
            return date1 > date2
        }
        // Store messages under each section title
        sectionMessages = groupedMessages
        
        //sectionMessages = Dictionary(uniqueKeysWithValues: sectionMessages.reversed())
    }
    
    
    
    

    func configureTableView () {
        // Create a table view
        tableView = FetchFromBotomTableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)

        // one cell
        tableView.register(ChatroomCell.self, forCellReuseIdentifier: ChatroomCell.identifier)

        // seperate cells
        tableView.register(PhotoMessageCell.self, forCellReuseIdentifier: PhotoMessageCell.identifier)
        tableView.register(TextMessageCell.self, forCellReuseIdentifier: TextMessageCell.identifier)
        tableView.register(PhotoWithTextMessageCell.self, forCellReuseIdentifier: PhotoWithTextMessageCell.identifier)
        tableView.register(LocationMessageCell.self, forCellReuseIdentifier: LocationMessageCell.identifier)
        tableView.register(CTRMLocationWithTextCell.self, forCellReuseIdentifier: CTRMLocationWithTextCell.identifier)
        tableView.register(CTRMAudioMessageCell.self, forCellReuseIdentifier: CTRMAudioMessageCell.identifier)

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false

        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 45))
        footerView.backgroundColor = .clear

        tableView.tableHeaderView = footerView

            let constraints = [
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                //tableView.bottomAnchor.constraint(equalTo: optionView.topAnchor) <- moved to option function,
            ]
            NSLayoutConstraint.activate(constraints)

        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none

//        tableView.rowHeight = UITableView.automaticDimension
        setupSectionsAndMessages()

    }



    // MARK: - UITableViewDelegate and UITableViewDataSource methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
//        print("messages in section: ",sectionMessages[sectionTitle] ?? "no messages")
        return sectionMessages[sectionTitle]?.count ?? 0
    }


    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = .clear
        sectionView.isUserInteractionEnabled = false
        let containerView = UIView()
        sectionView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 20 * 0.40
        containerView.clipsToBounds = true

        let blur = AddBlur(toView: containerView, blurStyle: .dark)

        containerView.alpha = 0.4
        containerView.addSubview(blur)



        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: sectionView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor),
            //containerView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 10),
            //containerView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor,constant: -10)
//            containerView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor, constant: -22)
        ])

            let titleLabel = UILabel()
            titleLabel.textColor = .white
            titleLabel.text = sections[section]
            titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            sectionView.addSubview(titleLabel)

            // Add constraints to position the titleLabel within the headerView
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
                titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
            ])


            sectionView.transform = CGAffineTransform(scaleX: 1, y: -1)

            return sectionView
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMAudioMessageCell.identifier, for: indexPath) as! CTRMAudioMessageCell

//        let sectionTitle = sections[indexPath.section]
//
//        guard let messagesInSection = sectionMessages[sectionTitle] else { return UITableView.automaticDimension }
//            let message = messagesInSection[indexPath.row]
//
//            if let _ = message.locationMessage { // only location
//                return CGFloat(196)
//            }
//
//        else {
//            return UITableView.automaticDimension
//        }
        
        return UITableView.automaticDimension
//        return 100

    }


    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return []
    }


    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }




}
