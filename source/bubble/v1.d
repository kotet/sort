module bubble.v1;

import test;

mixin test!sort;

void sort(T)(T[] random) @nogc nothrow pure
{
    foreach (i, n; random)
    {
        foreach (j, m; random[0 .. $ - i - 1])
        {
            if (random[j + 1] < m)
            {
                random[j] = random[j + 1];
                random[j + 1] = m;
            }
        }
    }
}
