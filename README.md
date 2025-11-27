# Composition

Compositionは、Railsアプリケーション用の再利用可能なUIコンポーネントライブラリです。

## Preview
```bash
bundle exec rails s
```
ブラウザで開く http://0.0.0.0:3000

## Test
```bash
bundle exec rspec
```

## Documentation
```bash
bundle exec yard doc --no-private
```
```bash
bundle exec yard server --reload --no-private
```

## 使い方(rails)
1. Gemfile
```ruby
gem "composition", git: "https://gitlab.com/nc163/composition.git", branch: "main"
```

2. ApplicationHelper に追加
```ruby
module ApplicationHelper
  include Composition::Helper
  ...
```

3. Asset
いつか書く

4. Viewで生成
```erb
  <%= render composition.atoms.button 'ボタン' %>
```

## TODO

- [ ] JavaScriptコンポーネントの自動manifest.js追加ジェネレーター
```javascript
//= link_tree ../../../app/components .js
```