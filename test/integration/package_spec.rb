require_relative 'spec_helper'

describe 'Package' do
  before do
    @aem = init_client

    # ensure package does not exist
    @package = @aem.package('somepackagegroup', 'somepackage', '1.2.3')
    result = @package.delete()

    # create agent
    result = @package.create()
    expect(result.is_success?).to be(true)
    expect(result.message).to eq('Package created')
  end

  after do
  end

  describe 'test package build install replicate download' do

    it 'should succeed' do

    end

  end

  describe 'test package update and get filter' do

    it 'should succeed when the package has filter' do
      # update package filter
      result = @package.update('[{"root":"/apps/geometrixx","rules":[]}]')
      expect(result.is_success?).to be(true)
      expect(result.message).to eq('Package updated successfully')
    end

  end

end
