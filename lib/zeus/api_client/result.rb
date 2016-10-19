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

require 'json'

module Zeus
  class Result

    # constructor for Result class
    def initialize(response)
      @response = response
    end

    # request is successed?
    def success?
      @response.code == 200 || @response.code == 201
    end

    # request is error?
    def error?
      !self.success?
    end

    # response code
    def code
      @response.code
    end

    # response header
    def header
      @response.headers
    end

    # response body
    def data
      JSON.parse(@response)
    end

  end
end
