//
//  Document.swift
//  Markdown Viewer
//
//  Created by Xiao Shi on 14/1/18.
//  Copyright © 2018 devbycm. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    var content: String = ""
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let data = contents as? Data else {return}
        self.content = String.init(data: data, encoding: .utf8)!
    }
}

