# AtomicDesign

AtomicDesignは、Railsアプリケーション用の再利用可能なUIコンポーネントライブラリです。

## Lookbook
```bash
bundle exec rackup preview.ru
```
ブラウザで開く http://0.0.0.0:8080

## テスト
```bash
bundle exec rspec
```

## TODO
jsを使い回すようになったら、manifest.js に 追加するジェネレーターを作らないとかも。。
```javascript
//= link_tree ../../../app/components .js
```
