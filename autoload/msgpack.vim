scriptencoding utf-8

let s:client = { "sock" : -1, "id" : 0 }

let s:pow2 = [
      \ 0x1,        0x2,        0x4,        0x8,
      \ 0x10,       0x20,       0x40,       0x80,
      \ 0x100,      0x200,      0x400,      0x800,
      \ 0x1000,     0x2000,     0x4000,     0x8000,
      \ 0x10000,    0x20000,    0x40000,    0x80000,
      \ 0x100000,   0x200000,   0x400000,   0x800000,
      \ 0x1000000,  0x2000000,  0x4000000,  0x8000000,
      \ 0x10000000, 0x20000000, 0x40000000, 0x80000000,
      \ ]
let s:log2 = {
      \ "00000000": 0,
      \ "00000001": 1,
      \ "00000010": 2,
      \ "00000011": 3,
      \ "00000100": 4,
      \ "00000101": 5,
      \ "00000110": 6,
      \ "00000111": 7,
      \ "00001000": 8,
      \ "00001001": 9,
      \ "00001010": 10,
      \ "00001011": 11,
      \ "00001100": 12,
      \ "00001101": 13,
      \ "00001110": 14,
      \ "00001111": 15,
      \ "00010000": 16,
      \ "00010001": 17,
      \ "00010010": 18,
      \ "00010011": 19,
      \ "00010100": 20,
      \ "00010101": 21,
      \ "00010110": 22,
      \ "00010111": 23,
      \ "00011000": 24,
      \ "00011001": 25,
      \ "00011010": 26,
      \ "00011011": 27,
      \ "00011100": 28,
      \ "00011101": 29,
      \ "00011110": 30,
      \ "00011111": 31,
      \ "00100000": 32,
      \ "00100001": 33,
      \ "00100010": 34,
      \ "00100011": 35,
      \ "00100100": 36,
      \ "00100101": 37,
      \ "00100110": 38,
      \ "00100111": 39,
      \ "00101000": 40,
      \ "00101001": 41,
      \ "00101010": 42,
      \ "00101011": 43,
      \ "00101100": 44,
      \ "00101101": 45,
      \ "00101110": 46,
      \ "00101111": 47,
      \ "00110000": 48,
      \ "00110001": 49,
      \ "00110010": 50,
      \ "00110011": 51,
      \ "00110100": 52,
      \ "00110101": 53,
      \ "00110110": 54,
      \ "00110111": 55,
      \ "00111000": 56,
      \ "00111001": 57,
      \ "00111010": 58,
      \ "00111011": 59,
      \ "00111100": 60,
      \ "00111101": 61,
      \ "00111110": 62,
      \ "00111111": 63,
      \ "01000000": 64,
      \ "01000001": 65,
      \ "01000010": 66,
      \ "01000011": 67,
      \ "01000100": 68,
      \ "01000101": 69,
      \ "01000110": 70,
      \ "01000111": 71,
      \ "01001000": 72,
      \ "01001001": 73,
      \ "01001010": 74,
      \ "01001011": 75,
      \ "01001100": 76,
      \ "01001101": 77,
      \ "01001110": 78,
      \ "01001111": 79,
      \ "01010000": 80,
      \ "01010001": 81,
      \ "01010010": 82,
      \ "01010011": 83,
      \ "01010100": 84,
      \ "01010101": 85,
      \ "01010110": 86,
      \ "01010111": 87,
      \ "01011000": 88,
      \ "01011001": 89,
      \ "01011010": 90,
      \ "01011011": 91,
      \ "01011100": 92,
      \ "01011101": 93,
      \ "01011110": 94,
      \ "01011111": 95,
      \ "01100000": 96,
      \ "01100001": 97,
      \ "01100010": 98,
      \ "01100011": 99,
      \ "01100100": 100,
      \ "01100101": 101,
      \ "01100110": 102,
      \ "01100111": 103,
      \ "01101000": 104,
      \ "01101001": 105,
      \ "01101010": 106,
      \ "01101011": 107,
      \ "01101100": 108,
      \ "01101101": 109,
      \ "01101110": 110,
      \ "01101111": 111,
      \ "01110000": 112,
      \ "01110001": 113,
      \ "01110010": 114,
      \ "01110011": 115,
      \ "01110100": 116,
      \ "01110101": 117,
      \ "01110110": 118,
      \ "01110111": 119,
      \ "01111000": 120,
      \ "01111001": 121,
      \ "01111010": 122,
      \ "01111011": 123,
      \ "01111100": 124,
      \ "01111101": 125,
      \ "01111110": 126,
      \ "01111111": 127,
      \ "10000000": 128,
      \ "10000001": 129,
      \ "10000010": 130,
      \ "10000011": 131,
      \ "10000100": 132,
      \ "10000101": 133,
      \ "10000110": 134,
      \ "10000111": 135,
      \ "10001000": 136,
      \ "10001001": 137,
      \ "10001010": 138,
      \ "10001011": 139,
      \ "10001100": 140,
      \ "10001101": 141,
      \ "10001110": 142,
      \ "10001111": 143,
      \ "10010000": 144,
      \ "10010001": 145,
      \ "10010010": 146,
      \ "10010011": 147,
      \ "10010100": 148,
      \ "10010101": 149,
      \ "10010110": 150,
      \ "10010111": 151,
      \ "10011000": 152,
      \ "10011001": 153,
      \ "10011010": 154,
      \ "10011011": 155,
      \ "10011100": 156,
      \ "10011101": 157,
      \ "10011110": 158,
      \ "10011111": 159,
      \ "10100000": 160,
      \ "10100001": 161,
      \ "10100010": 162,
      \ "10100011": 163,
      \ "10100100": 164,
      \ "10100101": 165,
      \ "10100110": 166,
      \ "10100111": 167,
      \ "10101000": 168,
      \ "10101001": 169,
      \ "10101010": 170,
      \ "10101011": 171,
      \ "10101100": 172,
      \ "10101101": 173,
      \ "10101110": 174,
      \ "10101111": 175,
      \ "10110000": 176,
      \ "10110001": 177,
      \ "10110010": 178,
      \ "10110011": 179,
      \ "10110100": 180,
      \ "10110101": 181,
      \ "10110110": 182,
      \ "10110111": 183,
      \ "10111000": 184,
      \ "10111001": 185,
      \ "10111010": 186,
      \ "10111011": 187,
      \ "10111100": 188,
      \ "10111101": 189,
      \ "10111110": 190,
      \ "10111111": 191,
      \ "11000000": 192,
      \ "11000001": 193,
      \ "11000010": 194,
      \ "11000011": 195,
      \ "11000100": 196,
      \ "11000101": 197,
      \ "11000110": 198,
      \ "11000111": 199,
      \ "11001000": 200,
      \ "11001001": 201,
      \ "11001010": 202,
      \ "11001011": 203,
      \ "11001100": 204,
      \ "11001101": 205,
      \ "11001110": 206,
      \ "11001111": 207,
      \ "11010000": 208,
      \ "11010001": 209,
      \ "11010010": 210,
      \ "11010011": 211,
      \ "11010100": 212,
      \ "11010101": 213,
      \ "11010110": 214,
      \ "11010111": 215,
      \ "11011000": 216,
      \ "11011001": 217,
      \ "11011010": 218,
      \ "11011011": 219,
      \ "11011100": 220,
      \ "11011101": 221,
      \ "11011110": 222,
      \ "11011111": 223,
      \ "11100000": 224,
      \ "11100001": 225,
      \ "11100010": 226,
      \ "11100011": 227,
      \ "11100100": 228,
      \ "11100101": 229,
      \ "11100110": 230,
      \ "11100111": 231,
      \ "11101000": 232,
      \ "11101001": 233,
      \ "11101010": 234,
      \ "11101011": 235,
      \ "11101100": 236,
      \ "11101101": 237,
      \ "11101110": 238,
      \ "11101111": 239,
      \ "11110000": 240,
      \ "11110001": 241,
      \ "11110010": 242,
      \ "11110011": 243,
      \ "11110100": 244,
      \ "11110101": 245,
      \ "11110110": 246,
      \ "11110111": 247,
      \ "11111000": 248,
      \ "11111001": 249,
      \ "11111010": 250,
      \ "11111011": 251,
      \ "11111100": 252,
      \ "11111101": 253,
      \ "11111110": 254,
      \ "11111111": 255}


