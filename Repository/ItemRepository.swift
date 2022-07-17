//
//  ItemRepository.swift
//  ItemRepository
//
//  Created by Tran Tuyen on 17/07/2022.
//

import DomainService
import Foundation

public protocol ItemRepositoryProtocol {
    func search(name: String, categories: String, offset: Int, location: String, completionHandler: @escaping ((PagingResponse<ResponseItemModel>?, String?) -> Void))
}

public class ItemRepository: ItemRepositoryProtocol {
    
    private var domain: DomainServicesProtocol = DomainServices()
    
    public init() {}
    
    public func search(name: String, categories: String, offset: Int, location: String, completionHandler: @escaping ((PagingResponse<ResponseItemModel>?, String?) -> Void)) {
        var params: [String: String] = ["limit": "20"]
        params["offset"] = "\(offset)"
        if !name.isEmpty {
            params["term"] = name
        }
        if !categories.isEmpty {
            params["categories"] = categories
        }
        if !location.isEmpty {
            params["location"] = location
        }
        domain.callGETApi(urlString: API.search.url,
                          customHeader: [:],
                          params: params) { [weak self] responseData, error in
                              guard let self = self else { return }
                              if let error = error {
                                  let errorMessage = self.handleError(error: error)
                                  completionHandler(nil, errorMessage)
                                  return
                              }
                              if let responseData = responseData {
                                  do {
                                      let pagingObject = try JSONDecoder().decode(PagingResponse<ResponseItemModel>.self, from: responseData)
                                      print("LOG ERROR: ✅ API Success - GET \(API.search.url): \n\(pagingObject) \n\n")
                                      completionHandler(pagingObject, nil)
                                  } catch {
                                      print("LOG ERROR: ❌ API Failure - GET \(API.search.url): \n\(APIError.convertJSON.errorMessage) \n\n")
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

