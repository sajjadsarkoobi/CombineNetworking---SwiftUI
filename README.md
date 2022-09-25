
# Generic Combine Networking Layer

This project is a generic networking layer using `combine` and sample code in SwiftUI.
Based APIClient class written by [Daniel Bernal](https://danielbernal.co/writing-a-networking-library-with-combine-codable-and-swift-5/), I expand his work. Thanks to him :)


### Check it on my Youtube Channel [SwiftAcademy](https://youtu.be/_q_HFGfhpEI):
<div align="left">
      <a href="https://youtu.be/_q_HFGfhpEI">
         <img src="https://img.youtube.com/vi/_q_HFGfhpEI/0.jpg" style="width:100%;">
      </a>
</div>


## Main classes
- APIClient
- APIRouter
- APIParameters
- APIConstants

## Features

- Combine 
- Native URLsession with Publisher
- Network Request on background thread
- Response on main thread
- Log Network activity in console
- APIParams as Struct
- Supporting GET, POST, PUT, DELETE as HTTPMethods


## How to use:

With this approach, you can have a clean networking layer added once and reuse it in the entire application.
simply you can add all your endpoints regarding their request methods inside the `APIRouter` and add their parameters inside the `APIParameter`
to call and receive data.

### APIClient:
You can use this class as it is. It does not need you to change anything inside it unless you want to improve it.


### APIParameters:
All parameters will go there.

 `Query strings` for GET method and `Body` for Post method

All you have to do is to create a struct based on parameters that you have to send with your request that conform to `DictionaryConvertor` and pass it inside the `APIRouter`


### APIRouter:
In `APIRouter` class, you can create as many requests as your project has based on a clean struct that conforms to `Request` protocol

Sample GET request with query params:
```swift
    // GET Request
    struct GetProducts: Request {
        typealias ReturnType = ProductsModel
        var path: String = "/products"
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?
        init(queryParams: APIParameters.ProductParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
```

Sample POST request with body params:
```swift
    struct AddProduct: Request {
        typealias ReturnType = AddedProductModel
        var path: String = "/products/add"
        var method: HTTPMethod = .post
        var body: [String : Any]?
        init(body: APIParameters.AddProductParams) {
            self.body = body.asDictionary
        }
    }
```


### APIConstants:
You can store all constants related to the server or call your endpoints here. 
Even you can store some sensitive data in keychain, restore them inside this class, and then pass it to APIClient.


## Call endPoint:
This is a sample usage inside the viewModel class.
Don't forget to store response in `cancelable`
```swift
    @Published var products: [ProductModel] = []
    var cancelable: Set<AnyCancellable> = []

    //GET Method
    func getProducts() {
        APIClient.dispatch(
            APIRouter.GetProducts(queryParams:
                                    APIParameters.ProductParams(skip: 1, limit: 10)))
        .sink { _ in }
        receiveValue: { [weak self] products in
            self?.products = products.products
        }.store(in: &cancelable)
    }
```
### Bonus:
You can find a `Log.swift` file in code that can use in entire application.
it support 3 types of logs:
- Alert
- Info
- Warning
it shows the class name and line of code with Function name that you put the log there.
Like this:
```
[❌ ALERT] (Your log message) in APIClient.swift: 150 dispatch(request:)
```

it only prints logs if we are developing not in production release.
```
        #if DEBUG
        print(fullString)
        #endif
```
## Author:

- [@Sajjad Sarkoobi](https://www.github.com/sajjadsarkoobi)
- [LinkedIn](https://www.linkedin.com/in/sajjad-sarkoobi/)
- sajjadsarkoobi@gmail.com