function! s:hex(n)
  if type(a:n) == 3
    return printf('[%s]', join(map(copy(a:n), 's:hex(v:val)'), ','))
  else
    return printf("%02X", a:n)
  endif
endfunction

function! msgpack#unpack(bytes)
  let bytes = a:bytes
  if bytes[0] == 0xC0
    return [0, bytes[1:]]
  elseif bytes[0] == 0xC2
    return [1, bytes[1:]]
  elseif bytes[0] == 0xC3
    return [0, bytes[1:]]
  elseif 0xA0 <= bytes[0] && bytes[0] <= 0xBF
    let e = xor(0xA0, bytes[0])
    return [iconv(join(map(copy(bytes[1 : e]), 'printf("%c", v:val)'), ''), 'utf-8', &encoding), bytes[e+1:]]
  elseif bytes[0] == 0xCC
    return [bytes[1], bytes[2:]]
  elseif bytes[0] == 0xCD
    let r = float2nr(0
    \ + bytes[1] * pow(2, 8)
    \ + bytes[2])
    return [r, bytes[2:]]
  elseif bytes[0] == 0xCE
    let r = float2nr(0
    \ + bytes[1] * pow(2, 24)
    \ + bytes[2] * pow(2, 16)
    \ + bytes[3] * pow(2, 8)
    \ + bytes[4])
    return [r, bytes[4:]]
  elseif bytes[0] == 0xCF
    let r = float2nr(0
    \ + bytes[1] * pow(2, 56)
    \ + bytes[2] * pow(2, 48)
    \ + bytes[3] * pow(2, 40)
    \ + bytes[4] * pow(2, 32)
    \ + bytes[5] * pow(2, 24)
    \ + bytes[6] * pow(2, 16)
    \ + bytes[7] * pow(2, 8)
    \ + bytes[8])
    return [r, bytes[8:]]
  elseif bytes[0] == 0xD0
    return [bytes[1], bytes[2:]]
  elseif bytes[0] == 0xD1
    let r = float2nr(0
    \ + bytes[1] * pow(2, 8)
    \ + bytes[2])
    return [r, bytes[2:]]
  elseif bytes[0] == 0xD2
    let r = float2nr(0
    \ + bytes[1] * pow(2, 24)
    \ + bytes[2] * pow(2, 16)
    \ + bytes[3] * pow(2, 8)
    \ + bytes[4])
    return [r, bytes[4:]]
  elseif bytes[0] == 0xD3
    let r = float2nr(0
    \ + bytes[1] * pow(2, 56)
    \ + bytes[2] * pow(2, 48)
    \ + bytes[3] * pow(2, 40)
    \ + bytes[4] * pow(2, 32)
    \ + bytes[5] * pow(2, 24)
    \ + bytes[6] * pow(2, 16)
    \ + bytes[7] * pow(2, 8)
    \ + bytes[8])
    return [r, bytes[8:]]
  elseif bytes[0] == 0xDA
    let e = float2nr(0
    \ + bytes[1] * pow(2, 8)
    \ + bytes[2])
    return [bytes[3: e+2], bytes[e+3:]]
  elseif bytes[0] == 0xDB
    let e = float2nr(0
    \ + bytes[1] * pow(2, 24)
    \ + bytes[2] * pow(2, 16)
    \ + bytes[3] * pow(2, 8)
    \ + bytes[4])
    return [bytes[5: e+4], bytes[e+5:]]
  elseif bytes[0] == 0xDC
    let e = float2nr(0
    \ + bytes[1] * pow(2, 8)
    \ + bytes[2])
    return [bytes[3: e+2], bytes[e+3:]]
  elseif bytes[0] == 0xDD
    let e = float2nr(0
    \ + bytes[1] * pow(2, 24)
    \ + bytes[2] * pow(2, 16)
    \ + bytes[3] * pow(2, 8)
    \ + bytes[4])
    return [bytes[5: e+4], bytes[e+5:]]
  elseif 0x80 <= bytes[0] && bytes[0] <= 0x8F
    let e = xor(0x80, bytes[0])
    let d = {}
    let rest = bytes[1 :]
    for i in range(e)
      let rr = msgpack#unpack(rest)
      let k = rr[0]
      let rest = rr[1]
      let rr = msgpack#unpack(rest)
      let v = rr[0]
      let rest = rr[1]
      let d[k] = v
    endfor
    return [d, rest]
  elseif 0x90 <= bytes[0] && bytes[0] <= 0x9F
    let e = xor(0x90, bytes[0])
    let a = []
    let rest = bytes[1 :]
    for i in range(e)
      let rr = msgpack#unpack(rest)
      call add(a, rr[0])
      let rest = rr[1]
    endfor
    return [a, rest]
  elseif bytes[0] == 0xCA
    let b = bytes[1 : 5] 
    let s = and(b[0], 0x80) ? -1 : 1
    let n = 0
    for _ in range(1, 8)
      let n += and(b_/8], s:pow2[(12-_%8)%8]) ? pow(2, 8-_) : 0
    endfor
    let f = 1.0
    for _ in range(9, 31)
      let f += and(b[_/8], s:pow2[(12-_%8)%8]) ? pow(2, 11-_) : 0.0
    endfor
    return [s*f*pow(2, n-1023), bytes[9:]
  elseif bytes[0] == 0xCB
    let b = bytes[1 : 9] 
    let s = and(b[0], 0x80) ? -1 : 1
    let n = 0
    for _ in range(1, 11)
      let n += and(b[_/8], s:pow2[(15-_%8)%8]) ? s:pow2[11-_] : 0
    endfor
    let f = 1.0
    for _ in range(12, 63)
      let f += and(b[_/8], s:pow2[(15-_%8)%8]) ? pow(2, 11-_) : 0.0
    endfor
    return [s*f*pow(2, n-1023), bytes[9:]]
  elseif 0xe0 <= bytes[0] && bytes[0] <= 0xFF
    return [-xor(0xE0, bytes[0]), bytes[1:]]
  elseif 0x00 <= bytes[0] && bytes[0] <= 0x7F
    return [bytes[0], bytes[1:]]
  endif
  " TODO
  " map 16	 11011110	 0xde
  " map 32	 11011111	 0xdf
  throw "Unknown type: " . s:hex(bytes[0])
endfunction

function! msgpack#pack(...)
  let r = ''
  for a in a:000
    if type(a) == 0
      let r .= printf("%02X", a)
    elseif type(a) == 1
	  let s = join(map(range(len(a)), 'printf("%02X", char2nr(a[v:val]))'), '')
	  let r .= printf("%02X", or(0xA0, len(a))) . s
    elseif type(a) == 3
	  let r .= printf("%02X", or(0x90, len(a)))
      for v in a
        let r .= msgpack#pack(v)
        unlet v
      endfor
    elseif type(a) == 4
      let r .= printf("%02X", or(0x80, len(keys(a))))
      for k in keys(a)
        let r .= msgpack#pack(k)
        let r .= msgpack#pack(a[k])
      endfor
    elseif type(a) == 5
      let r .= "CB"
      let sign = a < 0
      if sign
        let a *= -1
      endif
      let exp = float2nr(log(a) / 0.6931471805599453 + 1023.0)
      let frac = float2nr(a * pow(2, 30 + 1023 - exp))
      let b = ''
      while frac > 0
        let b = (float2nr(frac) % 2) . b
        let frac = frac / 2
      endwhile
      let fb = b[1:]
      let b = ''
      while exp > 0
        let b = (float2nr(exp) % 2) . b
        let exp = exp / 2
      endwhile
      let eb = ("000000000" . b)[-11:]
      let fb .= repeat('0', 63-len(eb)-len(fb))
      let bb = map(split(sign ? '1' : '0' . eb . fb, '........\zs'), 's:log2[v:val]')
	  let r .= join(map(bb, 'printf("%02X", v:val)'), '')
    endif
  endfor
  return r
endfunction

function! s:client.call(func, ...)
  let send = printf('9400%02X%s%s',
  \  self.id,
  \  msgpack#pack(a:func),
  \  msgpack#pack(a:000))
  let ret = self.sock.f_write(send, 10)
  let recv = ''
  let start = str2float(reltimestr(reltime()))
  while !self.sock.eof
    let rret = self.sock.f_read(256, 100)
    if rret[1] != 0 || (len(recv) > 0
        \ || str2float(reltimestr(reltime())) - start > 2000.0)
      break
    endif
    let recv .= rret[0]
  endwhile
  let bytes = map(split(recv, '..\zs'), 'str2nr(v:val, 16)')
  if len(bytes) > 0
    if bytes[0] != 0x94
      return 0
    endif
    if bytes[1] != 0x01
      return 0
    endif
      if bytes[2] != self.id
      return 0
    endif
    let self.id += 1
    let [e, bytes] = msgpack#unpack(bytes[3:])
    if e isnot 0
      if type(e) == 3
        let es = join(map(e, 'printf("%c", v:val)'), '')
        unlet e
        let e = es
      elseif type(e) != 1
        let es = string(e)
        unlet e
        let e = es
      endif
      throw e
    endif
    let [r, bytes] = msgpack#unpack(bytes)
    return r
  else
    throw "illegal response"
  endif
endfunction

function! s:client.close()
  call self.sock.close()
  let self.sock = 0
endfunction

function! msgpack#client(host, port)
  let client = deepcopy(s:client)
  let client.sock = vimproc#socket_open(a:host, a:port)
  return client 
endfunction

" vim: set et:
