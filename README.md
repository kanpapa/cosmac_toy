# COSMAC Toy Computer

COSMAC Toy Computerは「トラ技別冊 つくるシリーズ7 手作りコンピュータ入門」（1981年5月初版）を参考にして、COSMAC CPUボードやプログラムローダーや実験回路をコンパクトな基板にまとめて製作したものです。  
ROMは搭載されておらず、プログラムローダーのトグルスイッチでRAMにプログラムを書き込んで実行することができます。

![image](/docs/images/cosmac_pcb_all.jpg)

## Information

- 各基板はオレンジピコショップさんで[COSMACシリーズ](https://store.shopping.yahoo.co.jp/orangepicoshop/cosmaca5b7.html)として販売中です。
- CQ出版社 [トランジスタ技術2019年10月号](https://toragi.cqpub.co.jp/tabid/889/Default.aspx)に製作記事が掲載されています。
- [COSMAC研究会](https://kanpapa.com/cosmac/blog/cosmac-toy/)に製作記事をまとめています。
- プログラムの入力と実行例を[Quick start guide](/docs/cosmac_toy_computer_quick_start_guide.pdf)にまとめました。
- サンプルプログラムのソースと実験記事を[programs](/programs/README.md)にまとめました。

## COSMAC CPUボード

COSMAC CPUに最低限の周辺回路を付加しました。クロックはCR発振です。ブートローダー基板用の20ピンコネクタとシールド基板用の12ピンコネクタを実装しました。  
メモリはバッテリバックアップされた6264ですが、実際に使っているのは先頭から256バイトだけです。これはトグルスイッチで正確に手入力できるのは256バイトが限界と思われるためです。  
Q出力は簡易アンプでスピーカーを直接駆動したり、アンプを通さずに直接デジタル信号として使用することができます。  
シールド基板のサイズは秋月電子のC基板に合わせましたので、ユニバーサル基板でのシールドの試作も可能です。

![Image](/docs/images/cosmac_cpu_rev1_3.png)

- COSMAC CPUボード回路図 [cosmac_cpu_rev1_4_sch.pdf](/schematics/cosmac_cpu_rev1_4_sch.pdf) (Rev1.4 2019/9/9)
- 部品表 [cosmac_cpu_rev1_4_bom.md](/bom/cosmac_cpu_rev1_4_bom.md)
- 補足説明
    - SW1はメモリスタンバイスイッチです。STBにするとバッテリーで内容が保持されます。
    - JP1はQ出力をアンプに通すか、直接出力するかの選択用です。スピーカーを直接接続する場合はAMPをジャンパしてください。Q出力をデジタル信号として使用する場合はCPUをジャンパしてください。
- 製作記事
    - [RCA CDP1802 COSMACを動かしてみた(1) 組み立て編](https://kanpapa.com/cosmac/blog/2018/11/rca-cdp1802-cosmac1.html)
    - [RCA CDP1802 COSMACを動かしてみた(2) 動作確認編](https://kanpapa.com/cosmac/blog/2018/11/rca-cdp1802-cosmac2.html)
    - [RCA CDP1802 COSMACを動かしてみた(3) アセンブラ編](https://kanpapa.com/cosmac/blog/2018/11/rca-cdp1802-cosmac3.html)
    - [RCA CDP1802 COSMACを動かしてみた(4) プログラミング編](https://kanpapa.com/cosmac/blog/2018/12/rca-cdp1802-cosmac4.html)

## プログラムローダーボード

プログラムローダーはトグルスイッチでプログラムを入力するためのものです。シンプルな回路のため、バスにシールドを接続したままだと、スイッチが機能しないこともあります。そのためプログラムの書き込みを行う場合はシールドを一度取り外してメモリに書き込んだあとに、シールドを接続します。シールドの取り外しを行うときはメモリをスタンバイにすることで、メモリの内容は保持されます。
LEDはバスの信号をラッチして点灯します。2つのスライドスイッチで、CPUの動作モードを設定したあとに、DMA INにつながっているプッシュスイッチを押すことで、トグルスイッチで設定した値をメモリに書き込むことができます。

![Image](/docs/images/cosmac_boot_beta.png)

- プログラムローダー回路図 [cosmac_boot_rev1_sch.pdf](/schematics/cosmac_boot_rev1_sch.pdf) (Rev1.0 2019/9/9)
- 部品表 [cosmac_boot_rev1_0_bom.md](/bom/cosmac_boot_rev1_0_bom.md)
- 製作記事
    - [RCA CDP1802 COSMACを動かしてみた(5) 基板発注編](https://kanpapa.com/cosmac/blog/2018/12/rca-cdp1802-cosmac5.html)
    - [RCA CDP1802 COSMACを動かしてみた(6) 基板動作編](https://kanpapa.com/cosmac/blog/2019/01/rca-cdp1802-cosmac6.html)
    - [RCA CDP1802 COSMACを動かしてみた(7) 音を出してみる編](https://kanpapa.com/cosmac/blog/2019/02/rca-cdp1802-cosmac7.html)

## ミニ電子オルガンシールド

８つの端子に8ビットプライオリティエンコーダを接続しました。どれかの端子にリード線が触れると、4ビットの信号に変換されます。COSMAC CPUはこの信号を読み取って、どの音階が選択されたかを判断し、音階に応じた音声信号をQ端子から出力しスピーカーを鳴らします。

![Image](/docs/images/cosmac_organ.png)

- ミニ電子オルガンシールド [cosmac_organ_rev1_1_sch.pdf](/schematics/cosmac_organ_rev1_1_sch.pdf) (Rev1.1 2019/9/9)
- 部品表 [cosmac_organ_rev1_1_bom.md](/bom/cosmac_organ_rev1_1_bom.md)
- 製作記事 [RCA CDP1802 COSMACを動かしてみた(8) 電子オルガンを作ってみる](https://kanpapa.com/cosmac/blog/2019/02/rca-cdp1802-cosmac8.html)

## 液晶表示シールド

4ビットのパラレルバスで表示できる液晶モジュールを接続しました。COSMAC CPUから液晶モジュールに初期設定の命令を送ったあとに文字コードを送ることで液晶画面に文字を表示することができます。

![Image](/docs/images/cosmac_lcd.png)

- 液晶表示シールド [cosmac_lcd_rev1_1_sch.pdf](/schematics/cosmac_lcd_rev1_1_sch.pdf)（Rev1.1 2019/7/13）
- 部品表 [cosmac_lcd_rev1_1_bom.md](/bom/cosmac_lcd_rev1_1_bom.md)
- 製作記事 [RCA CDP1802 COSMACを動かしてみた(9) LCDに文字を表示してみる](https://kanpapa.com/cosmac/blog/2019/05/rca-cdp1802-cosmac9-lcd.html)

## DCモーターシールド

マイコンで制御できるモータードライバ基板です。秋月電子のAE-TB6612モータードライバキットを搭載することで、COSMAC CPUで２つのDCモーターを制御（正転、逆転、停止）できます。

![Image](/docs/images/cosmac_motor.png)

- DCモーターシールド [cosmac_motor_rev1_1_sch.pdf](/schematics/cosmac_motor_rev1_1_sch.pdf)（Rev1.1 2019/7/13）
- 部品表 [cosmac_motor_rev1_1_bom.md](/bom/cosmac_motor_rev1_1_bom.md)
- 製作記事 [RCA CDP1802 COSMACを動かしてみた(11) モーターを制御してみた](https://kanpapa.com/cosmac/blog/2019/06/rca-cdp1802-cosmac11-1.html)

## 音声出力シールド

マイコンで制御できる音声合成ICAquesTalkPicoを接続しました。この音声合成ICにあらかじめ音声をプリセットし、COSMAC CPUでプリセット音を選択して発声するようにしました。声のパターンは限られてしまいますが、14種類の音声メッセージを出すことができます。

![Image](/docs/images/cosmac_AquesTalkpico.png)

- 音声出力シールド [cosmac_talk_rev1_1_sch.pdf](/schematics/cosmac_talk_rev1_1_sch.pdf)（Rev1.1 2019/9/13）
- 部品表  [cosmac_talk_rev1_1_bom.md](/bom/cosmac_talk_rev1_1_bom.md)
- 製作記事　準備中

## KiCADデータ

- COSMAC CPUボード [cosmac_cpu_rev1_4_kicad.zip](/kicad/cosmac_cpu_rev1_4_kicad.zip) (Rev1.4 2019/9/9)
- プログラムローダー [cosmac_boot_rev1_kicad.zip](/kicad/cosmac_boot_rev1_kicad.zip) (Rev1.0 2019/9/9)
- ミニ電子オルガンシールド（準備中）
- 液晶表示シールド（準備中）
- DCモーターシールド（準備中）
- 音声出力シールド（準備中）

## ガーバーデータ

- COSMAC CPUボード [cosmac_cpu_rev1_4_gerber.zip](/gerber/cosmac_cpu_rev1_4_gerber.zip) (Rev1.4)
- プログラムローダー [cosmac_boot_rev1_garber.zip](/gerber/cosmac_boot_rev1_gerber.zip) (Rev1.0)
- ミニ電子オルガンシールド [cosmac_organ_rev1_1_gerber.zip](/gerber/cosmac_organ_rev1_1_gerber.zip) (Rev1.1)
- 液晶表示シールド [cosmac_lcd_rev1_1_gerber.zip](/gerber/cosmac_lcd_rev1_1_gerber.zip) (Rev1.1)
- DCモーターシールド [cosmac_motor_rev1_1_gerber.zip](/gerber/cosmac_motor_rev1_1_gerber.zip) (Rev1.1)
- 音声出力シールド [cosmac_talk_rev1_1_gerber.zip](/gerber/cosmac_talk_rev1_1_gerber.zip) (Rev1.1)

## サンプルアプリケーション

GitHub.comにあります。  
https://github.com/kanpapa/cosmac


## 参考・引用文献

- トランジスタ技術別冊　つくるシリーズ７　手作りコンピュータ入門 CQ出版社, 1981
- [KiCad 5.0 / 5.1 入門実習テキスト『KiCad Basics for 5.x』 　Kosaka.Lab.出版掛 マッハ新書](https://booth.pm/ja/items/941963)
- [intersil CDP1802AC/3データシート](https://www.renesas.com/jp/ja/www/doc/datasheet/cdp1802ac-3.pdf)
- [SB-Assembler](https://www.sbprojects.net/sbasm/)
- [COSMAC ELF - RCA CDP1802 Computing](http://www.cosmacelf.com/)
- [Compute II Issue 3: The 1802 Instruction Set](https://www.atarimagazines.com/computeii/issue3/page52.php)
- [The 1802 Membership Card](http://www.sunrise-ev.com/1802.htm)

## 利用上の注意

本サイトに掲載している回路、技術、プログラムなどは無保証です。  
これらの利用によって発生したトラブルには責任を負いかねます。自己責任にてご利用ください。  
KiCADデータおよびガーバーデータはCC BY-SA 4.0 (Copyright (C) 2019 Kazuhiro Ouchi)です。  
サンプルプログラムはMITライセンスです。  
