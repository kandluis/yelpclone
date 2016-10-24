//
//  Filters.swift
//  Yelp
//
//  Created by Luis Perez on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

extension Array  {
    var indexedDictionary: [Int: Element] {
        var result: [Int: Element] = [:]
        enumerated().forEach({ result[$0.offset] = $0.element })
        return result
    }
}

class Option {
    var name: String!
    var isOn: Bool!
    
    var code: AnyObject?
    var sortMode: YelpSortMode?
    var distanceMode: RadiusMode?
    
    init (name: String) {
        self.name = name
        self.isOn = false
    }
    
    convenience init(name: String, code: String) {
        self.init(name: name)
        self.code = code as AnyObject?
    }
    
    convenience init(name: String, sortMode: YelpSortMode){
        self.init(name: name)
        self.sortMode = sortMode
    }
    
    convenience init(name: String, distanceMode: RadiusMode){
        self.init(name: name)
        self.distanceMode = distanceMode
    }
}

class Filters {
    var categories: [Int: Option]!
    var distance: [Int: Option]!
    var sortby: [Int: Option]!
    var offeringDeal: [Int: Option]!
    
    init() {
        categories = categoryOptions()
        distance = distanceOptions()
        sortby = sortByOptions()
        offeringDeal = dealOptions()
    }
    
    class func turnAllOff(options: [Int: Option]?) -> Void {
        if let options = options {
            for (_, option) in options {
                option.isOn = false
            }
        }
    }
    
    private func distanceOptions() -> [Int: Option] {
        return [ Option(name: "0.3 Miles", distanceMode: RadiusMode.nearby),
                 Option(name: "1.0 Miles", distanceMode: RadiusMode.mile),
                 Option(name: "5.0 Miles", distanceMode: RadiusMode.longmiles),
                 Option(name: "20.0 Miles", distanceMode: RadiusMode.longermiles)
        ].indexedDictionary
    }
    
    private func sortByOptions() -> [Int: Option] {
        return [ Option(name: "Best Match", sortMode: YelpSortMode.bestMatched),
                 Option(name: "Distance", sortMode: YelpSortMode.distance),
                 Option(name: "Highest Rated", sortMode: YelpSortMode.highestRated)
        ].indexedDictionary
    }
    
    private func dealOptions() -> [Int: Option] {
        return getOptions(names: ["Offering A Deal"])
    }
    
    private func categoryOptions() -> [Int: Option] {
        return yelpCategories().map({(data: [String: String]) -> Option in
            return Option(name: data["name"]!, code: data["code"]!)
        }).indexedDictionary
    }
    
    private func getCodeOptions(info: [(String, String)]) -> [Int: Option] {
        return info.map({(name: String, code: String) -> Option in Option(name: name, code: code)}).indexedDictionary
    }
    
    private func getOptions(names: [String]) -> [Int: Option] {
        return names.map({(name: String) -> Option in Option(name: name)}).indexedDictionary
    }
    
