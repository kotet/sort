module stooge.v1;

import test;

mixin test!sort;

void sort(T)(T[] array) @nogc nothrow pure
{
    if (array[$ - 1] < array[0])
    {
        immutable tmp = array[0];
        array[0] = array[$ - 1];
        array[$ - 1] = tmp;
    }
    if (3 <= array.length)
    {
        sort(array[0 .. $ - ($ / 3)]);
        sort(array[$ / 3 .. $]);
        sort(array[0 .. $ - ($ / 3)]);
    }
}
