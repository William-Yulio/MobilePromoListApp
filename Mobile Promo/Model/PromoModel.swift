//
//  PromoModel.swift
//  Mobile Promo
//
//  Created by William Yulio on 04/08/23.
//

import Foundation


struct Promo: Codable{
    let promo: [PromoElement]
}

// MARK: - PromoElement
struct PromoElement: Codable {
    let id: Int?
    let title: JSONNull?
    let publishedAt, promoCreatedAt, updatedAt: String?
    let namePromo, descPromo: JSONNull?
    let nama, desc: String?
    let latitude, longitude, alt: String?
    let createdAt, lokasi: String?
    let count: Int?
    let img: Img?

    enum CodingKeys: String, CodingKey {
        case id
        case title = "Title"
        case publishedAt = "published_at"
        case promoCreatedAt = "created_at"
        case updatedAt = "updated_at"
        case namePromo = "name_promo"
        case descPromo = "desc_promo"
        case nama, desc, latitude, longitude, alt, createdAt, lokasi, count, img
    }
}

// MARK: - Img
struct Img: Codable {
    let id: Int
    let name, alternativeText, caption: String
    let width, height: Int
    let formats: Formats
    let hash: String
    let ext: EXT
    let mime: MIME
    let size: Double
    let url: String
    let previewURL: JSONNull?
    let provider: String
    let providerMetadata: JSONNull?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, alternativeText, caption, width, height, formats, hash, ext, mime, size, url
        case previewURL = "previewUrl"
        case provider
        case providerMetadata = "provider_metadata"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum EXT: String, Codable {
    case jpg = ".jpg"
}

// MARK: - Formats
struct Formats: Codable {
    let small, medium, thumbnail: Large
    let large: Large?
}

// MARK: - Large
struct Large: Codable {
    let ext: EXT
    let url: String
    let hash: String
    let mime: MIME
    let name: String
    let path: JSONNull?
    let size: Double
    let width, height: Int
}

enum MIME: String, Codable {
    case imageJPEG = "image/jpeg"
}



// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
