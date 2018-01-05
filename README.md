# BitsDealer

BitsDealer is a command line interface that helps you to manage your bitso account, like buy coins, sell them, check ticks or your orders,
it makes use of [Bitsor](https://github.com/rodacato/bitsor) gem, a Bitso V3 API.

## Installation

Simply run the following command to install it on your current ruby version (2.4.2 is recommended)

```ruby
gem install bits_dealer
```

Once you install the gem, run the command `bits_dealer` to setup you account, you will need your client_id aswell as the API keys.

The configuration steps will ask you for a password to encrypt all you information on your home folder, and ask you again each time you open
the terminal, all this for security reasons.

## Usage

BitsDealer support the following actions:

```
balance
books
cancel_order
new_order
open_order
tickers
help / ?
exit / quit
```

You can call them manually from the console after execute `bits_dealer` or through the help menu.

### Tips

Type `?` to access the quick menu

Type `quit` or `exit` to close the session

If you dont want to perform the command you can cancel it with `CTRL + c`.

## Development

After checking out the repo, run rake install to intall this gem locally,

then open it from the executables folder `exe/bits_dealer`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rodacato/bits_dealer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
