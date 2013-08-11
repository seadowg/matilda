# matilda

![](http://f.cl.ly/items/3B0p0d1V1g2P2d3W301h/Matilda_Wormwood.jpg)

## Installation

Either include in your Gemfile:

```ruby
gem 'matilda'
```

Or, install for your system:

    > gem install matilda

## Usage

This gem is intended to provide a suite of features for allowing you to
code in Ruby in a more functional manner. The gems currently included
are:

* [matilda-stream](http://github.com/seadowg/matilda-stream) - A lazy
  Stream implementation.
* [matilda-maybe](http://github.com/seadowg/matilda-maybe) - A Maybe
  monad for use with possibly undefined values.
* [matilda-function](http://github.com/seadowg/matilda-function)
  - Enhancements to Ruby's Proc to allow for composition and infinite recursion.

Here's an example of a program that reverse sorts numbers the user inputs
written using some of matilda's features:

```ruby
require 'matilda-stream'
require 'matilda-maybe'
require 'matilda-function'

module SafeIO
  READ_LINE = proc {
    begin
      Just.new(gets)
    rescue
      Nothing.new()
    end
  }

  PRINT = proc { |value|
    begin
      puts value.inspect
      Just.new(nil)
    rescue
      Nothing.new
    end
  }
end

split_to_ints = proc { |input| input.split(',').map(&:to_i) }
reverse_sort = proc { |arr| arr.sort.reverse }
present = proc { |line| line.get("") } << split_to_ints << reverse_sort << SafeIO::PRINT

input_stream = Stream.continually(&SafeIO::READ_LINE)
input_stream.each(&present)
```

So, basically, it does this:

    > 5,2,79,23,4
    [79, 23, 5, 4, 2]
