import Foundation

enum AppPaths {
    static var supportDirectory: URL {
        let base = FileManager.default.urls(
            for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let directory = base.appendingPathComponent("Murmur", isDirectory: true)

        // One-time migration from the app's pre-rename data folder, so
        // history, dictionary, snippets and scratchpad survive.
        let legacy = base.appendingPathComponent("WhisperFlow", isDirectory: true)
        if !FileManager.default.fileExists(atPath: directory.path),
           FileManager.default.fileExists(atPath: legacy.path) {
            try? FileManager.default.moveItem(at: legacy, to: directory)
        }

        try? FileManager.default.createDirectory(
            at: directory, withIntermediateDirectories: true)
        return directory
    }
}
