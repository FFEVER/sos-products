# SOS Product API

- [SOS Product API](#sos-product-api)
- [Generals](#generals)
  - [Hello World](#hello-world)
  - [Errors](#errors)
  - [Authorization](#authorization)
  - [Pagination](#pagination)
- [Product](#product)
  - [Product Overview](#product-overview)
  - [The Product Object](#the-product-object)
  - [Retrieve a product](#retrieve-a-product)
    - [Get a product with a paticular `id`](#get-a-product-with-a-paticular-id)
  - [Create a product](#create-a-product)
    - [POST Request (JSON)](#post-request-json)
    - [Created Response](#created-response)
  - [Update a product](#update-a-product)
    - [PUT Request (JSON)](#put-request-json)
    - [Updated Response](#updated-response)
  - [Delete a product](#delete-a-product)
    - [DELETE Request](#delete-request)
    - [Deleted Response](#deleted-response)
  - [List of all products](#list-of-all-products)
    - [Get all products](#get-all-products)
    - [Get all products of a particular user (`user_id`)](#get-all-products-of-a-particular-user-user_id)
    - [Get all products of a particular category (`category_id`)](#get-all-products-of-a-particular-category-category_id)
  - [Checkout a product](#checkout-a-product)
- [Category](#category)
    - [The Category Object](#the-category-object)
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
|**200**| OK |Everything worked as expected. |
|**201**| Created |The resource was successfully created. |
|**400**| Bad Request |The request was unacceptable, often due to missing a required parameter. |
|**401**| Unauthorized |No valid API key provided.|
|**402**| Request Failed |The parameters were valid but the request failed.|
|**403**| Forbidden |The API key doesn't have permissions to perform the request.|
|**404**| Not Found |The requested resource doesn't exist.|
|**409**| Conflict |The request conflicts with another request (perhaps due to using the same idempotent key).|
|**429**| Too Many Requests |Too many requests hit the API too quickly. We recommend an exponential backoff of your requests.|
|**500, 502, 503, 504**| Server Errors |Something went wrong on server's end. (These are rare.)|

## Authorization
Each request require JWT token received from **SOS Authentication service**.
Only `admin` can use the following endpoints:

|Method| Endpoint| Description |
|-----|----------|-----------------------|
|GET|    /api/v1/users/:user_id/products| Get all products of a particular user(admin) [[example]](#get-all-products-of-a-particular-user-user_id) |
|POST|   /api/v1/users/:user_id/products| Create a product [[example]](#create-a-product) |
|PATCH|  /api/v1/users/:user_id/products/:id| Update a product [[example]](#update-a-product) |
|PUT|    /api/v1/users/:user_id/products/:id| Update a product [[example]](#update-a-product) |
|DELETE| /api/v1/users/:user_id/products/:id| Delete a product [[example]](#delete-a-product) |


## Pagination
Supported endpoints:

|Method| Endpoint| Description |
|-----|----------|-----------------------|
|GET|    /api/v1/products| Get all products [[example]](#get-all-products) |
|GET|    /api/vi/categories/:category_id/products| Get all products of a particular category [[example]](#get-all-products-of-a-particular-category-category_id) |
|GET|    /api/v1/users/:user_id/products| Get all products of a particular user [[example]](#get-all-products-of-a-particular-user-user_id) |

**Usage:**

- Add a query parameter called `page` to get products from the given page number.
- If no `page` given, it will return result from default `page=1`.
- Default limit products per page is **15**

**Example:**

```
GET /api/v1/products?page=1
```

**Response**

```json
{
    "products": [
        {
            "id": 5,
            "title": "New product title",
            "user_id": 1,
            "long_desc": "This is description of the product",
            "price": 18.9,
            "stock": 87,
            "sold_quantity": 3,
            "created_at": "2020-05-03T16:36:35.161Z",
            "updated_at": "2020-05-03T16:37:19.929Z",
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
    ],
    "current_page": 1,
    "total_pages": 1,
    "total_products": 3,
    "limit_per_page": 15
}
```

# Product
## Product Overview
Product api has the following endpoints:

**User Endponts:**

|Method| Endpoint| Description |
|-----|----------|-----------------------|
|GET|    /api/v1/products| Get all products [[example]](#get-all-products) |
|GET|    /api/v1/products/:id| Get a product with a paticular `id`[[example]](#get-a-product-with-a-paticular-id) |
|POST|   /api/v1/products/:id/checkout | Checkout a product [[example]](#checkout-a-product) |
|GET|    /api/vi/categories/:category_id/products| Get all products of a particular category [[example]](#get-all-products-of-a-particular-category-category_id) |

**Admin Endpoints:**

|Method| Endpoint| Description |
|-----|----------|-----------------------|
|GET|    /api/v1/users/:user_id/products| Get all products of a particular user(admin) [[example]](#get-all-products-of-a-particular-user-user_id) |
|POST|   /api/v1/users/:user_id/products| Create a product [[example]](#create-a-product) |
|PATCH|  /api/v1/users/:user_id/products/:id| Update a product [[example]](#update-a-product) |
|PUT|    /api/v1/users/:user_id/products/:id| Update a product [[example]](#update-a-product) |
|DELETE| /api/v1/users/:user_id/products/:id| Delete a product [[example]](#delete-a-product) |

## The Product Object
### Product Attributes
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
		"price": 29.30,
		"stock": 20,
        "category_id": 8
	}
}
```

### Created Response

Returns a newly created product if succeeded:
```json
{
    "id": 13,
    "title": "New product title of user 2",
    "user_id": 2,
    "long_desc": "This is description of the product",
    "price": 29.30,
    "stock": 20,
    "sold_quantity": 0,
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

## Update a product

### PUT Request (JSON)

Example: `PUT /api/v1/users/1/products/1`
```json
{
    "product": {
        "title": "This is the new Bag title",
        "long_desc": "This is new description of the product",
        "price": 900000,
        "stock": 90,
        "category_id": 1
    }
}
```
**Note**: 
- All of the **attributes** are optional. You can update only a few attributes at a time.
- You don't have to update `created_at` or `updated_at`. The server will handle it automatically.

### Updated Response

Return an updated product on succeeded.

```json
{
    "id": 1,
    "title": "This is the new Bag title",
    "user_id": 1,
    "long_desc": "This is new description of the product",
    "price": 90000.00,
    "stock": 90,
    "sold_quantity": 12,
    "created_at": "2020-04-23T08:41:17.875Z",
    "updated_at": "2020-05-03T15:33:12.843Z",
    "categories": {
        "id": 1,
        "name_en": "Bags",
        "name_th": "กระเป๋า",
        "parent_id": null,
        "subcategories": {}
    }
}
```

## Delete a product

### DELETE Request
Example: `DELETE /api/v1/users/2/products/13`

** No body required

### Deleted Response

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
{
    "products": [
        {
            "id": 1,
            "title": "Coach2020 กระเป๋าหญิงถังกระเป๋าสบายๆ",
            "user_id": 1,
            "long_desc": "คุณสามารถสั่งซื้อโดยตรงและเราจะจัดส่งโดยเร็วที่สุด",
            "price": 50.0,
            "stock": 300,
            "sold_quantity": 10,
            "created_at": "2020-04-30T05:03:57.631Z",
            "updated_at": "2020-04-30T05:03:57.631Z",
            "categories": {
                "id": 117,
                "name_en": "Luggage & Bags",
                "name_th": "กระเป๋าและกระเป๋า",
                "parent_id": null,
                "subcategories": {
                    "id": 118,
                    "name_en": "Women's Bags",
                    "name_th": "กระเป๋าสตรี",
                    "parent_id": 117
                }
            }
        },
        ...
    ],
    "current_page": 1,
    "total_pages": 1,
    "total_products": 4,
    "limit_per_page": 15
}
```

### Get all products of a particular user (`user_id`)

```
GET /api/v1/users/:user_id/products
```

**Returns** a list of products of a given `user_id` (e.g. `user_id` = 1):
```json
{
  "products": [
      {
          "id": 1,
          "title": "Product of user id 1",
          "user_id": 1,
          "long_desc": "Product of user id 1",
          "price": 50.0,
          "stock": 300,
          "sold_quantity": 10,
          "created_at": "2020-04-30T05:03:57.631Z",
          "updated_at": "2020-04-30T05:03:57.631Z",
          "categories": {
              "id": 117,
              "name_en": "Luggage & Bags",
              "name_th": "กระเป๋าและกระเป๋า",
              "parent_id": null,
              "subcategories": {
                  "id": 118,
                  "name_en": "Women's Bags",
                  "name_th": "กระเป๋าสตรี",
                  "parent_id": 117
              }
          }
      },
      {
          "id": 2,
          "title": "Another product of user id 1",
          "user_id": 1,
          "long_desc": "Another product of user id 1",
          "price": 30000.0,
          "stock": 20,
          "sold_quantity": 0,
          "created_at": "2020-04-30T05:03:57.681Z",
          "updated_at": "2020-04-30T05:03:57.681Z",
          "categories": {
              "id": 76,
              "name_en": "Consumer Electronics",
              "name_th": "เครื่องใช้ไฟฟ้า",
              "parent_id": null,
              "subcategories": {
                  "id": 88,
                  "name_en": "360° Video Cameras & Accessories",
                  "name_th": "กล้องวิดีโอ & อุปกรณ์เสริม 360 °",
                  "parent_id": 76
              }
          }
      },
      ...
  ],
  "current_page": 1,
  "total_pages": 1,
  "total_products": 4,
  "limit_per_page": 15
}
```

### Get all products of a particular category (`category_id`)
```
GET /api/vi/categories/:category_id/products
```

**Returns** a list of products of a given `category_id` (e.g. `category_id` = 5):
```json
{
    "products": [
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
            "sold_quantity": 40,
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
    ],
    "current_page": 1,
    "total_pages": 1,
    "total_products": 4,
    "limit_per_page": 15
}
```

## Checkout a product
```
POST /api/v1/products/:id/checkout
```
By calling this endpoint the `sold_quantity` will increase by **given quantity** and `stock` will decrease by a **given quantity**.

**Example**: `POST /api/v1/products/1/checkout` with `json` body:
```json
{
  "quantity": 4
}
```

**Response (success):**

On product id = 1, `sold_quantity` += 4 (from 0) and `stock` -= 4 (from 90)
```json
{
    "id": 1,
    "title": "Bag",
    "user_id": 1,
    "long_desc": "This is new description of the product",
    "price": 90000.0,
    "stock": 86,
    "sold_quantity": 4,
    "created_at": "2020-04-23T08:41:17.875Z",
    "updated_at": "2020-05-03T16:03:50.114Z",
    "categories": {
        "id": 1,
        "name_en": "Bags",
        "name_th": "กระเป๋า",
        "parent_id": null,
        "subcategories": {}
    }
}
```

**Response (failed):**

If `sold_quantity` less than 0 or the parameter `quantity` is invalid, server returns **400 Bad Request** and the following message:
```json
{
    "errors": "Unable to checkout."
}
```




# Category

## Category Overview
|Method| Endpoint| Description |
|-----|----------|-----------------------|
| GET | /api/v1/categories | Retrieve all categories (tree) [[example]](#retrieve-category-tree) |
| GET | /api/v1/categories/:id | Retrieve a category by id [[example]](#retrieve-category-by-id) |

## The Category Object
### Category Attributes
| Attribute | Type | Description |
|-----------|------|-------------|
|**id** |integer |ID of the category|
|**name_en** |string |English name of the category|
|**name_th** |string |Thai name of the category|
|**parent_id** |integer |id of parent category|
|**subcategories** |object | A list of subcategories|

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
GET /api/v1/categories/:id
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

TEST JAAA
