//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter : APIConfiguration {
	
	case getSummaryStats
	case getNews

	internal var method: HTTPMethod {
		switch self {
		case .getSummaryStats:
			return .get
        case .getNews:
            return .get
		}
	}
	
	internal var path: String {
		switch self {
        case .getSummaryStats:
            return "https://api.covid19api.com/summary"
        case .getNews:
            return "https://www.who.int/rss-feeds/news-english.xml"
		}
	}
	
	
	internal var parameters: [String : Any] {
		switch self {
		default:
            return [:]
		}
	}
	
	
	
	internal var body: [String : Any] {
		switch self {
		default:
			return [:]
		}
	}
	
	
	
	internal var headers: HTTPHeaders {
		switch self {
		default:
			return ["Content-Type":"application/json", "Accept":"application/json"]
		}
	}
	
	
	
	func asURLRequest() throws -> URLRequest {
		var urlComponents = URLComponents(string: path)!
		var queryItems:[URLQueryItem] = []
		for item in parameters {
			queryItems.append(URLQueryItem(name: item.key, value: "\(item.value)"))
		}
		if(!(queryItems.isEmpty)){
			urlComponents.queryItems = queryItems
		}
		let url = urlComponents.url!
		var urlRequest = URLRequest(url: url)

        print("URL: \(url)")
		
		urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers.dictionary
		
		if(!(body.isEmpty)){
			urlRequest = try URLEncoding().encode(urlRequest, with: body)
			
			let jsonData1 = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
			urlRequest.httpBody = jsonData1
		}
		
		return urlRequest
		
	}
}


