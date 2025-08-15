# Atom

## 概要
Atomic Design の最小のコンポーネント。

Atoms の目的はデザインの統一で、用件は以下
  - プラットフォームのデフォルトUI
  - デザインシステムの基本要素
  - レイアウトパターン
  - セマンティックなデザイン要素

tone and manner の一貫性のために、css要素と一緒にコンポーネント化する

## 命名規則

## 実装
引数とブロック両方で受け取るようにして、[content_tag](https://github.com/rails/rails/blob/984c3ef2775781d47efa9f541ce570daa2434a80/actionview/lib/action_view/helpers/tag_helper.rb#L335) のような呼び出しが分かりやすい。

以下の二つは、同じ結果を返す。
```ruby
render AtomicDesign::Atoms::Badge.new('Hello, World!', class: 'text-primary')
```

```ruby
render AtomicDesign::Atoms::Badge.new(class: 'text-primary') do
  'Hello, World!'
end
```

attr_reader 属性は、キーワード引数として渡すことができる。
```ruby
render AtomicDesign::Atoms::TextLink.new(href: 'https://example.com', class: 'text-primary') do
  'Hello, World!'
end
```

基本的な実装は以下の通り。

```ruby
class AtomicDesign::Atoms::Badge  < ApplicationComponent

  # == Constants
  # Nop

  # == Attributes
  attr_reader :text

  # == Parameters:
  #
  def initialize(content: nil, **options)
    super(**options)

    if block_given?

    else
      @text = content
    end
  end

  # == Methods

  #
  # 複雑なロジックはerbに書かずに ヒアドキュメントで書く
  #
  def call
    content_tag :span, **options
      content || text
    end
  end

end
```
