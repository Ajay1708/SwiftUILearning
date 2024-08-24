
# State
* A property wrapper type that can read and write a value managed by SwiftUI. The life cycle of state
variables mirrors the view life cycle.
* If a view needs to store data that it can modify, declare a variable with the State property wrapper
* Declare state as private in the highest view in the view hierarchy that needs access to the value.
Then share the state with any subviews that also need access, either directly for read-only access, or
as a binding for read-write access. 
* You can safely mutate state properties from any thread. Apple has designed SwiftUI in such a way that
@State and @StateObject are internally synchronized, meaning that SwiftUI can handle state mutations on
any thread safely. This allows developers to mutate state properties from background threads without
explicitly needing to dispatch those changes to the main thread, which was a common requirement in
UIKit.
```
struct ContentView: View {
    @State private var text = "Initial Text"

    var body: some View {
        Text(text)
            .onAppear {
                DispatchQueue.global().async {
                    // This is safe in SwiftUI, even though it's on a background thread
                    text = "Updated Text"
                }
            }
    }
}
```
* Declare state as private to prevent setting it in a memberwise initializer, which can conflict with 
the storage management that SwiftUI provides:
* Unlike a state object, always initialize state by providing a default value in the state’s
declaration, as in the below example. Use state only for storage that’s local to a view and its
subviews.
```
struct PlayerView: View {
    @State private var isPlaying: Bool = false // Create the state here now.

    var body: some View {
        VStack {
            PlayButton(isPlaying: $isPlaying) // Pass a binding.
        }
    }
}
```
* A State property always instantiates its default value when SwiftUI instantiates the view. For this
reason, avoid side effects and performance-intensive work when initializing the default value. 
For example, if a view updates frequently, allocating a new default object each time the view
initializes can become expensive. Instead, you can defer the creation of the object or the execution of
any side effects by  using the task(priority:_:) modifier, which is called only once when the view 
first appears: This modifier schedules a task that runs asynchronously and only when the view first
appears, ensuring that expensive operations aren’t performed during view initialization.
```
struct ContentView: View {
    @State private var data: DataModel? = nil

    var body: some View {
        VStack {
            if let data = data {
                Text("Data loaded: \(data.value)")
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            // Defer expensive work to avoid impacting view initialization
            let loadedData = await loadData()
            data = loadedData
        }
    }

    func loadData() async -> DataModel {
        // Simulate an expensive data loading operation
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return DataModel(value: "Sample Data")
    }
}

struct DataModel {
    let value: String
}
```
In this example, the data state property is initialized with nil, which is cheap. The actual data
loading happens in the task modifier, which is only called once when the view first appears. This way,
you avoid performing expensive operations during the view’s initialization phase.

## @State with ObservableObject:
- If you store an ObservableObject in a @State property, the view will only update when the reference
to the object changes. This means that if you assign a new object to the @State property, the view will
re-render.
- However, if only the @Published properties of the object change, the view will not automatically
update. This is because @State does not observe changes to the properties of the object; it only
observes changes to the reference itself.
- To track changes to both the reference and the object’s published properties, use StateObject instead
of State when storing the object.

* State properties provide bindings to their value. When storing an object, you can get a Binding to
that object, specifically the reference to the object. This is useful when you need to change the
reference stored in state in some other subview, such as setting the reference to nil:
```
struct ContentView: View {
    @State private var book: Book?

    var body: some View {
        DeleteBookView(book: $book)
            .task {
                book = Book()
            }
    }
}


struct DeleteBookView: View {
    @Binding var book: Book?

    var body: some View {
        Button("Delete book") {
            book = nil
        }
    }
}
```
