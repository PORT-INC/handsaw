# Handsaw
Handsaw is a new lightweight markup language made in Ruby, and has the following features.

* Its syntax is affected by markdown and slim.
* Implemented in Ruby.
* Easy to define your own notation.

You can check basic conversion rules on the demo site below.

[Handsaw-Demo](https://ancient-anchorage-59376.herokuapp.com/)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'handsaw', github: 'PORT-INC/handsaw'
```

And then execute:
```bash
$ bundle
```

# Usage

## Summary

### 1. Define the `processor` to convert your DSL

Define your own processor to convert the DSL under `app/processors`.
Your processor has to inherit `Handsaw::BaseProcessor` and its class name must be in the format `XXXXProcessor`.

#### exsample

```rb:app/processors/article_processor.rb
class ArticleProcessor < Handsaw::BaseProcessor
end
```


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
