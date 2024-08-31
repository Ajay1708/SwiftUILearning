# StateObject

@MainActor @frozen @propertyWrapper @preconcurrency
struct StateObject<ObjectType> where ObjectType : ObservableObject

- A property wrapper type that instantiates an observable object.

* Use a state object as the single source of truth for a reference type that you store in a view
hierarchy. 

* Declare state objects as private to prevent setting them from a memberwise initializer, which can
conflict with the storage management that SwiftUI provides

* SwiftUI creates a new instance of the model object only once during the lifetime of the container
that declares the state object. For example, SwiftUI doesn’t create a new instance if a view’s inputs
change, but does create a new instance if the identity of a view changes. When published properties of
the observable object change, SwiftUI updates any view that depends on those properties

```
class DataModel: ObservableObject {
    @Published var name = "Some Name"
    @Published var isEnabled = false
}

struct MyView: View {
    @StateObject private var model = DataModel() // Create the state object.

    var body: some View {
        Text(model.name) // Updates when the data model changes.
        MySubView()
            .environmentObject(model)
    }
}
```

### Note:
- If you need to store a value type, like a structure, string, or integer, use the State property
wrapper instead.

## Share state objects with subviews
* You can pass a state object into a subview through a property that has the ObservedObject attribute.
 
* Alternatively, add the object to the environment of a view hierarchy by applying the
environmentObject(_:) modifier to a view. You can then read the object inside MySubView or any of its
descendants using the EnvironmentObject attribute

```
struct MySubView: View {
    @EnvironmentObject var model: DataModel

    var body: some View {
        Toggle("Enabled", isOn: $model.isEnabled)
    }
}
```

## Initialize state objects using external data
* When a state object’s initial state depends on data that comes from outside its container, you can
call the object’s initializer explicitly from within its container’s initializer.

```
struct MyInitializableView: View {
    @StateObject private var model: DataModel

    init(name: String) {
        // SwiftUI ensures that the following initialization uses the
        // closure only once during the lifetime of the view, so
        // later changes to the view's name input have no effect.
        _model = StateObject(wrappedValue: DataModel(name: name))
    }

    var body: some View {
        VStack {
            Text("Name: \(model.name)")
        }
    }
}
```
* Use caution when doing this. SwiftUI only initializes a state object the first time you call its
initializer in a given view. This ensures that the object provides stable storage even as the view’s
inputs change. However, it might result in unexpected behavior or unwanted side effects if you
explicitly initialize the state object.

``` Potential Pitfall with @StateObject Initialization
import SwiftUI

class NameModel: ObservableObject {
    @Published var name: String
    
    init(name: String) {
        self.name = name
        print("NameModel initialized with name: \(name)")
    }
}

struct ContentView: View {
    @State private var currentName = "Alice"
    
    var body: some View {
        VStack {
            MyInitializableView(name: currentName)
            
            Button("Change Name") {
                currentName = currentName == "Alice" ? "Bob" : "Alice"
            }
        }
    }
}

struct MyInitializableView: View {
    let name: String
    @StateObject private var model: NameModel
    
    init(name: String) {
        _model = StateObject(wrappedValue: NameModel(name: name))
        print("MyInitializableView initialized with name: \(name)")
    }
    
    var body: some View {
        VStack {
            Text("Name in model: \(model.name)")
        }
        .padding()
        .border(Color.blue, width: 2)
    }
}
```
### Behavior:
- When the app first runs, currentName is “Alice”, so MyInitializableView is initialized with “Alice”,
and the NameModel is initialized with “Alice” as well.
- If you press the “Change Name” button, currentName changes to “Bob”. The MyInitializableView view is
re-initialized with the new name “Bob”, but SwiftUI does not re-run the StateObject’s closure. The
existing NameModel instance remains in place, still holding “Alice” as its name.
- The console output will show that “NameModel initialized with name: Alice” only appears once, even
when the view’s initializer is rerun with the new name.

### Solution - 1
If you want to update the NameModel with the new name every time the name changes, you should avoid
using @StateObject in a way that depends on external inputs that might change. Instead, consider using
@ObservedObject or another method to update the model, or manually update the model inside the view
when necessary.

```
struct MyInitializableView: View {
    let name: String
    @StateObject private var model = NameModel(name: "")
    
    var body: some View {
        VStack {
            Text("Name in model: \(model.name)")
        }
        .padding()
        .border(Color.blue, width: 2)
        .onAppear {
            model.name = name  // Set the initial value when the view appears
        }
        .onChange(of: name) { newName in
            model.name = newName  // Update the model whenever the name changes
        }
    }
}
```
### Solution - 2
```
struct ContentView: View {
    @State private var currentName = "Alice"
    @StateObject private var model: NameModel
    
    init() {
        // Initialize the model here, allowing it to be replaced as needed
        _model = StateObject(wrappedValue: NameModel(name: "Alice"))
    }
    
    var body: some View {
        VStack {
            MyInitializableView(model: model)
            
            Button("Change Name") {
                currentName = currentName == "Alice" ? "Bob" : "Alice"
                model.name = currentName  // Update the model directly
            }
        }
    }
}

struct MyInitializableView: View {
    @ObservedObject var model: NameModel
    
    var body: some View {
        VStack {
            Text("Name in model: \(model.name)")
        }
        .padding()
        .border(Color.blue, width: 2)
    }
}
```
* Explicit state object initialization works well when the external data that the object depends on
doesn’t change for a given instance of the object’s container. For example, you can create two views
with different constant names:
```
var body: some View {
    VStack {
        MyInitializableView(name: "Ravi")
        MyInitializableView(name: "Maria")
    }
}
```

## Force reinitialization by changing view identity
* If you want SwiftUI to reinitialize a state object when a view input changes, make sure that the
view’s identity changes at the same time. One way to do this is to bind the view’s identity to the
value that changes using the id(_:) modifier.
```
- For example, you can ensure that the identity of an instance of MyInitializableView changes when its name input changes:
MyInitializableView(name: name)
    .id(name) // Binds the identity of the view to the name property.
```
### Note:
- If your view appears inside a ForEach, it implicitly receives an id(_:) modifier that uses the
identifier of the corresponding data element. The identifier assigned by ForEach (whether implicit or
explicit) is crucial for SwiftUI to manage the state and identity of the views correctly. It ensures
that SwiftUI can differentiate between views, especially when the underlying data changes. If you add,
remove, or reorder items in the array, SwiftUI uses the id values to determine which views to update,
create, or remove.

* If you need the view to reinitialize state based on changes in more than one value, you can combine
the values into a single identifier using a Hasher. 

```
- For example, if you want to update the data model in MyInitializableView when the values of either
name or isEnabled change, you can combine both variables into a single hash:

var hash: Int {
    var hasher = Hasher()
    hasher.combine(name)
    hasher.combine(isEnabled)
    return hasher.finalize()
}

- Then apply the combined hash to the view as an identifier:

MyInitializableView(name: name, isEnabled: isEnabled)
    .id(hash)
```
* Be mindful of the performance cost of reinitializing the state object every time the input changes.
Also, changing view identity can have side effects. For example, SwiftUI doesn’t automatically animate
changes inside the view if the view’s identity changes at the same time. Also, changing the identity
resets all state held by the view, including values that you manage as State, FocusState, GestureState,
and so on.
