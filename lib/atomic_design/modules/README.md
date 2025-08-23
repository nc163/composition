# 概要

`View Component`を用いて、`Atomic Design`に基づいたUIコンポーネントを構築する。

しかし、実際に構築しようとすると`Atomic Design`の考え方をそのまま適用することは難しそうだったので、いくつか補助線を引く。

## Atomic Design

基本的な`Atomic Design`の考え方は以下の通り。
- **Atoms**: 最小単位のコンポーネント。
- **Molecules**: 複数のAtomsを組み合わせたコンポーネント。フォームやカードなど。
- **Organisms**: 複数のMoleculesを組み合わせたコンポーネント。ナビゲーションバーやフッターなど。
- **Templates**: 複数のOrganismsを組み合わせたコンポーネント。ページ全体のレイアウトなど。
- **Pages**: テンプレートにデータを流し込んだもの。実際のページ。

Atomic Designは、データ構造とUIデザインの橋渡しをするための仕組みなので、各コンポーネントはデータ構造とUIデザインの両方を考慮して作成する必要がある。

### 考え方

1. `Atomic Design`は５つの要素に分かれている
1. `Atomic Design` の各要素が、**Atoms**, **Molecules**, **Organisms**, **Templates**, **Pages** は２つの考え方に分けれる
1. #### **Atoms**, **Molecules**, **Organisms**、これらは物質構造を表すもので、HTML要素に近いものと考えておく。
      ここで重要なのは**Organisms**で、原子・分子に対して有機体であるから、ここにきてビジネスロジックが介入するドメイン知識があると捉えておく。UIデザインという成果物と密に結合しているべきもの。
1. **Organisms**は一番大きなビジネスロジックが介入するもので、これがModelと対になることができる
1. **Templates**は名前の通りUIデザイン
      名前の通りUIデザインの雛形になるものなので、コンポーネント化を控えてViewにそのまま書くことにする。
1. **Pages**はつかわない
      application.html.erb があるので、**Pages**は使わないことにする。

### 想定できるアンチパターン

- 循環参照は、コンポーネントとして成り立たないので、循環参照は避ける。
- **Atoms**がHTMLと対になってしまうこと。**Atoms**は、最もHTML要素に近いものになるが、**Atoms**はHTML要素ではない。
- 同一レイヤーのコンポーネントを利用すること。例えば、**Molecules**のコンポーネント内で**Molecules**を利用しない。
  - ただし、**Card** の中で **CardHeader** を呼び出すような場合は、**Card**, **Card::Header** のように管理する
- **Atoms**, **Molecules** には、ドメイン知識がないので直接使われることはないコンポーネントになる。

### Organisms

ビジネスロジックの介入するコンポーネントなので、**Organisims**コンポーネントに対するヘルパーを用意して、以下のようにかけるようにするのが良さそう。
```ruby

# controller
class ModelsController < ApplicationController
  def action
    @organisims_component_options = options_for_organisims(resource)
  end
end

# view
<%= render OrganismsComponent.new @organisims_component_options %>
```


## 実装

Viewからは、ヘルパーを使って呼び出すことにする。
```ruby
component 'awesome_component', property: { color: 'primary', size: 'large' }, class: 'custom-class', style: 'custom-style', data: { key: 'value' }
```
これは以下のコードと同じ意味になる。
```ruby
render AwesomeComponent.new( property: { color: 'primary', size: 'large'}, class: 'custom-class', style: 'custom-style', data: { key: 'value' })
```


## まとめ
コンポーネントこのような形で動作するように作成する。
```ruby
# app/controllers/any_models_controller.rb
class AnyModelsController < ApplicationController
  def action
    resources = AnyModel.pages(params[:page])
    @search_form = search_form_options(resources)
    @table = options_for_organisims(resources)
  end
end

# app/views/any)models/index.html.erb
<%= component 'organisims/form/search_form', @search_form %>
<%= component 'organisims/card/table', @table %>
```
