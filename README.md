Лабораторная по компьютерной графике
====================================

Задание по лабораторной работе № 1
----------------------------------

1. Познакомиться с правилами выполнения лабораторных работ (файл RULES.TXT).

2. В видеоадаптере CGA (черно-белом) в видеопамяти на фоне всех нулей в байт с адресом 2000h+A0h относительно начала видеопамяти записан код 09h.  Определить, что отобразится на экране в этом случае, и обоснование этого определения представить преподавателю.
Разработать программу, отображающую это на экране.

3. Разработать программу для этого же видеоадаптера для вывода на экран точки с координатами x = 213, y = 101 (не используя функцию BIOS!). 
Значения координат можно задавать непосредственно в тексте программы.

4. На базе разработанной программы вывода точки разработать программу построения горизонтальной линии произвольного размера от минимального (в один пиксель) до максимального (640 пикселей). Стремиться к максимальной скорости построения линии.

5. Разработать программу построения вертикальной линии произвольного размера.

6. Получить у преподавателя задание на построения фигуры на базе процедур построения горизонтальной и вертикальной линий.


Компилирование
--------------

    $ nasm -f bin l3.asm -o l3.exe
    
В Sublime Text можно создать Build System, чтобы компилировать по нажатию Ctrl+B, без применения консоли. Это делается следующим образом:

1. Tools -> Build -> New Build System...
2. Вставляем следующее содержимое (для *nix поменять четыре обратных слеша на один обычный :):
    
        {
            "cmd": ["nasm", "-f", "bin", "${file}", "-o", "${file_path}\\\\${file_base_name}.exe"],
            "working_dir": "${file_path}"
        }

3. Сохранить под тем названием, которое нравится, в папке User (например, NASM.sublime-build)
4. В соответствующем файле выбрать соответствующую систему (Tools -> Build -> NASM)
5. Готово, можно билдить.
