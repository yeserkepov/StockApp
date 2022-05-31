
import Foundation

enum NetworkError: String, Error {
    case missingURL = "missingURL"
    case missingRequest = "missingRequest"
    case taskError = "taskError"
    case responseError = "responseError"
    case dataError = "dataError"
    case decodeError = "decodeError"
}
