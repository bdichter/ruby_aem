require_relative 'spec_helper'
require_relative '../../lib/ruby_aem/client'

describe 'Client' do
  before do
    @spec = {
      'bundle' => {
        'actions' => {
          'start' => {
            'api' => 'console',
            'operation' => 'postBundle',
            'params' => {
              'required' => {
                'name' => '%{name}',
                'action' => 'start'
              }
            },
            'responses' => {
              '200' => {
                'status' => 'success',
                'handler' => 'simple',
                'message' => 'Bundle %{name} started'
              }
            }
          }
        }
      }
    }
  end

  after do
  end

  describe 'test call' do

    it 'should call api send and handle the response' do
      mock_class = double('mock_class')
      expect(mock_class).to receive(:name).once().and_return('RubyAem::Resources::Bundle')

      mock_api = double('mock_api')
      expect(mock_api).to receive(:post_bundle_with_http_info).once().with('somebundle', 'start', {})
      apis = { :console => mock_api }

      client = RubyAem::Client.new(apis, @spec)
      client.call(mock_class, 'start', { :name => 'somebundle' })
    end

    it 'should handle api error' do
      mock_error = SwaggerAemClient::ApiError.new()

      mock_class = double('mock_class')
      expect(mock_class).to receive(:name).once().and_return('RubyAem::Resources::Bundle')

      mock_api = double('mock_api')
      expect(mock_api).to receive(:post_bundle_with_http_info).once().with('somebundle', 'start', {}).and_raise(mock_error)
      apis = { :console => mock_api }

      client = RubyAem::Client.new(apis, @spec)
      client.call(mock_class, 'start', { :name => 'somebundle' })
    end

    it 'should handle optional param without value' do
      spec = {
        'bundle' => {
          'actions' => {
            'start' => {
              'api' => 'console',
              'operation' => 'postBundle',
              'params' => {
                'optional' => ['optional1', 'optional2']
              },
              'responses' => {
                '200' => {
                  'status' => 'success',
                  'handler' => 'simple',
                  'message' => 'Bundle %{name} started'
                }
              }
            }
          }
        }
      }

      mock_class = double('mock_class')
      expect(mock_class).to receive(:name).once().and_return('RubyAem::Resources::Bundle')

      mock_api = double('mock_api')
      expect(mock_api).to receive(:post_bundle_with_http_info).once().with({ :optional1 => 'value1', :optional2 => 'value2' })
      apis = { :console => mock_api }

      client = RubyAem::Client.new(apis, spec)
      client.call(mock_class, 'start', { :name => 'somebundle', :optional1 => 'value1', :optional2 => 'value2' })
    end

    it 'should handle optional param with non-String value' do
      spec = {
        'bundle' => {
          'actions' => {
            'start' => {
              'api' => 'console',
              'operation' => 'postBundle',
              'params' => {
                'optional' => {
                  'optional1' => true,
                  'optional2' => false,
                }
              },
              'responses' => {
                '200' => {
                  'status' => 'success',
                  'handler' => 'simple',
                  'message' => 'Bundle %{name} started'
                }
              }
            }
          }
        }
      }

      mock_class = double('mock_class')
      expect(mock_class).to receive(:name).once().and_return('RubyAem::Resources::Bundle')

      mock_api = double('mock_api')
      expect(mock_api).to receive(:post_bundle_with_http_info).once().with({ :optional1 => true, :optional2 => false })
      apis = { :console => mock_api }

      client = RubyAem::Client.new(apis, spec)
      client.call(mock_class, 'start', { :name => 'somebundle', :optional1 => true, :optional2 => false })
    end

    it 'should handle optional param with non-File String value' do
      spec = {
        'bundle' => {
          'actions' => {
            'start' => {
              'api' => 'console',
              'operation' => 'postBundle',
              'params' => {
                'optional' => {
                  'optional1' => 'value1',
                  'optional2' => 'value2',
                }
              },
              'responses' => {
                '200' => {
                  'status' => 'success',
                  'handler' => 'simple',
                  'message' => 'Bundle %{name} started'
                }
              }
            }
          }
        }
      }

      mock_class = double('mock_class')
      expect(mock_class).to receive(:name).once().and_return('RubyAem::Resources::Bundle')

      mock_api = double('mock_api')
      expect(mock_api).to receive(:post_bundle_with_http_info).once().with({ :optional1 => 'value1', :optional2 => 'value2' })
      apis = { :console => mock_api }

      client = RubyAem::Client.new(apis, spec)
      client.call(mock_class, 'start', { :name => 'somebundle', :optional1 => 'value1', :optional2 => 'value2' })
    end

    it 'should handle optional param with File String value' do
      spec = {
        'bundle' => {
          'actions' => {
            'start' => {
              'api' => 'console',
              'operation' => 'postBundle',
              'params' => {
                'optional' => {
                  'optional1' => '__FILE__'
                }
              },
              'responses' => {
                '200' => {
                  'status' => 'success',
                  'handler' => 'simple',
                  'message' => 'Bundle %{name} started'
                }
              }
            }
          }
        }
      }

      mock_file = double('mock_file')
      expect(File).to receive(:open).once().with('/tmp/somepackage-1.2.3.zip', 'r').and_yield(mock_file)

      mock_class = double('mock_class')
      expect(mock_class).to receive(:name).once().and_return('RubyAem::Resources::Bundle')

      mock_api = double('mock_api')
      expect(mock_api).to receive(:post_bundle_with_http_info).once().with({ :optional1 => mock_file })
      apis = { :console => mock_api }

      client = RubyAem::Client.new(apis, spec)
      client.call(mock_class, 'start', { :name => 'somebundle', :optional1 => '__FILE__', :file_path => '/tmp', :package_name => 'somepackage', :package_version => '1.2.3' })
    end

  end

  describe 'test handle' do

    it 'should return failure result when responses does not contain status code' do
      data = 'somepayload'
      status_code = 404
      headers = nil
      responses = { 200 => { 'status' => 'success', 'message' => 'Bundle %{name} started' }}
      info = { :name => 'somebundle' }

      client = RubyAem::Client.new(nil, nil)
      result = client.handle(data, status_code, headers, responses, info)
      expect(result.is_failure?).to be(true)
      expect(result.message).to eq("Unexpected response\nstatus code: 404\nheaders: \ndata: somepayload")
    end

    it 'should call handler when responses contain status code' do
      data = 'somepayload'
      status_code = 200
      headers = nil
      responses = { 200 => { 'status' => 'success', 'message' => 'Bundle %{name} started' }}
      info = { :name => 'somebundle' }

      expect(RubyAem::Handlers).to receive(:send).once().with(nil, 'somepayload', 200, nil, { 'status' => 'success', 'message' => 'Bundle %{name} started' }, { :name => 'somebundle' })

      client = RubyAem::Client.new(nil, nil)
      client.handle(data, status_code, headers, responses, info)
    end

  end

end
