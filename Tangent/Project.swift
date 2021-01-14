//
//  Project.swift
//  Tangent
//
//  Created by Shaurya Pathak on 9/3/20.
//  Copyright © 2020 Tangent. All rights reserved.
//

import Foundation

class Project {
    
    var projectName : String!
    var projectInstructions : String!
    var memberArray : [teamMember] = []
    var dueDate : String!
    var id : String!
    
}

class teamMember    {
    var memberName : String!
    var groupNumber : Int!
}
