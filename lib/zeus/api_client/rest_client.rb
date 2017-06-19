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
module RestClient
  private

  def get(path, headers, params = {})
    headers = params.merge(headers)
    RestClient.get "#{@endpoint}#{path}", headers
  end

  def post(path, headers, params = {})
    RestClient.post "#{@endpoint}#{path}", params.to_json, headers
  end

  def put(path, headers, params = {})
    RestClient.put "#{@endpoint}#{path}", params.to_json, headers
  end

  def delete(path, headers)
    RestClient.delete "#{@endpoint}#{path}", headers
  end

  def make_header(token, bucket_name = {})
    header = if bucket_name.nil?
               { Authorization: "Bearer #{token}" }
             else
               { Authorization: "Bearer #{token}", :'Bucket-Name' => bucket_name }
             end
    header
  end
end
