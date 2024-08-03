#include <print.h>
#include <stdio.h>

const static size_t NUM_COLS = 80;
const static size_t NUM_ROWS = 25;

struct chr_struct
{
    uint8_t chr;
    uint8_t color;
};

struct chr_struct *buffer = (struct chr_struct *)0xB8000;
size_t col = 0, row = 0;
uint8_t color = PRINT_COLOR_LIGHT_GRAY | PRINT_COLOR_BLACK << 4;

void clear_row(size_t row)
{
    struct chr_struct empty = (struct chr_struct){
        chr : ' ',
        color : color
    };

    for (size_t col = 0; col < NUM_COLS; col++)
    {
        buffer[col + NUM_COLS * row] = empty;
    }
}

void clear()
{
    for (size_t row = 0; row < NUM_ROWS; row++)
    {
        clear_row(row);
    }
    move_cursor(0, 0);
}

void print_newline()
{
    col = 0;

    if (row < NUM_ROWS - 1)
    {
        row++;
        return;
    }

    for (size_t row = 1; row < NUM_ROWS; row++)
    {
        for (size_t col = 0; col < NUM_COLS; col++)
        {
            struct chr_struct chr = buffer[col + NUM_COLS * row];
            buffer[col + NUM_COLS * (row - 1)] = chr;
        }
    }

    clear_row(NUM_ROWS - 1);
}

void putc(char chr)
{
    if (chr == '\n')
    {
        print_newline();
        move_cursor(row, col);
        return;
    }

    if (col >= NUM_COLS)
    {
        print_newline();
    }

    buffer[col + NUM_COLS * row] = (struct chr_struct){
        chr : (uint8_t)chr,
        color : color
    };

    col++;
    move_cursor(row, col);
}

void puts(char *str)
{
    for (size_t i = 0; 1; i++)
    {
        char chr = (uint8_t)str[i];

        if (chr == '\0')
        {
            return;
        }

        putc(chr);
    }
}

void set_print_color(uint8_t foreground, uint8_t background)
{
    color = foreground + (background << 4);
}

void move_cursor(size_t row, size_t col)
{
    uint16_t pos = row * 80 + col;

    outb(0x3D4, 14);
    outb(0x3D5, (pos >> 8) & 0xFF);

    outb(0x3D4, 15);
    outb(0x3D5, pos & 0xFF);
}