//
//  ViewController.swift
//  ThreadingProject
//
//  Created by Zeynep Bayrak Demirel on 31.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let urlStrings = ["https://www.highreshdwallpapers.com/wp-content/uploads/2014/08/Beautiful-Grassy-Scene.jpg","https://www.highreshdwallpapers.com/wp-content/uploads/2014/08/Send-Down-From-Above-Windows-Logo.jpg"]
    var data = Data()
    var tracker = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //an object that manages the execution of tasks serially or concurrently(eş zamanlı) on your app's main thread or on a background thread.
        DispatchQueue.global().async { //background threade global ile alıyorum manuel olarak.
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) //URLyi veriye çeviriyor.background thread te yapmalıyım.
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)//bunu main threadte yapmalıyım.bu kullanıcı arayüzüyle ilgili bir işlem.
            }
        }
        
       
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeImage))

    }

    @objc func changeImage () {
        
        if tracker == 0 {
            tracker += 1
        }else {
            tracker -= 1
        }
        
        DispatchQueue.global().async { //background threade global ile alıyorum manuel olarak.
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) //URLyi veriye çeviriyor.background thread te yapmalıyım.
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)//bunu main threadte yapmalıyım.bu kullanıcı arayüzüyle ilgili bir işlem.
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Threaing Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }

}

