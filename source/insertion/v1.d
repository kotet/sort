module insertion.v1;

import test;

mixin test!sort;

void sort(T)(T[] array) @nogc nothrow pure
{
    if (array.length < 2)
        return;

    auto sorted = array[0 .. 1];

    foreach (i, n; array[0 .. $])
    {
        if (i == 0)
            continue;

        auto insertion = bisection(sorted, n);
        shift(array[insertion .. i + 1]);
        array[insertion] = n;

        sorted = array[0 .. i + 1];
    }
}

size_t bisection(T)(T[] sorted, T n) @nogc nothrow pure
{
    if (sorted.length == 1)
        return (sorted[0] < n) ? 1 : 0;

    if (sorted[$ - 1] < n)
        return sorted.length;

    size_t min = -1;
    size_t max = sorted.length;

    while (max - min != 1)
    {
        size_t mid = (max + min) / 2;

        if (sorted[mid] < n)
            min = mid;
        else
            max = mid;
    }

    return min + 1;
}

void shift(T)(T[] array) @nogc nothrow pure
{
    foreach_reverse (i; 1 .. array.length)
    {
        array[i] = array[i - 1];
    }
}
