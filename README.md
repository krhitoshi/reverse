[![Gem Version](https://badge.fury.io/rb/reverse.png)](http://badge.fury.io/rb/reverse)

# Reverse

reverse DNS lookup CLI for standard output

## Installation

    $ gem install reverse

## Usage

```
Usage: reverse [options]
    -V, --verion                     Show version number and quit
    -v, --verbose                    Verbose Mode (IP Address with reverse DNS)
        --no-color                   No Color Mode
```

    $ cat /var/log/maillog | reverse
    $ tail -f /var/log/maillog | reverse
    $ grep Accepted /var/log/secure | reverse -V

