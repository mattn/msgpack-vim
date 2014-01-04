source t/init.vim

function! s:powi(x, y)
    return float2nr(pow(a:x, a:y))
endfunction

" TODO negative case
" int8 (8bit signed-int)
" int16 (16bit signed-int)
" int32 (32bit signed-int)
let test_cases = [
\ ['zero', 0, '00'],
\ ['positive-fixnum (7bit positive int)', 1,                '01'],
\ ['positive-fixnum (7bit positive int)', s:powi(2, 7) - 1, '7F'],
\ ['int16 (16bit signed-int)', s:powi(2, 7),      'D10080'],
\ ['int16 (16bit signed-int)', s:powi(2, 8) - 1,  'D100FF'],
\ ['int16 (16bit signed-int)', s:powi(2, 8),      'D10100'],
\ ['int16 (16bit signed-int)', s:powi(2, 15) - 1, 'D17FFF'],
\ ['int32 (32bit signed-int)', s:powi(2, 15),     'D200008000'],
\ ['int32 (32bit signed-int)', s:powi(2, 16) - 1, 'D20000FFFF'],
\ ['int32 (32bit signed-int)', s:powi(2, 16),     'D200010000'],
\ ['int32 (32bit signed-int)', s:powi(2, 32) - 1, 'D27FFFFFFF'],
\ ['negative-fixnum (5bit negative int)', -1, 'FF'],
\]

call TestPack(test_cases)
call TestUnpack(test_cases)

" vim: set et ts=2 sts=2 sw=2 tw=0:
