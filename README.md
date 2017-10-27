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

#### example

```rb:app/processors/article_processor.rb
class ArticleProcessor < Handsaw::BaseProcessor
end
```

### 2. Convert DSL using your defined `processor`

```rb
processor = ArticleProcessor.new

text =<<EOS
checkpoint:
  title:
    TITLE
  message:
    MESSAGE

{red: decorated_text}

[blue: decorated_link_label](link)
EOS

processor.render text
```

```html
<div class="pa-checkBox" style="">
  <div class="pa-checkBox__content">
    <div class="title"><p class="pa-text">TITLE</p></div>
    <div class="message"><p class="pa-text">MESSAGE</p></div>
  </div>
</div>

<p class="pa-text"><span class="red">decorated_text</span></p>
<p class="pa-text"><a href="link" class="blue">decorated_link_label</a></p>
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
