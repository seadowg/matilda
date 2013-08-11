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

Here's an example of a program that reverse sorts numbers the user inputs
written using matilda:

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

So this:

    > 5,2,79,23,4
    [79, 23, 5, 4, 2]
