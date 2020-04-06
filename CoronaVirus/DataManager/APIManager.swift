//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import Foundation
import Alamofire
import FeedKit


public class APIManager {

    private let manager: Session

    init(manager: Session = Session.default) {
        self.manager = manager
    }

    func getSummaryStats(completion:@escaping (DataResponse<SummaryStat, AFError>)->Void) {
        manager.request(APIRouter.getSummaryStats).responseDecodable { (response) in
            completion(response)
        }
    }

    func getNews(completion:@escaping (Result<Feed, ParserError>)->Void) {
        let parser = FeedParser(URL: APIRouter.getNews.urlRequest!.url!)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            DispatchQueue.main.async {
                completion(result)
            }
        }

    }
}
