//
//  Adresses.swift
//  FlowerGarden
//
//  Created by 김두원 on 2022/10/06.
//

import Foundation

// MARK: - Addresses
struct Addresses: Codable {
    let addresses: [Address]
}

// MARK: - Address
struct Address: Codable {
    let x, y: String
}
