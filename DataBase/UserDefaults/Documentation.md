#  UserDefaults
- UserDefaults is used to store small pieces of data like your current user's name, current user's id, the
last time the user signed in, whether or not they are premium user. We don't want to store the whole database.

# AppStorage
- AppStorage is a property wrapper from SwiftUI which is used for reading values from Userdefaults, which
will automatically reinvoke your view’s body property when the value changes. That is, this wrapper 
effectively watches a key in UserDefaults, and will refresh your UI if that key changes.
- `@AppStorage` will watch UserDefaults.standard by default, but you can also make it watch a particular app group if you prefer, like this:
@AppStorage("username", store: UserDefaults(suiteName: "group.com.hackingwithswift.unwrap")) var username: String = "Anonymous"

### Important
* @AppStorage writes your data to UserDefaults, which is not secure storage. As a result, you should not
save any personal data using @AppStorage, because it’s relatively easy to extract.

Check this doc --> https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-appstorage-property-wrapper


