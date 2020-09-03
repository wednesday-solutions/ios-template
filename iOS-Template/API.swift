// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// When a user creates an account, they must send `name`, `username`, and `password` to the `createAccount` mutation. This input type wraps those fields into one fancy object.
public struct CreateAccountInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - name: A `Customer`'s full name.
  ///   - username: A `Customer`'s unique user name.
  ///   - password: A `Customer`'s password.
  public init(name: String, username: GraphQLID, password: String) {
    graphQLMap = ["name": name, "username": username, "password": password]
  }

  /// A `Customer`'s full name.
  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A `Customer`'s unique user name.
  public var username: GraphQLID {
    get {
      return graphQLMap["username"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "username")
    }
  }

  /// A `Customer`'s password.
  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }
}

/// This enumeration type describes the category that the `Pet` fits into. Additional types could be added to this enum as the Pet Library grows.
public enum PetCategory: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// A small, carnivorous mammal, usually sleeping.
  case cat
  /// A wolf descendent that you can dress in little jackets
  case dog
  /// A long-eared hopping animal, often associated with jellybeans.
  case rabbit
  /// A cartilaginous fish related to sharks common to coastal tropical and subtropical waters that the Pet Library will let you take home for some reason.
  case stingray
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "CAT": self = .cat
      case "DOG": self = .dog
      case "RABBIT": self = .rabbit
      case "STINGRAY": self = .stingray
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .cat: return "CAT"
      case .dog: return "DOG"
      case .rabbit: return "RABBIT"
      case .stingray: return "STINGRAY"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PetCategory, rhs: PetCategory) -> Bool {
    switch (lhs, rhs) {
      case (.cat, .cat): return true
      case (.dog, .dog): return true
      case (.rabbit, .rabbit): return true
      case (.stingray, .stingray): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [PetCategory] {
    return [
      .cat,
      .dog,
      .rabbit,
      .stingray,
    ]
  }
}

/// This enumeration type tells us whether or not a pet is checked out. If `AVAILABLE`, a `Customer` can take this pet home. If `CHECKEDOUT`, a `Customer` has to wait for the pet to be returned.
public enum PetStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// A `Pet` with this status can be checked out.
  case available
  /// A `Pet` with this status has already been checked out and is unavailable.
  case checkedout
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "AVAILABLE": self = .available
      case "CHECKEDOUT": self = .checkedout
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .available: return "AVAILABLE"
      case .checkedout: return "CHECKEDOUT"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PetStatus, rhs: PetStatus) -> Bool {
    switch (lhs, rhs) {
      case (.available, .available): return true
      case (.checkedout, .checkedout): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [PetStatus] {
    return [
      .available,
      .checkedout,
    ]
  }
}

public final class CreateAccountMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation createAccount($input: CreateAccountInput!) {
      createAccount(input: $input) {
        __typename
        username
        name
        dateCreated
        currentPets {
          __typename
          id
          name
          weight
          category
          status
          photo {
            __typename
            full
            thumb
          }
        }
        checkoutHistory {
          __typename
          pet {
            __typename
            id
            name
          }
          checkInDate
          checkInDate
          late
        }
      }
    }
    """

  public let operationName: String = "createAccount"

  public var input: CreateAccountInput

  public init(input: CreateAccountInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createAccount", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(CreateAccount.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createAccount: CreateAccount) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createAccount": createAccount.resultMap])
    }

    /// When you need to create an account at the Pet Library, you'll need to send this mutation. Your name + username + password is all you need to be given dominion over cats, dogs, rabbits, and/or stingrays.
    public var createAccount: CreateAccount {
      get {
        return CreateAccount(unsafeResultMap: resultMap["createAccount"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "createAccount")
      }
    }

    public struct CreateAccount: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Customer"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("username", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("dateCreated", type: .scalar(String.self)),
          GraphQLField("currentPets", type: .nonNull(.list(.nonNull(.object(CurrentPet.selections))))),
          GraphQLField("checkoutHistory", type: .nonNull(.list(.nonNull(.object(CheckoutHistory.selections))))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(username: GraphQLID, name: String, dateCreated: String? = nil, currentPets: [CurrentPet], checkoutHistory: [CheckoutHistory]) {
        self.init(unsafeResultMap: ["__typename": "Customer", "username": username, "name": name, "dateCreated": dateCreated, "currentPets": currentPets.map { (value: CurrentPet) -> ResultMap in value.resultMap }, "checkoutHistory": checkoutHistory.map { (value: CheckoutHistory) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A unique username for the `Customer`.
      public var username: GraphQLID {
        get {
          return resultMap["username"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "username")
        }
      }

      /// The `Customer`'s name as a string.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The date that this `Customer` was created (whenever the `createAccount` mutation was sent).
      public var dateCreated: String? {
        get {
          return resultMap["dateCreated"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "dateCreated")
        }
      }

      /// Returns a list of `Pet` objects that the `Customer` currently has checked out. If the `Customer` does not have any pets checked out, this value will be an empty array.
      public var currentPets: [CurrentPet] {
        get {
          return (resultMap["currentPets"] as! [ResultMap]).map { (value: ResultMap) -> CurrentPet in CurrentPet(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: CurrentPet) -> ResultMap in value.resultMap }, forKey: "currentPets")
        }
      }

      /// Returns a list of `Checkout`s, objects that describe a pet checkout transaction. If the `Customer` has never checked out a pet, this value will be an empty array.
      public var checkoutHistory: [CheckoutHistory] {
        get {
          return (resultMap["checkoutHistory"] as! [ResultMap]).map { (value: ResultMap) -> CheckoutHistory in CheckoutHistory(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: CheckoutHistory) -> ResultMap in value.resultMap }, forKey: "checkoutHistory")
        }
      }

      public struct CurrentPet: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Pet"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("weight", type: .scalar(Double.self)),
            GraphQLField("category", type: .nonNull(.scalar(PetCategory.self))),
            GraphQLField("status", type: .scalar(PetStatus.self)),
            GraphQLField("photo", type: .object(Photo.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String, weight: Double? = nil, category: PetCategory, status: PetStatus? = nil, photo: Photo? = nil) {
          self.init(unsafeResultMap: ["__typename": "Pet", "id": id, "name": name, "weight": weight, "category": category, "status": status, "photo": photo.flatMap { (value: Photo) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A unique identifier for each `Pet`. This value also serves as a lookup for the `petById` query.
        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// The pet's given name
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// The weight (in pounds) of the pet in question
        public var weight: Double? {
          get {
            return resultMap["weight"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "weight")
          }
        }

        /// The category that this pet belongs to. Must one of the values of the `PetCategory` enumerator: CAT, DOG, RABBIT, or STINGRAY
        public var category: PetCategory {
          get {
            return resultMap["category"]! as! PetCategory
          }
          set {
            resultMap.updateValue(newValue, forKey: "category")
          }
        }

        /// The current checkout status of the pet. Must one of the values of the `PetStatus` enumerator: AVAILABLE or CHECKEDOUT.
        public var status: PetStatus? {
          get {
            return resultMap["status"] as? PetStatus
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        /// A `Photo` type. The `Photo` type is an object containing `thumb` and `full` for thumbnail and fullsize image links.
        public var photo: Photo? {
          get {
            return (resultMap["photo"] as? ResultMap).flatMap { Photo(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "photo")
          }
        }

        public struct Photo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Photo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("full", type: .scalar(String.self)),
              GraphQLField("thumb", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(full: String? = nil, thumb: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Photo", "full": full, "thumb": thumb])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The url for a fullsize photo of a `Pet`.
          public var full: String? {
            get {
              return resultMap["full"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "full")
            }
          }

          /// The url for a thumbnail photo of a `Pet`.
          public var thumb: String? {
            get {
              return resultMap["thumb"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "thumb")
            }
          }
        }
      }

      public struct CheckoutHistory: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Checkout"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pet", type: .object(Pet.selections)),
            GraphQLField("checkInDate", type: .nonNull(.scalar(String.self))),
            GraphQLField("checkInDate", type: .nonNull(.scalar(String.self))),
            GraphQLField("late", type: .scalar(Bool.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pet: Pet? = nil, checkInDate: String, late: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "Checkout", "pet": pet.flatMap { (value: Pet) -> ResultMap in value.resultMap }, "checkInDate": checkInDate, "late": late])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The entire `Pet` object for the pet who was just checked out.
        public var pet: Pet? {
          get {
            return (resultMap["pet"] as? ResultMap).flatMap { Pet(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "pet")
          }
        }

        /// The date that this `Pet` was checked out. This is used to calculate the dueDate.
        public var checkInDate: String {
          get {
            return resultMap["checkInDate"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkInDate")
          }
        }

        /// A boolean flag to indicate whether the `Pet` was checked in late. If this value is true, this means that you blocked another person from checking out a `Pet`. You can do better than that.
        public var late: Bool? {
          get {
            return resultMap["late"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "late")
          }
        }

        public struct Pet: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Pet"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String) {
            self.init(unsafeResultMap: ["__typename": "Pet", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A unique identifier for each `Pet`. This value also serves as a lookup for the `petById` query.
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// The pet's given name
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }
    }
  }
}

public final class LoginRequestMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation loginRequest($username: ID!, $password: String!) {
      logIn(username: $username, password: $password) {
        __typename
        customer {
          __typename
          username
          name
          dateCreated
          currentPets {
            __typename
            id
            name
            weight
            category
            status
            photo {
              __typename
              full
              thumb
            }
          }
          checkoutHistory {
            __typename
            pet {
              __typename
              id
              name
              weight
              category
              inCareOf {
                __typename
                name
                username
              }
            }
            checkInDate
            checkOutDate
            late
          }
        }
        token
      }
    }
    """

  public let operationName: String = "loginRequest"

  public var username: GraphQLID
  public var password: String

  public init(username: GraphQLID, password: String) {
    self.username = username
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("logIn", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password")], type: .nonNull(.object(LogIn.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(logIn: LogIn) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "logIn": logIn.resultMap])
    }

    /// A mutation used to log in a registered user. If you haven't created an account yet, start with the `createAccount` mutation.
    public var logIn: LogIn {
      get {
        return LogIn(unsafeResultMap: resultMap["logIn"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "logIn")
      }
    }

    public struct LogIn: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LogInPayload"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("customer", type: .object(Customer.selections)),
          GraphQLField("token", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(customer: Customer? = nil, token: String) {
        self.init(unsafeResultMap: ["__typename": "LogInPayload", "customer": customer.flatMap { (value: Customer) -> ResultMap in value.resultMap }, "token": token])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The entire `Customer` object for the recently logged in individual.
      public var customer: Customer? {
        get {
          return (resultMap["customer"] as? ResultMap).flatMap { Customer(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "customer")
        }
      }

      /// The authorization token that can be used to run queries and mutations that require login.
      public var token: String {
        get {
          return resultMap["token"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public struct Customer: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Customer"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("username", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("dateCreated", type: .scalar(String.self)),
            GraphQLField("currentPets", type: .nonNull(.list(.nonNull(.object(CurrentPet.selections))))),
            GraphQLField("checkoutHistory", type: .nonNull(.list(.nonNull(.object(CheckoutHistory.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(username: GraphQLID, name: String, dateCreated: String? = nil, currentPets: [CurrentPet], checkoutHistory: [CheckoutHistory]) {
          self.init(unsafeResultMap: ["__typename": "Customer", "username": username, "name": name, "dateCreated": dateCreated, "currentPets": currentPets.map { (value: CurrentPet) -> ResultMap in value.resultMap }, "checkoutHistory": checkoutHistory.map { (value: CheckoutHistory) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A unique username for the `Customer`.
        public var username: GraphQLID {
          get {
            return resultMap["username"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "username")
          }
        }

        /// The `Customer`'s name as a string.
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// The date that this `Customer` was created (whenever the `createAccount` mutation was sent).
        public var dateCreated: String? {
          get {
            return resultMap["dateCreated"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dateCreated")
          }
        }

        /// Returns a list of `Pet` objects that the `Customer` currently has checked out. If the `Customer` does not have any pets checked out, this value will be an empty array.
        public var currentPets: [CurrentPet] {
          get {
            return (resultMap["currentPets"] as! [ResultMap]).map { (value: ResultMap) -> CurrentPet in CurrentPet(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: CurrentPet) -> ResultMap in value.resultMap }, forKey: "currentPets")
          }
        }

        /// Returns a list of `Checkout`s, objects that describe a pet checkout transaction. If the `Customer` has never checked out a pet, this value will be an empty array.
        public var checkoutHistory: [CheckoutHistory] {
          get {
            return (resultMap["checkoutHistory"] as! [ResultMap]).map { (value: ResultMap) -> CheckoutHistory in CheckoutHistory(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: CheckoutHistory) -> ResultMap in value.resultMap }, forKey: "checkoutHistory")
          }
        }

        public struct CurrentPet: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Pet"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("weight", type: .scalar(Double.self)),
              GraphQLField("category", type: .nonNull(.scalar(PetCategory.self))),
              GraphQLField("status", type: .scalar(PetStatus.self)),
              GraphQLField("photo", type: .object(Photo.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, weight: Double? = nil, category: PetCategory, status: PetStatus? = nil, photo: Photo? = nil) {
            self.init(unsafeResultMap: ["__typename": "Pet", "id": id, "name": name, "weight": weight, "category": category, "status": status, "photo": photo.flatMap { (value: Photo) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A unique identifier for each `Pet`. This value also serves as a lookup for the `petById` query.
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// The pet's given name
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// The weight (in pounds) of the pet in question
          public var weight: Double? {
            get {
              return resultMap["weight"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "weight")
            }
          }

          /// The category that this pet belongs to. Must one of the values of the `PetCategory` enumerator: CAT, DOG, RABBIT, or STINGRAY
          public var category: PetCategory {
            get {
              return resultMap["category"]! as! PetCategory
            }
            set {
              resultMap.updateValue(newValue, forKey: "category")
            }
          }

          /// The current checkout status of the pet. Must one of the values of the `PetStatus` enumerator: AVAILABLE or CHECKEDOUT.
          public var status: PetStatus? {
            get {
              return resultMap["status"] as? PetStatus
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }

          /// A `Photo` type. The `Photo` type is an object containing `thumb` and `full` for thumbnail and fullsize image links.
          public var photo: Photo? {
            get {
              return (resultMap["photo"] as? ResultMap).flatMap { Photo(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "photo")
            }
          }

          public struct Photo: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Photo"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("full", type: .scalar(String.self)),
                GraphQLField("thumb", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(full: String? = nil, thumb: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Photo", "full": full, "thumb": thumb])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The url for a fullsize photo of a `Pet`.
            public var full: String? {
              get {
                return resultMap["full"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "full")
              }
            }

            /// The url for a thumbnail photo of a `Pet`.
            public var thumb: String? {
              get {
                return resultMap["thumb"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "thumb")
              }
            }
          }
        }

        public struct CheckoutHistory: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Checkout"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pet", type: .object(Pet.selections)),
              GraphQLField("checkInDate", type: .nonNull(.scalar(String.self))),
              GraphQLField("checkOutDate", type: .nonNull(.scalar(String.self))),
              GraphQLField("late", type: .scalar(Bool.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(pet: Pet? = nil, checkInDate: String, checkOutDate: String, late: Bool? = nil) {
            self.init(unsafeResultMap: ["__typename": "Checkout", "pet": pet.flatMap { (value: Pet) -> ResultMap in value.resultMap }, "checkInDate": checkInDate, "checkOutDate": checkOutDate, "late": late])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The entire `Pet` object for the pet who was just checked out.
          public var pet: Pet? {
            get {
              return (resultMap["pet"] as? ResultMap).flatMap { Pet(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "pet")
            }
          }

          /// The date that this `Pet` was checked out. This is used to calculate the dueDate.
          public var checkInDate: String {
            get {
              return resultMap["checkInDate"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "checkInDate")
            }
          }

          /// The date that this `Pet` was checked out. This is used to calculate the dueDate.
          public var checkOutDate: String {
            get {
              return resultMap["checkOutDate"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "checkOutDate")
            }
          }

          /// A boolean flag to indicate whether the `Pet` was checked in late. If this value is true, this means that you blocked another person from checking out a `Pet`. You can do better than that.
          public var late: Bool? {
            get {
              return resultMap["late"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "late")
            }
          }

          public struct Pet: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Pet"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("weight", type: .scalar(Double.self)),
                GraphQLField("category", type: .nonNull(.scalar(PetCategory.self))),
                GraphQLField("inCareOf", type: .object(InCareOf.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String, weight: Double? = nil, category: PetCategory, inCareOf: InCareOf? = nil) {
              self.init(unsafeResultMap: ["__typename": "Pet", "id": id, "name": name, "weight": weight, "category": category, "inCareOf": inCareOf.flatMap { (value: InCareOf) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A unique identifier for each `Pet`. This value also serves as a lookup for the `petById` query.
            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// The pet's given name
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// The weight (in pounds) of the pet in question
            public var weight: Double? {
              get {
                return resultMap["weight"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "weight")
              }
            }

            /// The category that this pet belongs to. Must one of the values of the `PetCategory` enumerator: CAT, DOG, RABBIT, or STINGRAY
            public var category: PetCategory {
              get {
                return resultMap["category"]! as! PetCategory
              }
              set {
                resultMap.updateValue(newValue, forKey: "category")
              }
            }

            /// If this pet is checked out (status: CHECKEDOUT), this field will return the `Customer` who checked this `Pet` out and is responsible for is security and overall happiness
            public var inCareOf: InCareOf? {
              get {
                return (resultMap["inCareOf"] as? ResultMap).flatMap { InCareOf(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "inCareOf")
              }
            }

            public struct InCareOf: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Customer"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  GraphQLField("username", type: .nonNull(.scalar(GraphQLID.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String, username: GraphQLID) {
                self.init(unsafeResultMap: ["__typename": "Customer", "name": name, "username": username])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The `Customer`'s name as a string.
              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              /// A unique username for the `Customer`.
              public var username: GraphQLID {
                get {
                  return resultMap["username"]! as! GraphQLID
                }
                set {
                  resultMap.updateValue(newValue, forKey: "username")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class GetAllPetsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query getAllPets($status: PetStatus) {
      allPets(status: $status) {
        __typename
        id
        name
        weight
        category
        status
        photo {
          __typename
          full
          thumb
        }
      }
    }
    """

  public let operationName: String = "getAllPets"

  public var status: PetStatus?

  public init(status: PetStatus? = nil) {
    self.status = status
  }

  public var variables: GraphQLMap? {
    return ["status": status]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allPets", arguments: ["status": GraphQLVariable("status")], type: .nonNull(.list(.nonNull(.object(AllPet.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allPets: [AllPet]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allPets": allPets.map { (value: AllPet) -> ResultMap in value.resultMap }])
    }

    /// This query returns all of the data about the `Pets`. This is a list of `Pet` objects that are part of the Pet Library.
    public var allPets: [AllPet] {
      get {
        return (resultMap["allPets"] as! [ResultMap]).map { (value: ResultMap) -> AllPet in AllPet(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllPet) -> ResultMap in value.resultMap }, forKey: "allPets")
      }
    }

    public struct AllPet: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pet"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("weight", type: .scalar(Double.self)),
          GraphQLField("category", type: .nonNull(.scalar(PetCategory.self))),
          GraphQLField("status", type: .scalar(PetStatus.self)),
          GraphQLField("photo", type: .object(Photo.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, weight: Double? = nil, category: PetCategory, status: PetStatus? = nil, photo: Photo? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pet", "id": id, "name": name, "weight": weight, "category": category, "status": status, "photo": photo.flatMap { (value: Photo) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A unique identifier for each `Pet`. This value also serves as a lookup for the `petById` query.
      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// The pet's given name
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The weight (in pounds) of the pet in question
      public var weight: Double? {
        get {
          return resultMap["weight"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }

      /// The category that this pet belongs to. Must one of the values of the `PetCategory` enumerator: CAT, DOG, RABBIT, or STINGRAY
      public var category: PetCategory {
        get {
          return resultMap["category"]! as! PetCategory
        }
        set {
          resultMap.updateValue(newValue, forKey: "category")
        }
      }

      /// The current checkout status of the pet. Must one of the values of the `PetStatus` enumerator: AVAILABLE or CHECKEDOUT.
      public var status: PetStatus? {
        get {
          return resultMap["status"] as? PetStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      /// A `Photo` type. The `Photo` type is an object containing `thumb` and `full` for thumbnail and fullsize image links.
      public var photo: Photo? {
        get {
          return (resultMap["photo"] as? ResultMap).flatMap { Photo(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "photo")
        }
      }

      public struct Photo: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Photo"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("full", type: .scalar(String.self)),
            GraphQLField("thumb", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(full: String? = nil, thumb: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Photo", "full": full, "thumb": thumb])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The url for a fullsize photo of a `Pet`.
        public var full: String? {
          get {
            return resultMap["full"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "full")
          }
        }

        /// The url for a thumbnail photo of a `Pet`.
        public var thumb: String? {
          get {
            return resultMap["thumb"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "thumb")
          }
        }
      }
    }
  }
}
