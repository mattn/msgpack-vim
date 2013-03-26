let mp = msgpack#client("127.0.0.1", 18800)

" 3
echo mp.call("add", 1, 2)

" {'foo': 'ばー'}
echo mp.call("get_dict")

call mp.close()
