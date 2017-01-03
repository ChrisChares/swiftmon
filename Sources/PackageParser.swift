//
//  PackageParser.swift
//  Swiftmon
//
//  Created by Chris Chares on 1/3/17.
//
//

import Foundation

enum PackageError : Error {
    case missingPackage
    case invalidFormat
    case cannotFindPackageName
}
 
struct PackageParser {
    
    let path: String
    
    func parsePackageName() throws  -> String {
        
        let url = URL(fileURLWithPath: "./Package.swift")
        let data = try Data(contentsOf: url)
        guard let string = String(data: data, encoding: .utf8) else {
            throw PackageError.invalidFormat
        }
        
        let scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = CharacterSet.letters.inverted
        var trash: NSString? = nil
        scanner.scanUpTo("name: ", into: &trash)
        scanner.scanString("name: ", into: &trash)
        
        var name: NSString? = nil
        scanner.scanUpTo("\"", into: &name)
        
        guard let _name = name else {
            throw PackageError.cannotFindPackageName
        }
        
        return _name as String
    }
}
