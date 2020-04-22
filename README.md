# SOS Product API

- [SOS Product API](#sos-product-api)
- [Generals](#generals)
  - [Hello World](#hello-world)
  - [Errors](#errors)
  - [Authentication](#authentication)
  - [Pagination](#pagination)
- [Product](#product)
  - [Overview](#overview)
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
**200 - OK**
Everything worked as expected.

**400 - Bad Request**
The request was unacceptable, often due to missing a required parameter.

**401 - Unauthorized**
No valid API key provided.

**402 - Request Failed**
The parameters were valid but the request failed.

**403 - Forbidden**
The API key doesn't have permissions to perform the request.

**404 - Not Found**
The requested resource doesn't exist.

**409 - Conflict**
The request conflicts with another request (perhaps due to using the same idempotent key).

**429 - Too Many Requests**
Too many requests hit the API too quickly. We recommend an exponential backoff of your requests.

**500, 502, 503, 504 - Server Errors**
Something went wrong on Stripe's end. (These are rare.)

## Authentication
To be updated

## Pagination
To be updated

# Product
## Overview
Product api has the following endpoints:
```
GET    /api/v1/products
GET    /api/v1/products/:id
GET    /api/v1/users/:user_id/products
POST   /api/v1/users/:user_id/products
PATCH  /api/v1/users/:user_id/products/:id
PUT    /api/v1/users/:user_id/products/:id
DELETE /api/v1/users/:user_id/products/:id
```

## The Product Object
### Attributes
* **id** integer: ID of the product

* **title** string: Title of the product

* **user_id** integer: Owner's id of the product

* **long_desc** text: Product's description (text only)

* **price** float: Product's price

* **stock** integer: The number of product in stock

* **sold_quantity** integer: The number of sold products (all time)

* **created_at** datetime: Datetime when first created

* **updated_at** datetime: Datetime when last updated

## Retrieve a product

### Get a product with a paticular `id`

```
GET /api/v1/products/:id
```

**Returns** a product with given `id` (e.g. `id` = 8):

```
{
    "id": 8,
    "title": "Product one of user 1",
    "user_id": 1,
    "long_desc": "This is my product one of user 1.",
    "price": 50.0,
    "stock": 300,
    "sold_quantity": 10,
    "created_at": "2020-04-19T14:01:48.807Z",
    "updated_at": "2020-04-19T14:01:48.807Z"
}
```

## Create a product

```
POST /api/v1/users/:user_id/products
```

### POST Request (JSON)

Example: `POST /api/v1/users/2/products`
```
{
	"product": {
		"title": "New product title of user 2",
		"long_desc": "This is description of the product",
		"price": "This is a price of the product",
		"stock": 20
	}
}
```

### Response

Returns a newly created product if succeeded:
```
{
    "id": 13,
    "title": "New product title of user 2",
    "user_id": 2,
    "long_desc": "This is description of the product",
    "price": 0.0,
    "stock": 20,
    "sold_quantity": null,
    "created_at": "2020-04-22T10:22:56.165Z",
    "updated_at": "2020-04-22T10:22:56.165Z"
}
```

## Delete a product

### DELETE Request
Example: `DELETE /api/v1/users/2/products/13`

** No body required

### Response

Returns a message if succeeded:
```
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
```
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
        "updated_at": "2020-04-19T14:01:48.807Z"
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
        "updated_at": "2020-04-19T14:01:48.822Z"
    },
    ...
]
```

### Get all products of a particular user (`user_id`)

```
GET /api/v1/users/:user_id/products
```

**Returns** a list of products of a given `user_id` (e.g. `user_id` = 1):
```
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
        "updated_at": "2020-04-19T14:01:48.807Z"
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
        "updated_at": "2020-04-19T15:50:49.029Z"
    }
]
```
