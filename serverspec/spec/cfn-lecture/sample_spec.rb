require 'spec_helper'

listen_port = 80

# 想定通りの AMI が使用されているか
# 必要なパッケージが必要なバージョンでインストールされている担保が取れるため
describe command('curl http://169.254.169.254/latest/meta-data/ami-id') do
  its(:stdout) { should match /ami-058032fea80b4687c/ }
end

# nginxが実行中であるか
describe package('nginx') do
  it { should be_installed }
end

# Pumaプロセスが実行中であるか（ソケット使用している場合）
describe file('/var/www/raisetech-live8-sample-app/tmp/sockets/puma.sock') do
  it { should be_socket }
end

# 80番portが空いているか
describe port(listen_port) do
  it { should be_listening }
end

# 指定したポートでのcurlコマンドのテスト
describe command("curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s") do
  its(:stdout) { should match /^200$/ }
end