//
//  CompanyProfile.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//
import Foundation

typealias ProfileList = [CompanyProfile]
typealias NewsList = [CompanyNews]


// MARK: - CompanyProfile
struct CompanyProfile: Codable, Identifiable {
    let id = UUID()
//    var symbol: String = ""
//    var price = 0.0, beta: Double = 0.0
//    var volAvg = 0, mktCap: Int = 0
//    var lastDiv: Double = 0.0
//    var range: String = ""
//    var changes: Double = 0.0
//    var companyName = "", currency = "", cik = "", isin: String = ""
//    var cusip = "", exchange = "", exchangeShortName = "", industry: String = ""
//    var website: String = ""
    var description = ""
//    var ceo = ""
//    var sector = ""
//    var country: String = ""
//    var fullTimeEmployees = ""
//    var phone = ""
//    var address = ""
//    var city: String = ""
//    var state = "", zip: String = ""
//    var dcfDiff = 0.0, dcf: Double = 0.0
//    var image: String = ""
//    var ipoDate: String = ""
//    var defaultImage = false, isEtf = false, isActivelyTrading: Bool = false
}


// MARK: - CompanyNews
struct CompanyNews: Codable, Identifiable {
    let id = UUID()
    var symbol = "", publishedDate = "", title: String = ""
    var image: String = ""
    var site = "", text: String = ""
    var url: String = ""
    
    public func stringDate() -> String {
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set publishedDate Format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // Convert String to Date
        let currentDate = dateFormatter.date(from: publishedDate)
    

        let newFormatter = RelativeDateTimeFormatter()
        newFormatter.dateTimeStyle = .named
        newFormatter.unitsStyle = .full
        
        let now = Date()
        let newDate = newFormatter.localizedString(for: currentDate!, relativeTo: now)
        
        return newDate
    }
    
//    public func relativeDate(dateStyle: RelativeDateTimeFormatter.DateTimeStyle?, unitStyle: RelativeDateTimeFormatter.UnitsStyle?) -> String{
//        let formatter = RelativeDateTimeFormatter()
//        
//        formatter.dateTimeStyle = dateStyle ?? .named
//        formatter.unitsStyle = unitStyle ?? .full
//        
//        
//        let currentDate = Date()
//        let newDate = formatter.localizedString(for: publishedDate, relativeTo: currentDate)
//        return newDate
//    }

}
