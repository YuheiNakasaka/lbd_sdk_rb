require_relative '../lib/lbd_sdk'

RSpec.describe LbdSdk::Calculate do
  it 'return hello' do
    ins = LbdSdk::Calculate.new
    expect(ins.hello).to eq "Hello, World!"
  end
end