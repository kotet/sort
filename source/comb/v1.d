module comb.v1;

import test;

mixin test!sort;

void sort(T)(T[] array) @nogc nothrow pure
{
    size_t gap = array.length;
    bool complete;
    do
    {
        complete = true;
        if (gap != 1)
            gap = gap * 10 / 13; // gap /= 1.3
        foreach (i, n; array[0 .. $ - gap])
        {
            if (array[i + gap] < n)
            {
                complete = false;
                array[i] = array[i + gap];
                array[i + gap] = n;
            }
        }
    }
    while (!(complete && (gap == 1)));
}
