//
//  Parser.swift
//  Train-App
//
//  Created by Vicki Larkin on 01/02/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import Foundation

protocol Parser {
    func parse(url: String, completion: @escaping ([Any]) -> Void)
}
