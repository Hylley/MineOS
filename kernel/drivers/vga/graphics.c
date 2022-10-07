#include "graphics.h"
#include "..\..\utils\types.h"
#include "..\..\utils\math.c"


void plot(Vector2 position, int color)
{
    unsigned int location = (SCREEN_WIDTH * position.y) + position.x;
	*(char *)(GRAFIC_MEMORY + location) = color;
}

void fill(int color)
{
    for(int y = 0; y < SCREEN_HEIGHT; y++)
    {
        for(int x = 0; x < SCREEN_WIDTH; x++)
        {
            Vector2 position = {x, y};
            plot(position, color);
        }
    }
}

void draw_line(Vector2 start, Vector2 end, int color)
{
    Vector2 distance = {
        abs(end.x - start.x),
        abs(end.y - start.y)
    };

    Vector2 direction = {
        sig(end.x - start.x),
        sig(end.y - start.y)
    };

    Vector2 counter = {
        distance.y >> 1,
        distance.x >> 1
    };
    Vector2 draw_point = start;

    plot(start, color);
    
    if (distance.x >= distance.y)
    {
        for(int i = 0; i < distance.x; i++)
        {
            counter.y += distance.y;

            if(counter.y >= distance.x)
            {
                counter.y -= distance.x;
                draw_point.y += direction.y;
            }

            draw_point.x += direction.x;

            plot(draw_point, color);
        }

        return;
    }

    for(int i = 0; i < distance.y; i++)
    {
        counter.x += distance.x;

        if(counter.x >= distance.y)
        {
            counter.x -= distance.y;
            draw_point.x += direction.x;
        }

        draw_point.y += direction.y;

        plot(draw_point, color);
    }
}