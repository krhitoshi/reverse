[![Gem Version](https://badge.fury.io/rb/reverse.png)](http://badge.fury.io/rb/reverse)

# Reverse

reverse DNS lookup CLI for standard output

## Installation

    $ gem install reverse

## Usage

    $ cat /var/log/maillog | reverse
    $ tail -f /var/log/maillog | reverse
    $ grep Accepted /var/log/secure | reverse

