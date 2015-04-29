//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Long Wang on 2015-04-08.
//  Copyright (c) 2015 Long Wang. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl:NSURL, title:String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}