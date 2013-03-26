# -*- coding: utf-8 -*-
require 'msgpack/rpc'
require 'nokogiri'
require 'open-uri'
class MyHandler
  def add(x,y) x+y end
  def get_dict() {:foo => "ばー"} end
end
svr = MessagePack::RPC::Server.new
svr.listen('0.0.0.0', 18800, MyHandler.new)
svr.run

