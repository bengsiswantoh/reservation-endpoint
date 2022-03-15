# RESERVATION

## DESCRIPTION

This API accepts two types of payload. Payload saved in Reservation model and Guest model.

Guest data is updated if the guest's email exists on the database.

Reservation data is updated if the reservation's code exists on the database.

## SETUP

Clone this repository.

```sh
git clone https://github.com/bengsiswantoh/reservation-endpoint.git
```

Open the directory.

```sh
cd reservation-endpoint
```

Install ruby gems.

```sh
bundle
```

Create the database.

```sh
bin/rails db:create
```

Migrate the database.

```sh
bin/rails db:migrate
```

Run the server.

```sh
bin/rails server
```

## Send data

Using payload 1

```sh
curl --location --request POST 'localhost:3000/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "reservation_code": "YYY12345678",
    "start_date": "2021-04-14",
    "end_date": "2021-04-18",
    "nights": 4,
    "guests": 4,
    "adults": 2,
    "children": 2,
    "infants": 0,
    "status": "accepted",
    "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woordbridge@bnb.com"
    },
    "currency": "AUD",
    "payout_price": "4200.00",
    "security_price": "500",
    "total_price": "4700.00"
}'
```

Using payload 2

```sh
curl --location --request POST 'localhost:3000/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "reservation": {
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
        },
        "guest_email": "wayne_woordbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
            "639123456789",
            "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00"
    }
}'
```
