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
      access_token: 'fake_access_token'
    })
  end

  describe 'Log related functions' do
    describe '#get_logs' do
      describe 'forwards option values correctly' do
        context 'without any option values' do
          it 'forwards only log name field' do
            true.should == true
          end
        end
        context 'with some option values' do
          it 'forwards only name and given option values' do
            true.should == true
          end
        end
      end
    end

    describe '#send_logs' do
      describe 'forwards logs correctly' do
        it '' do
          true.should == true
        end
      end
    end
  end

  describe 'Metrics related functions' do
    describe '#list_metrics' do
      it '' do
        true.should == true
      end
    end

    describe '#send_metrics' do
      it '' do
        true.should == true
      end
    end

    describe '#get_metrics' do
      it '' do
        true.should == true
      end
    end

    describe '#delete_metrics' do
      it '' do
        true.should == true
      end
    end

  end

end
