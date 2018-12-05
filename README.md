# mercedes

<img src="https://user-images.githubusercontent.com/204811/49523343-dc100900-f8a9-11e8-86ff-f1a89e630c8f.png" width="500" alt="Mercedes-Benz logo">

This gem is a Ruby client for interacting with Mercedes-Benz Connected Vehicle API. This API allows to access to relevant information about Mercedes-Benz vehicles and also modify its state such as locking/unlocking doors.

Notice that this API is still experimental. You can find out more information at: https://developer.mercedes-benz.com/apis/connected_vehicle_experimental_api/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mercedes'
```

or install it yourself as:

    $ gem install mercedes

## Usage

### Initializing a client

The client can be configured globally:

```ruby
Mercedes.configure do |config|
  config.token = '7dca6d45-0415-4732-a93d-d3514e2c8605'
end

Mercedes::Client.new
```

or by instance:

```ruby
Mercedes::Client.new(token: '7dca6d45-0415-4732-a93d-d3514e2c8605')
```

### Client methods

Clients methods returns a `Mercedes::Response` object. This kind of objects contain methods to get the status of the request (ie: `#ok?`, `#created?`, ...) and a method called `#json` which returns a JSON representation of the response.

#### Vehicle
##### #vehicles

It lists the available vehicles associated to the account, including their `id` (useful for retrieving other information), license plate number and VIN number

```ruby
client.vehicles.json
```

Response
```ruby
[
  {
    'id' => 'AA178E8213TBC9CABA',
    'licenseplate' => '8594FNC',
    'finorvin' => '1HM5F7F9XHD7C0861'
  }
]
```

##### #vehicle(vehicle_id)
It returns relevant information about a specific vehicle

```ruby
client.vehicle("AA178E8213TBC9CABA").json
```

Response
```ruby
{
  'id' => 'AA178E8213TBC9CABA',
  'licenseplate' => '8594FNC',
  'salesdesignation' => 'A Klass W177',
  'finorvin' => '1HM5F7F9XHD7C0861',
  'nickname' => 'mmueller',
  'modelyear' => '2018',
  'colorname' => 'black',
  'fueltype' => 'Benzin',
  'powerhp' => '163',
  'powerkw' => '122',
  'numberofdoors' => '5',
  'numberofseats' => '5'
}
```

#### Charge status

##### #charge(vehicle_id:)

It returns vehicle charge information

```ruby
client.charge(vehicle_id: 'ABCD123').json
```

Response
```ruby
{
  'stateofcharge' => {
    'value' => 80,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019051,
    'unit' => 'PERCENT'
  }
}
```

#### Doors handling

##### #doors(vehicle_id:)

It returns vehicle doors status information

```ruby
client.doors(vehicle_id: 'ABCD123').json
```

Response
```ruby
{
  'doorstatusrearleft' => {
    'value' => 'CLOSED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorlockstatusrearleft' => {
    'value' => 'LOCKED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorstatusrearright' => {
    'value' => 'CLOSED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorlockstatusrearright' => {
    'value' => 'LOCKED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorstatusfrontright' => {
    'value' => 'CLOSED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorlockstatusfrontright' => {
    'value' => 'LOCKED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorstatusfrontleft' => {
    'value' =>' CLOSED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorlockstatusfrontleft' => {
    'value' => 'LOCKED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorlockstatusdecklid' => {
    'value' =>'UNLOCKED',
    'retrievalstatus'  => 'VALID',
    'timestamp' => 1544018685
  },
  'doorlockstatusgas' => {
    'value' => 'UNLOCKED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  },
  'doorlockstatusvehicle' => {
    'value' => 'LOCKED',
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544018685
  }
}
```

##### #lock_doors(vehicle_id:)

It locks vehicle doors

```ruby
client.lock_doors(vehicle_id: 'ABCD123').ok?
#=> true
```

##### #unlock_doors(vehicle_id:)

It unlocks vehicle doors

```ruby
client.unlock_doors(vehicle_id: 'ABCD123').ok?
#=> true
```

