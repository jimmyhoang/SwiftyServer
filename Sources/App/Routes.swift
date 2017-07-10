import Vapor

extension Droplet {
    func setupRoutes() throws {
        
        let store = Store()
        
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        get("upcase") { req in
            
            guard let word = req.data["word"]?.string else { return "Could not grab the name" }
            
            return word.uppercased()
        }
        
        post("user") { req in
            guard let name = req.data["name"]?.string else { return "Could not grab the name" }
            
            return "Hello, \(name)"
        }
        
        post("store") { req in
            guard let key = req.data["key"]?.string else { return "Could not grab the key" }
            guard let value = req.data["value"]?.string else { return "Could not grab value" }
            
            store.set(key: key, value: value)
            
            return "saved!"
        }
        
        get("lookup") { req in
            guard let key = req.data["key"]?.string else { return "Could not grab key" }
            
            guard let value = store.get(key: key) else { return "Not valid key"}
            
            return value
        }
        
        get("retrieve") { req in
            var json = JSON()
            
            
            guard let dict = store.allItems() else { return "No items to show" }
            
            for item in dict {
                try json.set(item.key, item.value)
            }
            
            return json
            
        }
        
        
        try resource("posts", PostController.self)
    }
}
