source t/init.vim

let g:packed_1 = msgpack#pack(1)

function! s:npow(x, y)
    return float2nr(pow(a:x, a:y))
endfunction

function! s:gen_range(n, filled)
  return map(range(1, a:n), 'a:filled')
endfunction

let test_cases = [
\ ['fixarray', [], '90'],
\ ['fixarray', s:gen_range(15, 1), '9F' . join(s:gen_range(15, g:packed_1), '')],
\ ['array 16', s:gen_range(16, 1), 'DC0010' . join(s:gen_range(16, g:packed_1), '')],
\ ['array 16', s:gen_range(s:npow(2, 16) - 1, 1), 'DCFFFF' . join(s:gen_range(s:npow(2, 16) - 1, g:packed_1), '')],
\ ['array 32', s:gen_range(s:npow(2, 16), 1), 'DD00010000' . join(s:gen_range(s:npow(2, 16), g:packed_1), '')],
\]

call TestPack(test_cases)
call TestUnpack(test_cases)

" vim: set et ts=2 sts=2 sw=2 tw=0:
