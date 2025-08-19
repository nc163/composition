# AtomicDesign

AtomicDesignは、Railsアプリケーション用の再利用可能なUIコンポーネントライブラリです。

## プレビュー(Lookbook)
```bash
bundle exec rackup preview.ru -o 0.0.0.0
```
ブラウザで開く http://0.0.0.0:9292

## テスト
```bash
bundle exec rspec
```

## 使い方(rails)
Gemfile
```ruby
gem "atomic_design", git: "https://gitlab.com/nc163/atomic_design.git", branch: "main"
```
ApplicationHelper に追加
```ruby
module ApplicationHelper
  include AtomicDesign::Helpers
  ...
```
Viewで生成
```erb
<%= atomic_design.organisms.card_table %>
```


## TODO
jsを使い回すようになったら、manifest.js に 追加するジェネレーターを作らないとかも。。
```javascript
//= link_tree ../../../app/components .js
```
