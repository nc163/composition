# frozen_string_literal: true

class TablePreview < ApplicationComponentPreview # :nodoc:
  def default
    render atomic_design.atoms.table(table: TABLE, headers: HEADERS)
  end

  def headless
    render atomic_design.atoms.table(table: TABLE)
  end

  HEADERS = %w[言語 ホームページ 更新日時 作成日時]
  TABLE = [
    [ "Ruby", "https://www.ruby-lang.org/", "2024-06-01 10:00", "2024-05-01 09:00" ],
    [ "Python", "https://www.python.org/", "2024-06-02 11:00", "2024-05-02 10:00" ],
    [ "JavaScript", "https://developer.mozilla.org/docs/Web/JavaScript", "2024-06-03 12:00", "2024-05-03 11:00" ],
    [ "Go", "https://golang.org/", "2024-06-04 13:00", "2024-05-04 12:00" ],
    [ "Java", "https://www.java.com/", "2024-06-05 14:00", "2024-05-05 13:00" ],
    [ "PHP", "https://www.php.net/", "2024-06-06 15:00", "2024-05-06 14:00" ],
    [ "C++", "https://isocpp.org/", "2024-06-07 16:00", "2024-05-07 15:00" ],
    [ "C#", "https://learn.microsoft.com/dotnet/csharp/", "2024-06-08 17:00", "2024-05-08 16:00" ],
    [ "TypeScript", "https://www.typescriptlang.org/", "2024-06-09 18:00", "2024-05-09 17:00" ],
    [ "Kotlin", "https://kotlinlang.org/", "2024-06-10 19:00", "2024-05-10 18:00" ]
  ]
end
