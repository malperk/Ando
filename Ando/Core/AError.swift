import Foundation

public enum AError {
    public static let Domain = "DownloaderErrorDomain"

    public enum Code: Int, Sendable {
        case WrongURL = -6000
        case ItemCreatingError = -6001
        case ProcessResponseError = -6002
        case InvalidHTTPStatus = -6003
    }

    public static func errorWithCode(code: Code, failureReason: String) -> NSError {
        errorWithCode(code: code.rawValue, failureReason: failureReason)
    }

    public static func errorWithCode(code: Int, failureReason: String) -> NSError {
        error(domain: Domain, code: code, failureReason: failureReason)
    }

    static func error(domain: String = Domain, code: Code, failureReason: String) -> NSError {
        error(domain: domain, code: code.rawValue, failureReason: failureReason)
    }

    static func error(domain: String = Domain, code: Int, failureReason: String) -> NSError {
        NSError(domain: domain, code: code, userInfo: [
            NSLocalizedDescriptionKey: failureReason,
            NSLocalizedFailureReasonErrorKey: failureReason
        ])
    }
}
