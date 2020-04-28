# SOS Product API

- [SOS Product API](#sos-product-api)
- [Generals](#generals)
  - [Hello World](#hello-world)
  - [Errors](#errors)
  - [Authentication](#authentication)
  - [Pagination](#pagination)
- [Product](#product)
  - [Product Overview](#product-overview)
  - [The Product Object](#the-product-object)
    - [Attributes](#attributes)
  - [Retrieve a product](#retrieve-a-product)
    - [Get a product with a paticular `id`](#get-a-product-with-a-paticular-id)
  - [Create a product](#create-a-product)
    - [POST Request (JSON)](#post-request-json)
    - [Response](#response)
  - [Delete a product](#delete-a-product)
    - [DELETE Request](#delete-request)
    - [Response](#response-1)
  - [List of all products](#list-of-all-products)
    - [Get all products](#get-all-products)
    - [Get all products of a particular user (`user_id`)](#get-all-products-of-a-particular-user-userid)
    - [Get all products of a particular category (`category_id`)](#get-all-products-of-a-particular-category-category_id)
- [Category](#category)
    - [Category Overview](#category-overview)
    - [Retrieve Category Tree](#retrieve-category-tree)
    - [Retrieve Category by ID](#retrieve-category-by-id)

# Generals

## Hello World
Our sos product endpoint is located at:
```
https://sos-products.herokuapp.com/
```
You can try send a `GET` request to the endpoint. You should see the following JSON message:
```
"Welcome to the API"
```
If you look at the header, you should see that the content-type is json:
```
Content-Type: application/json
```

## Errors

| Code | Meaning |Description |
|------|---------|-------------|
|**200**|OK |Everything worked as expected. |
|**400**| Bad Request |The request was unacceptable, often due to missing a required parameter. |
|**401**| Unauthorized |No valid API key provided.|
|**40**| Request Failed |The parameters were valid but the request failed.|
|**40**| Forbidden|The API key doesn't have permissions to perform the request.|
|**40**| Not Found|The requested resource doesn't exist.|
|**40**| Conflict|The request conflicts with another request (perhaps due to using the same idempotent key).|
|**42**| Too Many Requests|Too many requests hit the API too quickly. We recommend an exponential backoff of your requests.|
|**500, 502, 503, 504**| Server Errors|Something went wrong on server's end. (These are rare.)|

## Authentication
To be updated

## Pagination
To be updated

# Product
## Product Overview
Product api has the following endpoints:

|Method| Endpoint|
|-----|---------------------------------|
GET|    /api/v1/products|
GET|    /api/v1/products/:id|
GET|    /api/vi/categories/:category_id/products|
GET|    /api/v1/users/:user_id/products|
POST|   /api/v1/users/:user_id/products|
PATCH|  /api/v1/users/:user_id/products/:id|
PUT|    /api/v1/users/:user_id/products/:id|
DELETE| /api/v1/users/:user_id/products/:id|

## The Product Object
### Attributes
| Attribute | Type | Description |
|-----------|------|-------------|
|**id** |integer |ID of the product|
|**title** |string |Title of the product|
|**user_id** |integer |Owner's id of the product|
|**long_desc** |text |Product's description (text only)|
|**price** |float |Product's price|
|**stock** |integer |The number of product in stock|
|**sold_quantity** |integer |The number of sold products (all time)|
|**created_at** |datetime |Datetime when first created|
|**updated_at** |datetime |Datetime when last updated|
|**categories** |object | Categories tree (including subcategory). |

## Retrieve a product

### Get a product with a paticular `id`

```
GET /api/v1/products/:id
```

**Returns** a product with given `id` (e.g. `id` = 8):

```json
{
    "id": 8,
    "title": "Product one of user 1",
    "user_id": 1,
    "long_desc": "This is my product one of user 1.",
    "price": 50.0,
    "stock": 300,
    "sold_quantity": 10,
    "created_at": "2020-04-19T14:01:48.807Z",
    "updated_at": "2020-04-19T14:01:48.807Z",
    "categories": {
        "id": 5,
        "name_en": "Camera & Photo",
        "name_th": "กล้องและอุปกรณ์ถ่ายภาพ",
        "parent_id": null,
        "subcategories": {
            "id": 8,
            "name_en": "CCTV",
            "name_th": "กล้องวงจรปิด",
            "parent_id": 5
        }
    }
}
```

## Create a product

```
POST /api/v1/users/:user_id/products
```

### POST Request (JSON)

Example: `POST /api/v1/users/2/products`
```json
{
	"product": {
		"title": "New product title of user 2",
		"long_desc": "This is description of the product",
		"price": "This is a price of the product",
		"stock": 20,
                "category_id": 8
	}
}
```

### Response

Returns a newly created product if succeeded:
```json
{
    "id": 13,
    "title": "New product title of user 2",
    "user_id": 2,
    "long_desc": "This is description of the product",
    "price": 0.0,
    "stock": 20,
    "sold_quantity": null,
    "created_at": "2020-04-22T10:22:56.165Z",
    "updated_at": "2020-04-22T10:22:56.165Z",
    "categories": {
        "id": 5,
        "name_en": "Camera & Photo",
        "name_th": "กล้องและอุปกรณ์ถ่ายภาพ",
        "parent_id": null,
        "subcategories": {
            "id": 8,
            "name_en": "CCTV",
            "name_th": "กล้องวงจรปิด",
            "parent_id": 5
        }
    }
}
```

## Delete a product

### DELETE Request
Example: `DELETE /api/v1/users/2/products/13`

** No body required

### Response

Returns a message if succeeded:
```json
{
    "message": "Product successfully deleted."
}
```


## List of all products

### Get all products

```
GET /api/v1/products
```

**Returns** a list of products:
```json
[
    {
        "id": 8,
        "title": "Product one of user 1",
        "user_id": 1,
        "long_desc": "This is my product one of user 1.",
        "price": 50.0,
        "stock": 300,
        "sold_quantity": 10,
        "created_at": "2020-04-19T14:01:48.807Z",
        "updated_at": "2020-04-19T14:01:48.807Z",
        "categories": {
            "id": 5,
            "name_en": "Camera & Photo",
            "name_th": "กล้องและอุปกรณ์ถ่ายภาพ",
            "parent_id": null,
            "subcategories": {
                "id": 8,
                "name_en": "CCTV",
                "name_th": "กล้องวงจรปิด",
                "parent_id": 5
            }
        }
    },
    {
        "id": 9,
        "title": "Product one of user 2",
        "user_id": 2,
        "long_desc": "This is my product one of user 2.",
        "price": 30000.0,
        "stock": 20,
        "sold_quantity": 0,
        "created_at": "2020-04-19T14:01:48.822Z",
        "updated_at": "2020-04-19T14:01:48.822Z",
        "categories": {
            "id": 1,
            "name_en": "Bags",
            "name_th": "กระเป๋า",
            "parent_id": null,
            "subcategories": {}
        }
    },
    ...
]
```

### Get all products of a particular user (`user_id`)

```
GET /api/v1/users/:user_id/products
```

**Returns** a list of products of a given `user_id` (e.g. `user_id` = 1):
```json
[
    {
        "id": 8,
        "title": "Product one of user 1",
        "user_id": 1,
        "long_desc": "This is my product one of user 1.",
        "price": 50.0,
        "stock": 300,
        "sold_quantity": 10,
        "created_at": "2020-04-19T14:01:48.807Z",
        "updated_at": "2020-04-19T14:01:48.807Z",
        "categories": {
            "id": 5,
            "name_en": "Camera & Photo",
            "name_th": "กล้องและอุปกรณ์ถ่ายภาพ",
            "parent_id": null,
            "subcategories": {
                "id": 8,
                "name_en": "CCTV",
                "name_th": "กล้องวงจรปิด",
                "parent_id": 5
            }
        }
    },
    {
        "id": 12,
        "title": "Product two of user 1",
        "user_id": 1,
        "long_desc": "This is a product two of user 1",
        "price": 500.0,
        "stock": 19,
        "sold_quantity": null,
        "created_at": "2020-04-19T15:50:49.029Z",
        "updated_at": "2020-04-19T15:50:49.029Z",
        "categories": {
            "id": 5,
            "name_en": "Camera & Photo",
            "name_th": "กล้องและอุปกรณ์ถ่ายภาพ",
            "parent_id": null,
            "subcategories": {
                "id": 8,
                "name_en": "CCTV",
                "name_th": "กล้องวงจรปิด",
                "parent_id": 5
            }
        }
    },
    ...
]
```

### Get all products of a particular category (`category_id`)
**Returns** a list of products of a given `category_id` (e.g. `category_id` = 5):
```json
[
    {
        "id": 8,
        "title": "CCTV Product",
        "user_id": 1,
        "long_desc": "This is a CCTV product",
        "price": 30000,
        "stock": 300,
        "sold_quantity": 10,
        "created_at": "2020-04-19T14:01:48.807Z",
        "updated_at": "2020-04-19T14:01:48.807Z",
        "categories": {
            "id": 5,
            "name_en": "Camera & Photo",
            "name_th": "กล้องและอุปกรณ์ถ่ายภาพ",
            "parent_id": null,
            "subcategories": {
                "id": 8,
                "name_en": "CCTV",
                "name_th": "กล้องวงจรปิด",
                "parent_id": 5
            }
        }
    },
    {
        "id": 18,
        "title": "This is a Digital Camera",
        "user_id": 2,
        "long_desc": "This is a Digital Camera product",
        "price": 400000,
        "stock": 19,
        "sold_quantity": null,
        "created_at": "2020-04-19T15:50:49.029Z",
        "updated_at": "2020-04-19T15:50:49.029Z",
        "categories": {
            "id": 5,
            "name_en": "Camera & Photo",
            "name_th": "กล้องและอุปกรณ์ถ่ายภาพ",
            "parent_id": null,
            "subcategories": {
                 "id": 6,
                 "name_en": "Digital Camera",
                 "name_th": "กล้องดิจิตอล",
                 "parent_id": 5,
                 "subcategories": []
             }
        }
    },
    ...
]
```

# Category

## Category Overview
|Method| Endpoint|
|-----|---------------------------------|
| GET | /api/v1/categories              |
| GET | /api/v1/categories/:id          |

## Retrieve Category Tree
```
GET /api/v1/categories
```

```json
[
    {
        "id": 1,
        "name_en": "Bags",
        "name_th": "กระเป๋า",
        "parent_id": null,
        "subcategories": [
            {
                "id": 2,
                "name_en": "Wallets",
                "name_th": "กระเป๋าสตางค์",
                "parent_id": 1,
                "subcategories": []
            },
            {
                "id": 3,
                "name_en": "Clutches",
                "name_th": "คลัทช์",
                "parent_id": 1,
                "subcategories": []
            },
            ...
        ]
    },
    ...
]
```

## Retrieve Category by ID
```
GET /api/v1/categories/:id          |
```
Retrieving a **parent category** will return the parent with its subcategories:
```json
{
    "id": 1,
    "name_en": "Bags",
    "name_th": "กระเป๋า",
    "parent_id": null,
    "subcategories": [
        {
            "id": 2,
            "name_en": "Wallets",
            "name_th": "กระเป๋าสตางค์",
            "parent_id": 1,
            "subcategories": []
        },
        {
            "id": 3,
            "name_en": "Clutches",
            "name_th": "คลัทช์",
            "parent_id": 1,
            "subcategories": []
        },
        ...
    ]
}
```

Retrieving a **subcategory** will return only the subcategory and its subcategories(if exists):
```json
{
    "id": 2,
    "name_en": "Wallets",
    "name_th": "กระเป๋าสตางค์",
    "parent_id": 1,
    "subcategories": []
}
```

