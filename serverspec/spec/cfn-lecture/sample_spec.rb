puts "spec_helper loaded" if defined?(RSpec)
require 'spec_helper'

listen_port = 80

# 想定通りの AMI が使用されているか
# 必要なパッケージが必要なバージョンでインストールされている担保が取れるため
describe command('curl http://169.254.169.254/latest/meta-data/ami-id') do
  its(:stdout) { should match /ami-058032fea80b4687c/ }
end

describe command('which nginx') do
  its(:exit_status) { should eq 0 }
end

# rpm が使用可能か確認
describe command('which rpm') do
  its(:exit_status) { should eq 0 }
end

  # yum が使用可能か確認
describe command('which yum') do
  its(:exit_status) { should eq 0 }
end

  # dnf が使用可能か確認
describe command('which dnf') do
  its(:exit_status) { should eq 0 }
end




# nginxが実行中であるか
describe package('nginx') do
  it { should be_installed }
end

# nginxが実行中であるか
describe service('nginx') do
  it { should be_running }
  it { should be_enabled }
end

# 80番portが空いているか
describe port(listen_port) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end

# 指定したポートでのcurlコマンドのテスト
describe command("curl http://127.0.0.1:#{listen_port} -o /dev/null -w \"%{http_code}\n\" -s") do
  its(:stdout) { should match /^200$/ }
end