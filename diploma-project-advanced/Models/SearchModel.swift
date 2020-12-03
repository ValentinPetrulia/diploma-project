//
//  SearchModel.swift
//  diploma-project-advanced
//
//  Created by Валентин Петруля on 8/4/19.
//  Copyright © 2019 Валентин Петруля. All rights reserved.
//

import Foundation

class SearchModel {
    var pageNumber: Int = 1
    var pageSize: Int = 5
    var maxPageSize: Int = 100
    var searchKey: String = "Apple"
    var dataFrom: Date = setFromDate()
    var dataTo: Date = setToDate()
    
    private static func setFromDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "2019-06-22") ?? Date()
    }
    
    private static func setToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "2019-07-11") ?? Date()
    }
    
    func returnDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
