/*
    Shell Interaction
*/
import Foundation

let path = CommandLine.arguments.count >= 2 ? CommandLine.arguments[1] : "./Sources"
let packageName = try PackageParser(path: "./Package.swift").parsePackageName()

@discardableResult
func shell(_ launchpath: String, _ args: [String]?) -> Int32 {
    let task = Process()
    task.launchPath = launchpath
    
    if let _args = args, _args.count > 0 {
        task.arguments = args
    }
    
    task.launch()
    task.waitUntilExit()

    return task.terminationStatus
}

func relaunch() {
    shell("/usr/local/bin/swift", ["build"])
    shell("./.build/debug/\(packageName)", nil)
}

/*
    SKQueue Watching
*/
import SKQueue

class Watcher: SKQueueDelegate {
    func receivedNotification(queue: SKQueue, _ notificationName: SKQueueNotificationString, forPath path: String) {
        print("\(notificationName.rawValue) @ \(path)")
        
        relaunch()
    }
}

if let queue = SKQueue() {
    print("Started Swiftmon for package \(packageName)")
    
    let delegate = Watcher()
    
    queue.delegate = delegate
    
    if FileManager.default.fileExists(atPath: path) {
        queue.addPath(path)
        print("Watching \(path)")
    }
    
    if FileManager.default.fileExists(atPath: "./main.swift") {
        queue.addPath("./main.swift")
        print("Watching ./main.swift")
    }
    
    relaunch()
}

/*
    Run Loop
*/

let runLoop = RunLoop()
let date = Date(timeIntervalSinceNow: 2)

RunLoop.main.run()
