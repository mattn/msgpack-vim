source t/init.vim

" -118.625
" sign(1 bit) - exponent(11 bit) - fraction(52 bit)
" 1 - 000 1000 0101 - 0000 0000 0000 0000 0000 0000 0000 0110 1101 0100 0000 0000 0000
let test_cases = [
\ ['-118.625', -118.625, 'CBC05DA80000000000'],
\]

call TestPack(test_cases)
call TestUnpack(test_cases)

" vim: set et ts=2 sts=2 sw=2 tw=0:
