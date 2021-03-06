//
//  PetHandler.swift
//  pets
//
//  Created by Matheus Silva on 01/03/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import Foundation

enum PetLoadResponse: Error {
    case success(answer: Pets)
    case error(description: String)
}

enum PetOneResponse: Error {
    case success(answer: Pet)
    case error(description: String)
}

class PetHandler {
    public static let BASE_URL:String = "\(ENV.server)/pet"
    
    static func create(pet: Pet, withCompletion completion: @escaping (PetOneResponse) -> Void) {
        APIRequests.postRequest(url: BASE_URL, params: pet.dictionaryRepresentation, decodableType: ServerAnswer<Pets>.self) {
            (response) in
            switch response {
            case .result(let answer as ServerAnswer<Pet>):
                if (answer.success ?? false) {
                    if let pet = answer.content {
                        completion(PetOneResponse.success(answer: pet))
                    } else {
                        completion(PetOneResponse.error(description: (String(describing: "Not have pet"))))
                    }
                    
                } else {
                    completion(PetOneResponse.error(description: (String(describing: answer.message))))
                }
            case .error(let error):
                completion(PetOneResponse.error(description: error.localizedDescription))
            default:
                completion(PetOneResponse.error(description: "Error to convert data"))
            }
        }
    }
    static func getAll(userID: String, withCompletion completion: @escaping (PetLoadResponse) -> Void) {
        APIRequests
            .getRequest(
                url: "\(BASE_URL)/all/user/\(userID)",
                decodableType: ServerAnswer<Pets>.self,
                header: ENV.token
            ) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<Pets>):
                if (answer.success ?? false) {
                    let pets = answer.content ?? []
                    completion(PetLoadResponse.success(answer: pets))
                } else {
                    completion(PetLoadResponse.error(description: answer.message ?? ""))
                }
            case .error(let error):
                completion(PetLoadResponse.error(description: error.localizedDescription))
            default:
                completion(PetLoadResponse.error(description: "Error to convert data"))
            }
        }
    }
    static func getOne(id: String, withCompletion
        completion: (PetOneResponse) -> Void) {
        PetOneResponse.error(description: "Not implementation")
    }
    static func update(pet: Pet, withCompletion completion: (PetOneResponse) -> Void) {
        PetOneResponse.error(description: "Not implementation")
    }
    public static func delete(id: Int, completion: @escaping (PetOneResponse) -> Void) {
        PetOneResponse.error(description: "Not implementation")
    }
}
