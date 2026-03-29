import Foundation
import SQLite
class DatabaseManager: ObservableObject { static let shared = DatabaseManager(); private var db: Connection?; init() { do { let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!; db = try Connection(\"\(path)/db.sqlite3\"); try db?.run(Table(\"revenue\").create(ifNotExists: true) { t in t.column(Expression<Int64>(\"id\"), primaryKey: .autoincrement); t.column(Expression<Double>(\"amount\")) }) } catch { print(\"DB Error: \(error)\") } } }
