//
//  LoadImageFromUrl.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 21.7.2023.
//

import UIKit


// Create a separate class to handle the URLSession tasks and delegate methods
class UrlLoadingProgress: NSObject, URLSessionDownloadDelegate {

    // Create a URLSession
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()

    // Property to hold the completion handler
    private var completionHandler: ((Data?, Float) -> Void)?

    // Method to load the image from the provided URL
    func loadImage(from urlString: String, completionHandler: @escaping (Data?, Float) -> Void) {
        
        // Check if the image is cached
//        if let image = imageCache.object(forKey: urlString as NSString) {
//            completionHandler(image as! UIImage, 1.0) // Progress is 1.0 as the image is already cached
//            return
//        }
        
        // Check if the received URL string is valid and create a URL
        guard let url = URL(string: urlString) else {
            completionHandler(nil, 0.0)
            return
        }

        
        // Save the completion handler
        self.completionHandler = completionHandler

        // Create a URLRequest with the URL
        let request = URLRequest(url: url)

        // Create a DownloadTask
        let downloadTask = session.downloadTask(with: request)

        // Start the download task
        downloadTask.resume()
    }

    // URLSessionDownloadDelegate methods

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // Calculate the progress as a value between 0.0 and 1.0
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        // Update the progress via the completion handler
        completionHandler?(nil, progress)
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // Move the downloaded file to the cache directory or perform any other actions as needed

        // Load the image from the downloaded file data
        if let data = try? Data(contentsOf: location) {
            // Cache the downloaded image
//            imageCache.setObject(image, forKey: downloadTask.originalRequest?.url?.absoluteString as NSString)

            // Update the progress view to 0.0 after the download is complete
            completionHandler?(data, 1.0)
        }
    }
}
