//
//  ContactModel.swift
//  Random User API
//
//  Created by Hitesh Choudhary on 23/10/19.
//  Copyright © 2019 Raushan jha. All rights reserved.
//

import Foundation

struct resultsmodel: Decodable {
    
    var results:[resultDetails]
}

struct resultDetails: Decodable {
    var email: String
    var phone: String
    var name: nameModel
    var picture: picturemodel
}
struct nameModel: Decodable
{
    let first: String
    let last : String
}

struct picturemodel : Decodable
{
    let thumbnail : String
}

