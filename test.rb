require 'zeus/api_client'

zc = Zeus::APIClient.new("28edde36")
a = zc.list_metrics("test")
p a.data
a = zc.get_logs("test")
p a.data
a = zc.send_logs("test", [{aaa: "bbb"}])
p a.data
# a = zc.send_metrics("test", [])
# p a.data
# zc.send_metrics('testname', "")


