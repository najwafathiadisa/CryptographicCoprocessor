# Mini_Processor

Sebuah mini processor yang didalamnya terdapat register dengan ukuran 16x16 bit, alu, shifter, juga hasher.
Alu disini memiliki fitur dengan operasi ADD, SUB, AND, OR, XOR, NOT, dan MOVE dengan nilai opcodenya masing-masing
Shifter disini memiliki fitur dengan operasi ROR8, ROR4 dan juga SLL8 yang memiliki nilai opcode nya masing-masing
Hasher disini menggunakan mekanisme non linear lookup table sehingga hashingnya akan jauh lebih cepat karena dapat berjalan secara paralel dan selesai pada clock yang sama. dengan kata lain tidak membutuhkan state yang berbeda. Hanya saja ia kurang dari segi keamanan, karena apabila key nya tersebar, maka siapapun dapat mengetahui isi data sebenarnya