//  This file was automatically generated and should not be edited.

import Apollo

public final class LoginMutation: GraphQLMutation {
  public static let operationString =
    "mutation Login($email: String!, $password: String!) {\n  login(email: $email, password: $password) {\n    __typename\n    token\n    user {\n      __typename\n      email\n    }\n  }\n}"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(Login.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(login: Login? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> Snapshot in value.snapshot }])
    }

    public var login: Login? {
      get {
        return (snapshot["login"] as? Snapshot).flatMap { Login(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["AuthPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .scalar(String.self)),
        GraphQLField("user", type: .object(User.selections)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(token: String? = nil, user: User? = nil) {
        self.init(snapshot: ["__typename": "AuthPayload", "token": token, "user": user.flatMap { (value: User) -> Snapshot in value.snapshot }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String? {
        get {
          return snapshot["token"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "token")
        }
      }

      public var user: User? {
        get {
          return (snapshot["user"] as? Snapshot).flatMap { User(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "user")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(email: String) {
          self.init(snapshot: ["__typename": "User", "email": email])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var email: String {
          get {
            return snapshot["email"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "email")
          }
        }
      }
    }
  }
}