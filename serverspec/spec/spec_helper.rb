require 'serverspec'

# サーバーのタイプを設定 (ローカルでテストする場合)
set :backend, :exec

# RSpec の設定
RSpec.configure do |config|
  # テスト結果の永続化 (不要であればコメントアウト)
  config.example_status_persistence_file_path = "spec/examples.txt"

  # 推奨される非モンキーパッチング構文を使用
  config.disable_monkey_patching!

  # 単一のファイルを実行する場合にドキュメント形式で出力
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  # 最も遅い 10 のテストを表示 (不要であればコメントアウト)
  config.profile_examples = 10

  # テストの実行順序をランダム化
  config.order = :random
  Kernel.srand config.seed
end