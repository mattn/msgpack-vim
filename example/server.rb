# -*- coding: utf-8 -*-
require 'msgpack/rpc'
require 'nokogiri'
require 'open-uri'
class MyHandler
  def vimhack(x)
    doc = Nokogiri::HTML(open('http://vim-users.jp/vim-hacks-project/'))
    doc.css('ul>li>a').each do |e|
      if e.content =~ /^Hack ##{x}:/
        return e['href'].to_s
      end
    end
  end
  def add(x,y) x+y end
  def get_dict() {:foo => "ばー"} end
end
svr = MessagePack::RPC::Server.new
svr.listen('0.0.0.0', 18800, MyHandler.new)
svr.run

