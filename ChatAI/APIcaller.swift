//
//  APIcaller.swift
//  ChatAI
//
//  Created by sarthak sharma on 28/03/23.
//
import OpenAISwift
import Foundation

final class APIcaller {
    static let shared = APIcaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void){
        client?.sendCompletion(with: input,model: .codex(.davinci) ,completionHandler: {result in
            switch result {
            case.success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case.failure(let error):
                completion(.failure(error))
            }
        })
    }
    
}
