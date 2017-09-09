module selection.v1;

import test;

mixin test!sort;

void sort(T)(T[] array) @nogc nothrow pure
{
    foreach (i; 0 .. array.length)
    {
        select(array[i .. $]);
    }
}

void select(T)(T[] array) @nogc nothrow pure
{
    auto i = min(array);
    auto tmp = array[0];

    array[0] = array[i];
    array[i] = tmp;
}

size_t min(T)(T[] array) @nogc nothrow pure
{
    size_t result = 0;
    foreach (i; 0 .. array.length)
    {
        if (array[i] < array[result])
        {
            result = i;
        }
    }
    return result;
}
