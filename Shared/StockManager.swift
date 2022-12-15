//
//  StockClient.swift
//  StockBox
//
//  Created by Darien Sandifer on 3/1/21.
//

import Foundation
import Alamofire
import SwiftUI

fileprivate let baseDomain = "https://financialmodelingprep.com"
fileprivate let api = "/api/v3/"


enum Resource: String {
    case quote = "quote/"
    case profile = "profile/"
    case newsList = "stock_news?tickers="
    case mainNewsList = "stock_news"
    case marketSectors = "sectors-performance"
    case symbols = "stock-screener?exchange=nyse,nasdaq&marketCapMoreThan=100000000000"
    case historicalChart = "historical-chart/1min/"
    case marketHours = "market-hours"
}

struct ClientParams {
    fileprivate var parameters: [String: String] = [:]
    
    ///Adds a key:value pair to the list of parameters
    mutating func add(key: String, value: String) -> Void{
        parameters[key] = value
    }
    
    //Returns the list of parameters
    func getParams() -> [String:String]{
        return parameters
    }
}


class StockManager{
    
    @Published var marketSectors: SectorList = []
    @Published var mainHeadlines: String = ""
    
    private var apikey: String? {
        if  let path        = Bundle.main.path(forResource: "apiKeys", ofType: "plist"),
            let xml         = FileManager.default.contents(atPath: path),
            let plist = try? PropertyListDecoder().decode(PropertyList.self, from: xml)
        {
            return plist.stockManagerApiKey
            
        }
        return nil
    }
  
    func getNews(for symbol: String, completionHandler: @escaping (_ result: NewsList) -> Void){
        let reqURL = baseDomain + api + Resource.newsList.rawValue + symbol + "&limit=50&apikey=\(apikey)"
        
        AF.request(reqURL).responseDecodable(of: NewsList.self) { quote in
            guard let data = quote.value else {
                return completionHandler([]) // TODO: return error too
            }
            return completionHandler(data)
        }
    }
    
    func getcompanyProfile(for symbol: String, completionHandler: @escaping (_ result: CompanyProfile?) -> Void){
        let reqURL = baseDomain + api + Resource.profile.rawValue + symbol + "?apikey=\(apikey)"
        AF.request(reqURL).responseDecodable(of: ProfileList.self) { profiles in
            guard let data = profiles.value else {
                return // TODO: return error too
            }
            return completionHandler(data.first)
        }
    }

    
    func getChartPrices(for symbol: String, completionHandler: @escaping (_ result: ChartPrices) -> Void){
        let reqURL = baseDomain + api + Resource.historicalChart.rawValue + symbol + "?apikey=\(apikey)"
        
        AF.request(reqURL).responseDecodable(of: ChartPrices.self) { prices in
            guard let data = prices.value else {
                
                return // TODO: return error too
            }
            return completionHandler(data)
        }
    }
    
    
    func getMainNews(_ completionHandler: @escaping (_ result: String) -> Void){
        let reqURL = baseDomain + api + Resource.mainNewsList.rawValue + "?limit=50&apikey=\(apikey)"
        
        AF.request(reqURL).responseDecodable(of: NewsList.self) { quote in
            guard let data = quote.value else {
                return // TODO: return error too
            }

            let news = data.map({ (headline: CompanyNews) -> String in
                return "$\(headline.symbol) \(headline.title)"
            }).joined(separator: " • ")
            
            completionHandler(news)
        }
    }
    
    func getSymbols(_ completionHandler: @escaping (_ result: QuoteList) -> Void){
        //call this here because its first screen and constantly updated
            print("fetching symbols...")
      
            let reqURL = baseDomain + api + Resource.symbols.rawValue + "&apikey=\(apikey)"
            AF.request(reqURL).responseDecodable(of: SymbolList.self) { symbols in
                guard let data = symbols.value else {
                    print(symbols)
                    return
                }
                
                let tickers = data.map({ (symbol: Symbol) -> String in
                    if(symbol.symbol?.lowercased() == "aaba") {return ""}
                    
                    return symbol.symbol!.uppercased()
                }).joined(separator: ",")
            

                let mapURL = "\(baseDomain)\(api)\(Resource.quote)/\(tickers)?apikey=\(apikey)"
                print(mapURL)
                AF.request(mapURL).responseDecodable(of: QuoteList.self) { quote in
                    guard let mapData = quote.value else {
                        print(quote)
                        return
                    }
                    
                    completionHandler(mapData)
                }
            }
    }

    func getSectors() -> Void {
        let reqURL = baseDomain + api + Resource.marketSectors.rawValue + "?apikey=\(apikey)"
        
        AF.request(reqURL).responseDecodable(of: SectorList.self) { sectors in
            guard let data = sectors.value else {
                print(sectors)
                return
            }
            self.marketSectors = data
        }

    }

    func getQuote(for symbol: String, completionHandler: @escaping (_ result: Quote) -> Void){
        let reqURL = "\(baseDomain)\(api)\(Resource.quote)/\(symbol)?apikey=\(apikey)"
        AF.request(reqURL).responseDecodable(of: Quote.self) { quote in
            guard let data = quote.value else {
                return
            }
//            print(data)
            
        }
    }
    
    func getMarketHours(_ completionHandler: @escaping (_ result: MarketHours) -> Void){
        let reqURL = baseDomain + api + Resource.marketHours.rawValue + "?apikey=\(apikey)"
        AF.request(reqURL).responseDecodable(of: MarketHours.self) { time in
            guard let data = time.value else {
                print(time)
                return
            }
            
            completionHandler(data)
        }
    }

}
