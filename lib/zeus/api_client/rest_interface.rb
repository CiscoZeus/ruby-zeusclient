# coding: utf-8

# Copyright 2016 Cisco Systems, Inc.
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
#

require 'rest-client'

# Wrapper around rest-client
module RestInterface
  private

  def get(path, params = {})
    RestClient.get "#{@endpoint}#{path}", params: params
  end

  def post(path, data = {})
    RestClient.post "#{@endpoint}#{path}", data.to_json,
                    content_type: :json, accept: :json
  end

  def put(path, params = {})
    RestClient.put "#{@endpoint}#{path}", params: params
  end

  def delete(path = {})
    RestClient.delete "#{@endpoint}#{path}"
  end
end
