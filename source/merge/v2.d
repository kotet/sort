module merge.v2;

import test;

mixin test!sort;

void sort(T)(T[] array) nothrow pure
{
    import std.range : empty, front, popFront;

    if (array.length < 2)
    {
        return;
    }

    sort(array[0 .. $ / 2]);
    sort(array[$ / 2 .. $]);

    auto f = array[0 .. $ / 2].dup;
    size_t b = array.length / 2;
    foreach (i; 0 .. array.length)
    {
        if (f.empty)
        {
            array[i] = array[b];
            b++;
        }
        else if (!(b < array.length) || f.front < array[b])
        {
            array[i] = f.front;
            f.popFront();
        }
        else
        {
            array[i] = array[b];
            b++;
        }
    }
}
