module heap.v2;

import test;

mixin test!sort;

void sort(T)(T[] array) @nogc nothrow pure
{

    foreach (i; 0 .. array.length)
    {
        upHeap(array[0 .. i + 1]);
    }
    foreach_reverse (i; 0 .. array.length)
    {
        downHeap(array[0 .. i + 1]);
    }
}

void upHeap(T)(T[] heap) @nogc nothrow pure
{
    size_t element = heap.length;
    while (element != 1)
    {
        size_t parent = element >> 1; // element / 2;
        if (heap[parent - 1] < heap[element - 1])
        {
            swap(heap[parent - 1], heap[element - 1]);
            element = parent;
        }
        else
        {
            return;
        }
    }
}

void downHeap(T)(T[] heap) @nogc nothrow pure
{
    swap(heap[0], heap[$ - 1]);
    auto newHeap = heap[0 .. $ - 1];

    size_t element = 1;
    while ((element << 1) - 1 < newHeap.length) // (element * 2 - 1 < newHeap.length)
    {
        size_t bigChild = () {
            immutable child1 = element << 1; // element * 2;
            immutable child2 = child1 + 1;

            immutable child2Exists = child2 - 1 < newHeap.length;

            if (child2Exists && newHeap[child1 - 1] < newHeap[child2 - 1])
                return child2;
            else
                return child1;
        }();

        if (newHeap[element - 1] < newHeap[bigChild - 1])
        {
            swap(newHeap[element - 1], newHeap[bigChild - 1]);
            element = bigChild;
        }
        else
        {
            return;
        }
    }
}

void swap(T)(ref T a, ref T b) @nogc nothrow pure
{
    immutable tmp = a;
    a = b;
    b = tmp;
}
