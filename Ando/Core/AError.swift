//
//  AError.swift
//  Pods
//
//  Created by Alper KARATAŞ on 23/05/2017.
//
//

import Foundation

public struct AError {
    static let Domain = "DownloaderErrorDomain"
    
    public enum Code: Int {
        case WrongURL = -6000
        case ItemCreatingError = -6001
        case ProcessResponseError = -6002
    }
    
    public static func errorWithCode(code: Code, failureReason: String) -> NSError {
        return errorWithCode(code: code.rawValue, failureReason: failureReason)
    }
    
    public static func errorWithCode(code: Int, failureReason: String) -> NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: Domain, code: code, userInfo: userInfo)
    }
    
    static func error(domain: String = AError.Domain, code: Code, failureReason: String) -> NSError {
        return error(domain: domain, code: code.rawValue, failureReason: failureReason)
    }
    
    static func error(domain: String = AError.Domain, code: Int, failureReason: String) -> NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}