#### Fuel status

##### #fuel(vehicle_id:)

It returns vehicle fuel information

```ruby
client.fuel(vehicle_id: 'ABCD123').json
```

Response
```ruby
{
  'fuellevelpercent' => {
    'value' => 80,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019329,
    'unit' => 'PERCENT'
  }
}
```

#### Location
##### #location(vehicle_id:)

It returns current vehicle location

```ruby
client.location(vehicle_id: 'ABCD123').json
```

Response
```ruby
{
  'longitude' => {
    'value' => 13.381815,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019449
  },
  'latitude' => {
    'value' => 52.516506,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019449
  },
  'heading' => {
    'value' => 52.520008,
    'retrievalstatus' => 'VALID',
    'timestamp' =>1544019449
  }
}
```

#### Odometer
##### #odometer(vehicle_id:)

It returns relevant vehicle information such as mileage

```ruby
client.odometer(vehicle_id: 'ABCD123').json
```

Response
```ruby
{
  'odometer' => {
    'value' => 3000,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019575,
    'unit' =>'KILOMETERS'
  },
  'distancesincereset' => {
    'value' => 1234,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019575,
    'unit' => 'KILOMETERS'
  },
  'distancesincestart' => {
    'value' => 276,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019575,
    'unit' => 'KILOMETERS'
  }
}
```

#### Tires status
##### #tires(vehicle_id:)

It returns vehicle tires information

```ruby
client.tires(vehicle_id: 'ABCD123').json
```

Response
```ruby
{
  'tirepressurerearleft' => {
    'value' => 230,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019784,
    'unit' => 'KILOPASCAL'
  },
  'tirepressurerearright' => {
    'value' => 230,
    'retrievalstatus' =>'VALID',
    'timestamp' => 1544019784,
    'unit' => 'KILOPASCAL'
  },
  'tirepressurefrontright' => {
    'value' => 230,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019784,
    'unit' => 'KILOPASCAL'
  },
  'tirepressurefrontleft' => {
    'value' => 231,
    'retrievalstatus' => 'VALID',
    'timestamp' => 1544019784,
    'unit' => 'KILOPASCAL'
  }
}
```

### Client errors

`Mercedes::Client` methods can raise several exceptions when performing requests:

* `Mercedes::Client::CarNotAvailable`: Car is not available because it is not connected to the simulator. In order to fix that, go to https://car-simulator.developer.mercedes-benz.com
* `Mercedes::Client::Unauthorized`:  Request is not properly authenticated
* `Mercedes::Client::ServerError`:  Mercedes API is not responding
* `Mercedes::Client::NotFound`: Resource is not found (`404`)

### How to retrieve the authentication token

Mercedes API is secured with OAuth 2. `Mercedes::Client` need a valid access token to be able to perform requests against Mercedes API.

You can get a Client ID and a Client Secret at https://developer.mercedes-benz.com/console

Then you need to follow the OAuth workflow as described at: https://developer.mercedes-benz.com/content-page/oauth-documentation#_authorization_code_flow

Alternatively, this repository contains a small utility which can help to retrieve the access token.

You can either pass `CLIENT_ID` and `CLIENT_SECRET` as environment vars or just insert them when the script ask for them:

```shell
./bin/get_token
```

or

```shell
CLIENT_ID=**** CLIENT_SECRET=**** ./bin/get_token
```

The script will open the browser where you will need to sign in by using your Mercedes account. Mercedes site will redirect you to something like:

```
http://localhost/?code=355c72c1-821c-4378-88f0-2230a361d599
````

That URL contains the `code` that you need to insert back into the script. Then you will obtain the `access_token`:

```js
{
  "access_token":"91890431-0cf8-433f-8c68-64727db14554",
  "token_type":"Bearer",
  "expires_in":3600,
  "refresh_token":"ede733e3-d076-4cb0-89f1-48568ae9c21e",
  "scope":"mb:vehicle:status:general mb:user:pool:reader"
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alfonsojimenez/mercedes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
