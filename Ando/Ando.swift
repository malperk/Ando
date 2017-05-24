//
//  Ando.swift
//  Ando
//
//  Created by Alper KARATAŞ on 23/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

public typealias CompletionBlock = (AResponse) -> Void

public final class Ando {
    static let shared = Ando()
    public init() {}
    public init(type:AType) {
        self.type = type
    }
    

    private var dataTask:URLSessionDataTask? = nil
    var type = AType.image
    public var callback:CompletionBlock? = nil
    
    public var url:String = "" {
        didSet {
            download()
        }
    }
    
    func cancel (){
        dataTask?.cancel()
    }
    
    func download(){
        guard let gUrl = URL(string: url) else {
            let error = AError.error(code: .WrongURL, failureReason: "Your url string:\"\(self.url)\" not a valid url")
            let response = AResponse(error: error, type: self.type)
            callback?(response)
            return
        }
        
        let session = URLSession.shared
        dataTask = session.dataTask(with: gUrl) {data, urlResponse, error in
            let aResponse = self.processResponse(data: data, urlResponse: urlResponse, error: error)
            if let _ = aResponse{
                self.callback?(aResponse!)
            }
        }
        dataTask?.resume()
        
    }
    
    private func processResponse(data:Data?, urlResponse:URLResponse?, error:Error?)->AResponse?{
        if let aError = error as NSError?{
            if aError.code == -999 {
                return nil
            }
           return AResponse.init(error: aError, type: self.type)
        }
        if let aData = data{
            do {
                let item = Item.init(type: self.type)
                return AResponse.init(item: try item.get(aData), type: self.type)
            } catch let error as NSError {
                return AResponse.init(error: error, type: self.type)
            }
        }
        let error = AError.error(code: .ProcessResponseError, failureReason: "Unknown error when processing data from your url string:\"\(self.url)\"")
        return AResponse(error: error, type: self.type)
    }
}
