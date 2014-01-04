source t/init.vim

let test_cases = [
\ ['fixstr len [0, 31]', '', 'A0'],
\ ['fixstr len [0, 31]', '魚', 'A3E9AD9A'],
\ ['fixstr len [0, 31]', Repeat('a', 0x01), 'BF' . Repeat('61', 0x01)],
\ ['str8 len [0, 2^8-1]', Repeat('a', 0x20), 'D920' . Repeat('61', 0x20)],
\ ['str8 len [0, 2^8-1]', Repeat('a', 0xff), 'D9FF' . Repeat('61', 0xff)],
\ ['str16 len [0, 2^16-1]', Repeat('a', 0x0100), 'DA0100' . Repeat('61', 0x0100)],
\ ['str16 len [0, 2^16-1]', Repeat('a', 0xffff), 'DAFFFF' . Repeat('61', 0xffff)],
\ ['str32 len [0, 2^32-1]', Repeat('a', 0x010000), 'DA010000' . Repeat('61', 0x010000)],
\ ['str32 len [0, 2^32-1]', Repeat('a', 0xffffff), 'DAFFFFFF' . Repeat('61', 0xffffff)],
\]

call TestPack(test_cases)
call TestUnpack(test_cases)

" vim: set et ts=2 sts=2 sw=2 tw=0:
