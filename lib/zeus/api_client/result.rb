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
  class APIClient
    class Result

      def initialize(response)
        @response = response
      end

      def success?
        @response.code == 200 || @response.code == 201
      end

      def error?
        !self.success?
      end

      def code
        @response.code
      end

      def data
        JSON.parse(@response)
      end

      def header
        @response.headers
      end

    end
  end
end

