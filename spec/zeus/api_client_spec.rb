# Copyright 2015 Cisco Systems, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'rspec'
require 'zeus/api_client'

describe Zeus::APIClient do

  let (:zeus_client) do
    Zeus::APIClient.new({
      access_token: 'fake_access_token',
      endpoint: 'luke.skywalker.com'
    })
  end

  describe '#initialize' do
    context 'endpoint starts with http' do
      it 'replace http to https' do
        fake_zeus_client = Zeus::APIClient.new(
          {
            access_token: 'fake_access_token',
            endpoint: 'http://fake-ciscozeus.io'
          }
        )
        expect(fake_zeus_client.instance_variable_get(:@endpoint)).to eq(
          'https://fake-ciscozeus.io'
        )
      end
    end
    context 'endpoint starts with https' do
      it 'stays as https' do
        fake_zeus_client = Zeus::APIClient.new(
          {
            access_token: 'fake_access_token',
            endpoint: 'https://fake-ciscozeus.io'
          }
        )
        expect(fake_zeus_client.instance_variable_get(:@endpoint)).to eq(
          'https://fake-ciscozeus.io'
        )
      end
    end
    context 'endpoint without protocol' do
      it 'add https to the start of the url' do
        fake_zeus_client = Zeus::APIClient.new(
          {
            access_token: 'fake_access_token',
            endpoint: 'fake-ciscozeus.io'
        })
        expect(fake_zeus_client.instance_variable_get(:@endpoint)).to eq(
          'https://fake-ciscozeus.io'
        )
      end
    end
  end

  describe 'Log' do
    describe '#get_logs' do
      describe 'request logs' do
        context 'without any option values' do
          it 'has only log name field' do
            mock_get = double('ApiClient::get')
            expect(zeus_client).to receive(:get).and_return(mock_get).once
            # .with(:path => "/logs/fake_access_token/", :params => {:name => "fake_name"})
            zeus_client.get_logs('fake_name')
          end
        end
        context 'with some option values' do
          it 'has given option fields' do
            mock_get = double('ApiClient::get')
            expect(zeus_client).to receive(:get).and_return(mock_get).once
            # .with(:path => "/logs/fake_access_token/", :params => {:name => "fake_name", ....})
            zeus_client.get_logs(
                'fake_name', 'fake_attribute_name', 'fake_pattern',
                'fake_from_date', 'fake_to_date', 'fake_offset', 'fake_limit')
          end
        end
      end
    end

    describe '#send_logs' do
      describe 'send logs' do
        it 'request posting logs' do
          mock_post = double('ApiClient::post')
          expect(zeus_client).to receive(:post).and_return(mock_post).once
          # TODO: parameter check
          zeus_client.send_logs('fake_name', [])
        end
      end
    end
  end

  describe 'Metrics' do
    describe '#list_metrics' do
      it 'request the list of metrics' do
        mock_get = double('ApiClient::get')
        expect(zeus_client).to receive(:get).and_return(mock_get).once
        # TODO: parameter check
        zeus_client.list_metrics
      end
    end

    describe '#send_metrics' do
      it 'send metrics' do
        mock_post = double('ApiClient::post')
        expect(zeus_client).to receive(:post).and_return(mock_post).once
        # TODO: parameter check
        zeus_client.send_metrics('fake_name', [])
      end
    end

    describe '#get_metrics' do
      it 'request get metrics' do
        mock_get = double('ApiClient::get')
        expect(zeus_client).to receive(:get).and_return(mock_get).once
        # TODO: parameter check
        zeus_client.get_metrics
      end
    end

    describe '#delete_metrics' do
      it 'request delete metrics' do
        mock_delete = double('ApiClient::delete')
        expect(zeus_client).to receive(:delete).and_return(mock_delete).once
        # TODO: parameter check
        zeus_client.delete_metrics('fake_name')
      end
    end

  end

end
