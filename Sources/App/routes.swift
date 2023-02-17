import Fluent
import Vapor

func readText() -> String {
  return Files.readTextFile("test.txt")
}

func routes(_ app: Application) throws {
  app.get { req async throws in
    try await req.view.render("index", ["title": "Hello Vapor!"])
  }

  app.get("hello") { _ async -> String in
    "Hello, world!"
  }

  app.get("test") { _ async throws -> String in
    let res = readText()

    return res
  }

  try app.register(collection: TodoController())
}
