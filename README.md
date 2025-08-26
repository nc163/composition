# AtomicDesign

AtomicDesignは、Railsアプリケーション用の再利用可能なUIコンポーネントライブラリです。

## Preview
```bash
# bundle exec rackup preview.ru -o 0.0.0.0
bundle exec rackup preview.ru -o 0.0.0.0 -s Puma
```
ブラウザで開く http://0.0.0.0:9292

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
gem "atomic_design", git: "https://gitlab.com/nc163/atomic_design.git", branch: "main"
```

2. ApplicationHelper に追加
```ruby
module ApplicationHelper
  include AtomicDesign::Helpers
  ...
```

3. Asset
いつか書く

4. Viewで生成
```erb
  <%= render atomic_design.atoms.button 'ボタン' %>
```

## TODO
jsを使い回すようになったら、manifest.js に 追加するジェネレーターを作らないとかも。。
```javascript
//= link_tree ../../../app/components .js
```
