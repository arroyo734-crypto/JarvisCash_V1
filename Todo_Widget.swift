Here's a raw SwiftUI implementation for a Todo_Widget widget (Today Widget extension):

```swift
import SwiftUI
import WidgetKit
import Intents

// MARK: - Widget Configuration
struct TodoWidgetConfiguration: WidgetConfiguration {
    let numberOfItems: Int
    
    static var defaultWidgetConfiguration: TodoWidgetConfiguration {
        TodoWidgetConfiguration(numberOfItems: 5)
    }
}

// MARK: - Intent Handling
struct AddTodoIntent: Intent {
    static var intentIdentifier: String { "AddTodoIntent" }
    static var title: String { "Add Todo" }
    
    let newTodo: String
    
    init?(for configuration: TodoWidgetConfiguration) {
        self.newTodo = configuration.numberOfItems + 1
    }
    
    func perform() {
        // Handle adding todo in main app
    }
}

// MARK: - Widget Entry View
struct TodoWidgetEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        Group {
            if #available(iOS 17.0, *) {
                if family == .systemSmall {
                    SmallWidgetView()
                } else {
                    LargeWidgetView()
                }
            } else {
                LargeWidgetView()
            }
        }
    }
}

// MARK: - Small Widget (for iPhone XS and later)
struct SmallWidgetView: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("3 items")
                .font(.headline)
            Spacer()
            Text("Tap to add")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .widgetURL(NSURL(string: "widget://add-todo") as? URL)
    }
}

// MARK: - Large Widget (for all other sizes)
struct LargeWidgetView: View {
    var todos: [TodoItem] = [
        TodoItem(id: 1, title: "Buy groceries", completed: false),
        TodoItem(id: 2, title: "Walk the dog", completed: true),
        TodoItem(id: 3, title: "Finish report", completed: false)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(todos, id: \.id) { todo in
                HStack {
                    Circle()
                        .fill(todo.completed ? .green : .gray)
                        .frame(width: 12, height: 12)
                    
                    Text(todo.title)
                        .strikethrough(todo.completed, lineWidth: 1, color: .gray)
                    
                    Spacer()
                    
                    Button(action: {
                        // Handle completion toggle
                    }) {
                        Image(systemName: todo.completed ? "checkmark.circle" : "circle")
                            .symbolRenderingMode(.multicolor)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .widgetURL(NSURL(string: "widget://add-todo") as? URL)
    }
}

// MARK: - Todo Item Model
struct TodoItem: Identifiable {
    let id: Int
    let title: String
    let completed: Bool
}

// MARK: - Widget Configuration Intent
struct TodoWidgetConfigurationIntent: ConfigurationIntent {
    static var title: String { "Todo Widget" }
    
    let widgetConfiguration: TodoWidgetConfiguration
    
    init(widgetConfiguration: TodoWidgetConfiguration) {
        self.widgetConfiguration = widgetConfiguration
    }
}

// MARK: - Widget Configuration IntentUX
struct TodoWidgetConfigurationIntentUX: IntentUX {
    static let numberOfItems = SliderControl<Int>(
        title: "Number of Items",
        description: "How many todo items to show",
        value: .constant(5),
        range: 1...20,
        step: 1
    )
    
    func makeConfigurationIntentUX(
        configuration: WidgetConfiguration,
        size: CGSize
    ) -> some IntentUX {
        guard let widgetConfig = configuration as? TodoWidgetConfiguration else {
            return TodoWidgetConfigurationIntentUX()
        }
        
        return TodoWidgetConfigurationIntentUX(
            widgetConfiguration: TodoWidgetConfiguration(
                numberOfItems: widgetConfig.numberOfItems
            )
        )
    }
}

// MARK: - WidgetBundle
@main
struct Todo_Widget: WidgetBundle {
    init() {
        super.init(views: [
            TodoWidgetEntryView()
        ])
    }
    
    func widgetURLs(configuration: WidgetConfiguration) -> [URL] {
        return [NSURL(string: "widget://add-todo")!]
    }
}

// MARK: - Intent Extension
@main
struct Todo_WidgetIntentExtension: IntentExtension {
    func provideDidUpdate(_ intent: AddTodoIntent) -> some Scene {
        WindowGroup {
            TodoAddIntentView()
        }
    }
}
```

This implementation includes:

1. Widget configuration for customization
2. Small and large widget layouts
3. Interactive elements (checkmark, circle)
4. Strikethrough for completed items
5. Widget intents for adding new todos
6. Support for different widget families
7. Intent extension for handling widget interactions

Note: You'll need to:
1. Add the shared container configuration in your main app
2. Implement the actual data persistence and synchronization
3. Add proper error handling
4. Configure the app groups for data sharing
5. Add the actual intent handler for adding todos

The widget will appear in the Today view of the iPhone/iPad and can be customized through the Home Screen settings.