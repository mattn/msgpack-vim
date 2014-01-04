set cpo&vim

function! Repeat(expr, count)
  return join(map(range(1, a:count), 'a:expr'), '')
endfunction

function! TestPack(test_cases)
  call s:test_by_cases(function('msgpack#pack'), a:test_cases)
endfunction

function! TestUnpack(test_cases)
  " TODO: implements
  " let reversed = map(copy(a:test_cases), '[v:val[0], v:val[2], v:val[1]]')

  " call s:test_by_cases(function('msgpack#unpack'), reversed)
endfunction

function! s:test_by_cases(funcref, test_cases)
  for test_case in a:test_cases
    let name = test_case[0]
    let arg = test_case[1]
    let expected = test_case[2]
    let actually = a:funcref(arg)

    if actually ==# expected
      echomsg name . ' is OK'
    else
      echoerr name . ' is NG, arg : ' . string(arg) . ', expected : ' . string(expected) . ', actually : ' . string(actually)
    endif
  endfor
endfunction

" vim: set et ts=2 sts=2 sw=2 tw=0:
