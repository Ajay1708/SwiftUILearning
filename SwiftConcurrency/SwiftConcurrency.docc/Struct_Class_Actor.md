# Struct - Value Types - Stored in Stack - Thread safe - Faster
- Thread safe because each thread has its own stack. Therefore anything in the stack is thread safe by default.
- Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast.
- Structs are used for 
1. Data models - because we pass our data models around our app. We want our data models to be super fast and we also want them to be thread safe because we gonna use them into actors, classes, and across different threads
2. Views
Ex:- Struct, Enum, Tuples, Swift standard data types (Int, Float, String, Array, Dictionary, Set)
When you mutate a struct object you are actually creating an new object by getting rid of the old object
Ex: 1
struct MyStruct {
    var title: String
}

var objectA = MyStruct(title: "Object A")
objectA.title = "New Object A" // Mutating the struct by changing the variable title hence declared the objectA as 
variable.

Ex: 2
struct MutatingStruct {
    private(set) var title: String // Here if you make the property as private(set) the init will become private hence we
need to explicitly create the init. Here we are restricting the user to set the title property outside this struct
scope. If he wants to update he can only do with updateTitle method.
    
    init(title: String) {
        self.title = title
    }

    // mutating creates an entire new object with the newTitle
    mutating func updateTitle(newTitle: String) {
        title = newTitle
    }
}
var objectB = MutatingStruct(title: "Object B")
objectB = objectB.updateTitle(newTitle: "New Object B") // Mutating the struct by changing the
variable title hence declared the objectA as variable.

# Class - Reference Types - Stored in Heap - Not Thread Safe
- Class instance is synchronized across all threads
- Classes are used for
1. ViewModels
Ex: Class, functions, Actor
class MyClass {
    var title: String
}

let objectC = MyClass(title: "Object C")
objectC.title = "New Object C" // Here we are not mutating the objectB but changing the property value inside the class
hence the objectB is declared as constant.

# Actor - Reference Types - Stored in Heap - Thread Safe
- We need to await when we try to access or modify properties of an actor
- Actors are used for
1. Shared 'Manager' - If shared classes are accessed from mutliple places in our code then use actors
2. 'Data Store'
