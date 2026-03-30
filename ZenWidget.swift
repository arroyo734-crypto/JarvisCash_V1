import SwiftUI
import WidgetKit

struct ZenWidgetEntry: TimelineEntry {
    let date: Date
    let quote: String
}

struct ZenWidgetEntryView : View {
    var entry: ZenWidgetEntry
    var body: some View {
        VStack {
            Text('FOCUS').font(.caption).foregroundColor(.secondary)
            Text(entry.quote).font(.system(size: 14, weight: .medium)).padding(4)
        }
    }
}

@main
struct ZenWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: 'ZenWidget', provider: Provider()) { entry in
            ZenWidgetEntryView(entry: entry)
        }.supportedFamilies([.systemSmall])
    }
}

struct Provider: TimelineProvider {
    func placeholder(in c: Context) -> ZenWidgetEntry { ZenWidgetEntry(date: Date(), quote: 'Stay Present.') }
    func getSnapshot(in c: Context, completion: @escaping (ZenWidgetEntry) -> ()) { completion(ZenWidgetEntry(date: Date(), quote: 'Stay Present.')) }
    func getTimeline(in c: Context, completion: @escaping (Timeline<ZenWidgetEntry>) -> ()) { completion(Timeline(entries: [ZenWidgetEntry(date: Date(), quote: 'Deep Work.')], policy: .atEnd)) }
}