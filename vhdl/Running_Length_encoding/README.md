<!---
/*******************************************************************************
// Project name   : Running Length Encoding
// File name      : README.md
// Created date   : !!DATE
// Author         : Huy Hung Ho
// Last modified  : !!DATE
// Desc           :
*******************************************************************************/
-->
Introduction
============
- Register 1, 2 lưa 2 dữ liệu trước và dữ liệu liền kề.
- Bộ so sánh sẽ so sánh 2 dữ liệu này.
- Kết quả so sanh sẽ đưa vào FSM để kiểm tra trạng thái dữ liệu có bằng nhau hay không, từ đó điều khiển Latch ký tự và counter khi nào tăng, khi nào reset.
- Nếu bằng nhau, FSM sẽ điều khiển tăng counter lên.
- Lưu trữ dữ liệu của register 2, khi có sự khác nhau, mở chốt Latch ký tự và dữ liệu sẽ đi ra, và ghi lại số lần counter đã thực thi và đẩu lên Multiplexer.
- Ta co thêm 1 bít điều khiển để contact giữa .

File
====
Running-Length-encoding.png