    private func yelpCategories() -> [[String : String]] {
        return  [["name" : "Afghan", "code": "afghani"],
                 ["name" : "African", "code": "african"],
                 ["name" : "American, New", "code": "newamerican"],
                 ["name" : "American, Traditional", "code": "tradamerican"],
                 ["name" : "Arabian", "code": "arabian"],
                 ["name" : "Argentine", "code": "argentine"],
                 ["name" : "Armenian", "code": "armenian"],
                 ["name" : "Asian Fusion", "code": "asianfusion"],
                 ["name" : "Asturian", "code": "asturian"],
                 ["name" : "Australian", "code": "australian"],
                 ["name" : "Austrian", "code": "austrian"],
                 ["name" : "Baguettes", "code": "baguettes"],
                 ["name" : "Bangladeshi", "code": "bangladeshi"],
                 ["name" : "Barbeque", "code": "bbq"],
                 ["name" : "Basque", "code": "basque"],
                 ["name" : "Bavarian", "code": "bavarian"],
                 ["name" : "Beer Garden", "code": "beergarden"],
                 ["name" : "Beer Hall", "code": "beerhall"],
                 ["name" : "Beisl", "code": "beisl"],
                 ["name" : "Belgian", "code": "belgian"],
                 ["name" : "Bistros", "code": "bistros"],
                 ["name" : "Black Sea", "code": "blacksea"],
                 ["name" : "Brasseries", "code": "brasseries"],
                 ["name" : "Brazilian", "code": "brazilian"],
                 ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                 ["name" : "British", "code": "british"],
                 ["name" : "Buffets", "code": "buffets"],
                 ["name" : "Bulgarian", "code": "bulgarian"],
                 ["name" : "Burgers", "code": "burgers"],
                 ["name" : "Burmese", "code": "burmese"],
                 ["name" : "Cafes", "code": "cafes"],
                 ["name" : "Cafeteria", "code": "cafeteria"],
                 ["name" : "Cajun/Creole", "code": "cajun"],
                 ["name" : "Cambodian", "code": "cambodian"],
                 ["name" : "Canadian", "code": "New)"],
                 ["name" : "Canteen", "code": "canteen"],
                 ["name" : "Caribbean", "code": "caribbean"],
                 ["name" : "Catalan", "code": "catalan"],
                 ["name" : "Chech", "code": "chech"],
                 ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                 ["name" : "Chicken Shop", "code": "chickenshop"],
                 ["name" : "Chicken Wings", "code": "chicken_wings"],
                 ["name" : "Chilean", "code": "chilean"],
                 ["name" : "Chinese", "code": "chinese"],
                 ["name" : "Comfort Food", "code": "comfortfood"],
                 ["name" : "Corsican", "code": "corsican"],
                 ["name" : "Creperies", "code": "creperies"],
                 ["name" : "Cuban", "code": "cuban"],
                 ["name" : "Curry Sausage", "code": "currysausage"],
                 ["name" : "Cypriot", "code": "cypriot"],
                 ["name" : "Czech", "code": "czech"],
                 ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                 ["name" : "Danish", "code": "danish"],
                 ["name" : "Delis", "code": "delis"],
                 ["name" : "Diners", "code": "diners"],
                 ["name" : "Dumplings", "code": "dumplings"],
                 ["name" : "Eastern European", "code": "eastern_european"],
                 ["name" : "Ethiopian", "code": "ethiopian"],
                 ["name" : "Fast Food", "code": "hotdogs"],
                 ["name" : "Filipino", "code": "filipino"],
                 ["name" : "Fish & Chips", "code": "fishnchips"],
                 ["name" : "Fondue", "code": "fondue"],
                 ["name" : "Food Court", "code": "food_court"],
                 ["name" : "Food Stands", "code": "foodstands"],
                 ["name" : "French", "code": "french"],
                 ["name" : "French Southwest", "code": "sud_ouest"],
                 ["name" : "Galician", "code": "galician"],
                 ["name" : "Gastropubs", "code": "gastropubs"],
                 ["name" : "Georgian", "code": "georgian"],
                 ["name" : "German", "code": "german"],
                 ["name" : "Giblets", "code": "giblets"],
                 ["name" : "Gluten-Free", "code": "gluten_free"],
                 ["name" : "Greek", "code": "greek"],
                 ["name" : "Halal", "code": "halal"],
                 ["name" : "Hawaiian", "code": "hawaiian"],
                 ["name" : "Heuriger", "code": "heuriger"],
                 ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                 ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                 ["name" : "Hot Dogs", "code": "hotdog"],
                 ["name" : "Hot Pot", "code": "hotpot"],
                 ["name" : "Hungarian", "code": "hungarian"],
                 ["name" : "Iberian", "code": "iberian"],
                 ["name" : "Indian", "code": "indpak"],
                 ["name" : "Indonesian", "code": "indonesian"],
                 ["name" : "International", "code": "international"],
                 ["name" : "Irish", "code": "irish"],
                 ["name" : "Island Pub", "code": "island_pub"],
                 ["name" : "Israeli", "code": "israeli"],
                 ["name" : "Italian", "code": "italian"],
                 ["name" : "Japanese", "code": "japanese"],
                 ["name" : "Jewish", "code": "jewish"],
                 ["name" : "Kebab", "code": "kebab"],
                 ["name" : "Korean", "code": "korean"],
                 ["name" : "Kosher", "code": "kosher"],
                 ["name" : "Kurdish", "code": "kurdish"],
                 ["name" : "Laos", "code": "laos"],
                 ["name" : "Laotian", "code": "laotian"],
                 ["name" : "Latin American", "code": "latin"],
                 ["name" : "Live/Raw Food", "code": "raw_food"],
                 ["name" : "Lyonnais", "code": "lyonnais"],
                 ["name" : "Malaysian", "code": "malaysian"],
                 ["name" : "Meatballs", "code": "meatballs"],
                 ["name" : "Mediterranean", "code": "mediterranean"],
                 ["name" : "Mexican", "code": "mexican"],
                 ["name" : "Middle Eastern", "code": "mideastern"],
                 ["name" : "Milk Bars", "code": "milkbars"],
                 ["name" : "Modern Australian", "code": "modern_australian"],
                 ["name" : "Modern European", "code": "modern_european"],
                 ["name" : "Mongolian", "code": "mongolian"],
                 ["name" : "Moroccan", "code": "moroccan"],
                 ["name" : "New Zealand", "code": "newzealand"],
                 ["name" : "Night Food", "code": "nightfood"],
                 ["name" : "Norcinerie", "code": "norcinerie"],
                 ["name" : "Open Sandwiches", "code": "opensandwiches"],
                 ["name" : "Oriental", "code": "oriental"],
                 ["name" : "Pakistani", "code": "pakistani"],
                 ["name" : "Parent Cafes", "code": "eltern_cafes"],
                 ["name" : "Parma", "code": "parma"],
                 ["name" : "Persian/Iranian", "code": "persian"],
                 ["name" : "Peruvian", "code": "peruvian"],
                 ["name" : "Pita", "code": "pita"],
                 ["name" : "Pizza", "code": "pizza"],
                 ["name" : "Polish", "code": "polish"],
                 ["name" : "Portuguese", "code": "portuguese"],
                 ["name" : "Potatoes", "code": "potatoes"],
                 ["name" : "Poutineries", "code": "poutineries"],
                 ["name" : "Pub Food", "code": "pubfood"],
                 ["name" : "Rice", "code": "riceshop"],
                 ["name" : "Romanian", "code": "romanian"],
                 ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                 ["name" : "Rumanian", "code": "rumanian"],
                 ["name" : "Russian", "code": "russian"],
                 ["name" : "Salad", "code": "salad"],
                 ["name" : "Sandwiches", "code": "sandwiches"],
                 ["name" : "Scandinavian", "code": "scandinavian"],
                 ["name" : "Scottish", "code": "scottish"],
                 ["name" : "Seafood", "code": "seafood"],
                 ["name" : "Serbo Croatian", "code": "serbocroatian"],
                 ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                 ["name" : "Singaporean", "code": "singaporean"],
                 ["name" : "Slovakian", "code": "slovakian"],
                 ["name" : "Soul Food", "code": "soulfood"],
                 ["name" : "Soup", "code": "soup"],
                 ["name" : "Southern", "code": "southern"],
                 ["name" : "Spanish", "code": "spanish"],
                 ["name" : "Steakhouses", "code": "steak"],
                 ["name" : "Sushi Bars", "code": "sushi"],
                 ["name" : "Swabian", "code": "swabian"],
                 ["name" : "Swedish", "code": "swedish"],
                 ["name" : "Swiss Food", "code": "swissfood"],
                 ["name" : "Tabernas", "code": "tabernas"],
                 ["name" : "Taiwanese", "code": "taiwanese"],
                 ["name" : "Tapas Bars", "code": "tapas"],
                 ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                 ["name" : "Tex-Mex", "code": "tex-mex"],
                 ["name" : "Thai", "code": "thai"],
                 ["name" : "Traditional Norwegian", "code": "norwegian"],
                 ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                 ["name" : "Trattorie", "code": "trattorie"],
                 ["name" : "Turkish", "code": "turkish"],
                 ["name" : "Ukrainian", "code": "ukrainian"],
                 ["name" : "Uzbek", "code": "uzbek"],
                 ["name" : "Vegan", "code": "vegan"],
                 ["name" : "Vegetarian", "code": "vegetarian"],
                 ["name" : "Venison", "code": "venison"],
                 ["name" : "Vietnamese", "code": "vietnamese"],
                 ["name" : "Wok", "code": "wok"],
                 ["name" : "Wraps", "code": "wraps"],
                 ["name" : "Yugoslav", "code": "yugoslav"]];
    }
}
