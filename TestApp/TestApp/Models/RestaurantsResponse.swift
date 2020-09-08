import Foundation

struct RestaurantsResponse: Codable {
    let total: Int
    let max: Int
    let sort: String
    let count: Int
    let data: [Resto]
    let offset: Int
    let info: Info
}

struct Resto: Codable {
    let deliveryTimeMinMinutes: String?
    let validReviewsCount: Int?
    let cityName: CityName?
    let sortingLogistics: Int?
    let allCategories: String?
    let sortingDistance: Double?
    let doorNumber: String?
    let minDeliveryAmount, deliveryTimeOrder: Int?
    let datumDescription: String?
    let sortingTalent: Int?
    let mandatoryPaymentAmount, shippingAmountIsPercentage: Bool?
    let sortingVip, opened, index: Int?
    let deliveryAreas: String?
    let favoritesCount: Int?
    let paymentMethodsList: [PaymentMethodsList]
    let withLogistics: Bool?
    let isNew, delivers, variableShippingFee: Bool?
    let channels: [Int]
    let businessType: String?
    let vendorSponsoring: String?
    let nextHourClose: String?
    let hasOnlinePaymentMethods, homeVip: Bool?
    let discount: Int?
    let headerImage: String?
    let affectedByPorygonEvents: Bool?
    let averagePrice: Int?
    let deliveryTime: String?
    let food: Double?
    let deliveryTimeID: Int?
    let capacityCheck: Bool?
    let sortingNew, vendorSponsoringScore: Int?
    let nextHour: String?
    let acceptsPreOrder: Bool?
    let weighing: Double?
    let noIndex: Bool?
    let sortingRejectionRate: Double?
    let restaurantRegisteredDate: String?
    let link: String?
    let isGoldVip: Bool?
    let generalScore: Double?
    let sortingCategory, restaurantTypeID: Int?
    let topCategories: String?
    let id: Int?
    let distance: Double?
    let area: String?
    let name: String
    let sortingReviews: Double?
    let coordinates: String
    let maxShippingAmount: Int?
    let logo, ratingScore, deliveryTimeMaxMinutes: String?
    let deliveryType: DeliveryType
    let speed: Double
    let favoriteByUser: Bool
    let deliveryZoneID, sortingOrderCount, sortingKA, sortingOnlinePayment: Int?
    let sortingConcept, shippingAmount, sortingGroupOrderCount: Int?
    let address: String
    let hasZone: Bool?
    let stateID: Int?
    let favoriteByOrders: Bool?
    let service: Double?
    let paymentMethods: String?
    let categories: [Category]?
    let rating: String?
    let sortingConfirmationTime: Int?
    let stamps: Stamps?
    let marks: [String]?
    let shrinkingTags, shopperType: String?

    enum CodingKeys: String, CodingKey {
        case deliveryTimeMinMinutes, validReviewsCount, cityName, sortingLogistics, allCategories, sortingDistance, doorNumber, minDeliveryAmount, deliveryTimeOrder
        case datumDescription = "description"
        case sortingTalent, mandatoryPaymentAmount, shippingAmountIsPercentage, sortingVip, opened, index, deliveryAreas, favoritesCount, paymentMethodsList, withLogistics, isNew, delivers, variableShippingFee, channels, businessType, vendorSponsoring, nextHourClose, hasOnlinePaymentMethods, homeVip, discount, headerImage, affectedByPorygonEvents, averagePrice, deliveryTime, food
        case deliveryTimeID = "deliveryTimeId"
        case capacityCheck, sortingNew, vendorSponsoringScore, nextHour, acceptsPreOrder, weighing, noIndex, sortingRejectionRate, restaurantRegisteredDate, link, isGoldVip, generalScore, sortingCategory
        case restaurantTypeID = "restaurantTypeId"
        case topCategories, id, distance, area, name, sortingReviews, coordinates, maxShippingAmount, logo, ratingScore, deliveryTimeMaxMinutes, deliveryType, speed, favoriteByUser
        case deliveryZoneID = "deliveryZoneId"
        case sortingOrderCount, sortingKA, sortingOnlinePayment, sortingConcept, shippingAmount, sortingGroupOrderCount, address, hasZone
        case stateID = "stateId"
        case favoriteByOrders, service, paymentMethods, categories, rating, sortingConfirmationTime, stamps, marks, shrinkingTags, shopperType
    }
}

struct Category: Codable {
    let id, sortingIndex: Int
    let visible: Bool
    let percentage: Double
    let manuallySorted: Bool
    let name: String
    let state: Int
    let image: String?
    let quantity: Int
}

enum CityName: String, Codable {
    case montevideo = "Montevideo"
}

enum DeliveryType: String, Codable {
    case all = "ALL"
    case delivery = "DELIVERY"
    case pickUp = "PICK_UP"
}

struct PaymentMethodsList: Codable {
    let id, descriptionPT, descriptionES: String
    let online: Bool
}

struct Stamps: Codable {
    let state: State
    let average, has, needed: Int
}

enum State: String, Codable {
    case abandoned = "ABANDONED"
    case active = "ACTIVE"
}

struct Info: Codable {
    let flags: [Flag]
    let nearbyPickup: Bool
    let advertisingAreaID: String
    let advertisingAreaType, areaID: Int

    enum CodingKeys: String, CodingKey {
        case flags, nearbyPickup
        case advertisingAreaID = "advertisingAreaId"
        case advertisingAreaType
        case areaID = "areaId"
    }
}

struct Flag: Codable {
    let name, value: String
}
