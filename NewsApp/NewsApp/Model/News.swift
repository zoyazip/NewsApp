//
//  News.swift
//  NewsApp
//
//  Created by d.chernov on 14/05/2023.
//

import Foundation
struct News: Codable{
    let status: String
        let totalResults: Int
        let articles: [Article]?
    }

    // MARK: - Article
    struct Article: Codable {
        let source: Source
        let author: String?
        let title: String
        let description: String?
        let url: String
        let urlToImage: String
        let publishedAt: String
        let content: String
    }

    // MARK: - Source
    struct Source: Codable {
        let id: String?
        let name: String
    }
