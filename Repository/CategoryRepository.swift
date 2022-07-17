//
//  CategoryRepository.swift
//  Repository
//
//  Created by Tran Tuyen on 17/07/2022.
//

import DomainService
import Foundation

public protocol CategoryRepositoryProtocol {
    func listCateogry(completionHandler: @escaping (([CategoryModel]?, String?) -> Void))
}

public class CategoryRepository: CategoryRepositoryProtocol {
    
    private var domain: DomainServicesProtocol = DomainServices()
    
    public init() {}
    
    public func listCateogry(completionHandler: @escaping (([CategoryModel]?, String?) -> Void)) {
        domain.callGETApi(urlString: API.categories.url, customHeader: [:], params: [:]) { [weak self] responseData, error in
            guard let self = self else { return }
            if let error = error {
                let errorMessage = self.handleError(error: error)
                completionHandler(nil, errorMessage)
                return
            }
            if let responseData = responseData {
                do {
                    let pagingObject = try JSONDecoder().decode(ListCategoryModel.self, from: responseData)
                    print("LOG ERROR: ✅ API Success - GET \(API.categories.url): \n\(pagingObject) \n\n")
                    completionHandler(pagingObject.categories, nil)
                } catch {
                    print("LOG ERROR: ❌ API Failure - GET \(API.categories.url): \n\(APIError.convertJSON.errorMessage) \n\n")
                    completionHandler(nil, APIError.convertJSON.errorMessage)
                }
            }
        }
    }
    
    private func handleError(error: Error) -> String {
        if let error = error as? APIError {
            return error.errorMessage
        } else {
            return error.localizedDescription
        }
    }
}
