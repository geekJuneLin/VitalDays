//
//  Utils.swift
//  VitalDays
//
//  Created by Junyu Lin on 3/02/20.
//  Copyright © 2020 Junyu Lin. All rights reserved.
//

import UIKit
import Firebase

class Utils{
    
    static var shard: Utils = Utils()
    
    func showError(title: String, _ error: String, _ vc: UIViewController){
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func fetchAvatar(imageView: UIImageView){
        let ref = Storage.storage().reference()
        if let uid = Auth.auth().currentUser?.uid{
            // try load image from local storage first
            let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = docDir.appendingPathComponent("\(uid).jpg")
            
            if let image = UIImage(contentsOfFile: archiveURL.path){
                imageView.image = image
            }else{
                // try to fetch the avatar from firebase storage
                ref.child("Avatars").child(uid).getData(maxSize: 1 * 1024 * 1024) { (data, err) in
                    if let err = err{
                        print(err.localizedDescription)
                        return
                    }else{
                        if let data = data{
                            let image = UIImage(data: data)
                            imageView.image = image
                            
                            // save the avatar to local storage
                            do{
                                try image!.jpegData(compressionQuality: 1)!.write(to: archiveURL)
                            }catch{
                                print("saving avatar with errors!")
                            }
                        }else{
                            print("no data found!")
                        }
                    }
                }
            }
        }
    }
}

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
    
    var selectedDate: Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone?
        return formatter.date(from: self)
    }
}
