require 'spec_helper'
describe 'ecmhaproxy' do
  context 'with default values for all parameters' do
    it { should contain_class('ecmhaproxy') }
  end
end
