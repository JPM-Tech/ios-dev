//
//  Record.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/17/23.
//

import Foundation

// This has been added to match AirTables format
struct Record: Codable {
    let id: String?
    let createdTime: String?
    let fields: Fields
}
