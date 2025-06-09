import Foundation

/// Logger that only works in DEBUG builds for observability
/// Logs are automatically disabled in release builds
struct Logger {
    
    static func error(_ message: String, file: String = #file, function: String = #function) {
        #if DEBUG
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        print("❌ [\(fileName):\(function)] \(message)")
        #endif
    }
    
    static func network(_ message: String, file: String = #file, function: String = #function) {
        #if DEBUG
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        print("🌐 [\(fileName):\(function)] \(message)")
        #endif
    }
    
    static func success(_ message: String, file: String = #file, function: String = #function) {
        #if DEBUG
        let fileName = URL(fileURLWithPath: file).lastPathComponent
        print("✅ [\(fileName):\(function)] \(message)")
        #endif
    }
}
