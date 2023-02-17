import Foundation
import Vapor

#if os(Linux)
  import Glibc
#else
  import Darwin.C
#endif

let IMAGES_DIR_PATH = "Resources/Images"

public struct Files {

  public static func getDirectory() -> String {
    let cwd = getcwd(nil, Int(PATH_MAX))

    defer {
      if let cwd = cwd {
        free(cwd)
      }
    }

    let workingDirectory: String

    if let cwd = cwd, let string = String(validatingUTF8: cwd) {
      workingDirectory = string
    } else {
      workingDirectory = "./"
    }

    return workingDirectory
  }

  public static func readTextFile(_ filename: String) -> String {
    let dir = getDirectory()
    let fullPath = "\(dir)/\(IMAGES_DIR_PATH)/\(filename)"

    let contents = {
      do {
        print(fullPath)
        return try String(contentsOfFile: fullPath, encoding: .utf8)
      } catch {
        print("Error reading file: \(error)")
        return ""
      }
    }()

    print(contents)

    return dir
  }
}
