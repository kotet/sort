module merge.v3;

import test;

mixin test!sort;

void sort(T)(T[] array)
{
    parallelSort(array);
}

void parallelSort(T)(T[] array)
{
    if (array.length < 10 ^^ 4)
    {
        serialSort(array);
    }
    else
    {
        import std.parallelism : task;

        auto t = task!parallelSort(array[$ / 2 .. $]);
        t.executeInNewThread();

        parallelSort(array[0 .. $ / 2]);

        t.yieldForce();

        merge(array);
    }
}

void serialSort(T)(T[] array)
{
    if (array.length < 2)
        return;
    sort(array[0 .. $ / 2]);
    sort(array[$ / 2 .. $]);
    merge(array);
}

void merge(T)(T[] array)
{
    import std.range : empty, front, popFront;

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
