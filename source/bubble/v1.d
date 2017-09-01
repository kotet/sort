module bubble.v1;

import test;

mixin test!(sort, 3);

void sort(int[] random) @nogc @safe nothrow pure
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
