//
//  RestUtils.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 20.07.24.
//

import Foundation

/// Utility class to invoke HTTP actions.
public class RestUtils {
    private init() {}

    /// Convert URL in String to URL object.
    /// - Parameter urlString: the URL in String.
    /// - Returns: the URL object.
    private static func parseUrl(urlString: String) throws -> URL {
        guard let url = URL(string: urlString) else {
            throw RestUtilsError.invalidUrl(url: urlString)
        }
        return url
    }

    /// Add headers to URLRequest.
    /// - Parameters:
    ///   - headers: the headers dictionary.
    ///   - request: the request that has to be updated.
    private static func addHeadersToRequest(_ headers: [String: String]?, request: inout URLRequest) {
        if let headers = headers {
            for (headerKey, headerValue) in headers {
                request.addValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
    }

    /// Perform HTTP GET request and return the result decoded into specific type.
    /// - Parameters:
    ///   - urlString: The URL of the endpoint in String format.
    ///   - headers: The headers to include in the HTTP action.
    ///   - completion: Completion handler that will represent a success of failure during the invocation fo the HTTP request.
    public static func get<T: Decodable>(urlString: String, headers: [String: String]? = nil) async throws -> T {
        let url = try parseUrl(urlString: urlString)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.method
        addHeadersToRequest(headers, request: &request)

        print(request.allHTTPHeaderFields!)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw RestUtilsError.responseError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        let decoder = JSONDecoder()
        print(String(decoding: data, as: UTF8.self))
        return try decoder.decode(T.self, from: data)
    }
}

/// Errors specific to the RestUtils class.
public enum RestUtilsError: Error {
    case invalidUrl(url: String)
    case responseEmpty
    case responseError(statusCode: Int)
    case responseDecodingError
}

/// HTTP Method Types with String property.
public struct HTTPMethod {
    public let method: String

    public init(_ method: String) {
        self.method = method.uppercased()
    }
}

extension HTTPMethod {
    public static let get = HTTPMethod("GET")
    public static let post = HTTPMethod("POST")
}
