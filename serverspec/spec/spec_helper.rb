require 'serverspec'
require 'rspec'

# サーバーのタイプを設定 (ローカルでテストする場合)
set :backend, :ssh

# 環境変数から値を取得
host = ENV['TARGET_HOST'] # CircleCIで設定したリモートサーバーのIPアドレス
user = ENV['SSH_USER']    # SSHユーザー名
private_key = ENV['SSH_PRIVATE_KEY'] # 秘密鍵

# SSH接続設定
options = Net::SSH::Config.for(host)
options[:user] = user
options[:keys] = [private_key] # 秘密鍵を設定

set :host, host
set :ssh_options, options
