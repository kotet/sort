module merge.v1;

import test;

mixin test!sort;

void sort(T)(T[] array) nothrow pure
{
    array[] = mergeSort(array);
}

private T[] mergeSort(T)(T[] array) nothrow pure
{
    import std.range : empty, front, popFront;

    if (array.length < 2)
    {
        return array.dup;
    }
    else
    {
        auto a = mergeSort(array[0 .. $ / 2]);
        auto b = mergeSort(array[$ / 2 .. $]);
        T[] result;

        foreach (i; 0 .. a.length + b.length)
        {
            if (a.empty)
            {
                result ~= b.front;
                b.popFront();
            }
            else if (b.empty || a.front < b.front)
            {
                result ~= a.front;
                a.popFront();
            }
            else
            {
                result ~= b.front;
                b.popFront();
            }
        }

        return result;
    }
}
