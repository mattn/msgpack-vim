let mp = msgpack#client("127.0.0.1", 18800)

" http://vim-users.jp/2009/04/hack1/
echo join(map(mp.call("vimhack", 1), 'printf("%c", v:val)'), '')

" 3
echo mp.call("add", 1, 2)

" {'foo': 'ばー'}
echo mp.call("get_dict")

call mp.close()
