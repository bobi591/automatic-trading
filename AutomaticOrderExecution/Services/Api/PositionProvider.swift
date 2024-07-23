//
//  PositionProvider.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 20.07.24.
//

import Foundation

public protocol PositionProvider {
    associatedtype PositionType: Position

    func allPositions() async throws -> [PositionType]
    func specificPosition(ticker: String) async throws -> PositionType

    var positionsUrl: String { get }
}

public extension PositionProvider {
    func allPositionsAsync(completion: @escaping (Result<[any Position], Error>) -> Void) {
        Task {
            do {
                let data = try await allPositions()
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func specificPositionAsync(ticker: String, completion: @escaping (Result<any Position, Error>) -> Void) {
        Task {
            do {
                let data = try await specificPosition(ticker: ticker)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
