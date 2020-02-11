//
//  ContentView.swift
//  Random User API
//
//  Created by Hitesh Choudhary on 23/10/19.
//  Copyright © 2019 Raushan jha. All rights reserved.
//

import SwiftUI
import Combine
struct ContentView: View {
    
    @ObservedObject var contactm = Contact()
    
    var body: some View {
        NavigationView {
            
            List(contactm.contacts.results , id: \.email)
            {
                contact in
                HStack{
                    ImageViewWidget(imageUrl: contact.picture.thumbnail)
                    
                    VStack(alignment: .leading)
                    {
                        Text(contact.name.first).font(.headline)
                        Text(contact.email).font(.subheadline)
                        Text(contact.phone).font(.subheadline)
                    }
                    Spacer()
                }.padding()
            }.navigationBarTitle("Contacts")
            
            
            
            
            
        }
    }
}
//Load images from URL using URLSession:
class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(imageUrl: String) {
        // fetch image data and then call didChange
        guard let url = URL(string: imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.data = data
            }
            
        }.resume()
    }
}

struct ImageViewWidget: View {
    
    @ObservedObject var imageLoader: ImageLoader
    
    init(imageUrl: String) {
        imageLoader = ImageLoader(imageUrl: imageUrl)
    }
    
    var body: some View {
        //Whenever data is available ,it will show the remote image or else it will show static image which we have used.
        Image(uiImage: (imageLoader.data.isEmpty) ? UIImage(named: "user")! : UIImage(data: imageLoader.data)!)
            .resizable()
            .clipShape(Circle())
            .frame(width: 70, height: 70 )
            .clipped()
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

