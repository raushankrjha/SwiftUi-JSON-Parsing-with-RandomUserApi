//
//  Contact.swift
//  Random User API
//
//  Created by Hitesh Choudhary on 23/10/19.
//  Copyright © 2019 Raushan jha. All rights reserved.
//

import Foundation
class Contact: ObservableObject {
    let apiUrl = "https://randomuser.me/api/?results=100"
    
    
    @Published var contacts = resultsmodel(results:[])
    
    
    init() {
        // fetch json and decode and update some array property
        guard let url = URL(string: apiUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            // make sure to check error
            guard let data = data else { return }
            let contacts = try! JSONDecoder().decode(resultsmodel.self, from: data)
            DispatchQueue.main.async {
                self.contacts = contacts
                print(self.contacts.results.debugDescription)
            }
            
            
        }.resume()
    }
    
}
