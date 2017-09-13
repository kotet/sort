module test;

static import std.algorithm.sorting;

mixin test!(std.algorithm.sorting.sort);

mixin template test(alias F)
{
    unittest
    {
        import std.stdio : writefln;
        import std.traits : fullyQualifiedName;
        import std.algorithm : map, reduce;
        import std.range : iota;

        writefln!"Test %s:"(fullyQualifiedName!F);

        size_t sample;
        size_t n;
        do
        {
            import std.datetime : StopWatch;
            import core.time : TickDuration;

            sample = 0;
            double result = 0;
            StopWatch s;
            s.start();
            do
            {
                sample++;
                result += () {
                    import std.random : randomShuffle;
                    import std.range : array, iota;
                    import std.datetime : StopWatch, to;
                    import std.conv : to;

                    auto random = iota(10 ^^ n).array();
                    random.randomShuffle();
                    auto answer = iota(10 ^^ n).array();

                    StopWatch s;
                    s.start();

                    F(random);

                    s.stop();

                    assert(random == answer);
                    return s.peek().to!("msecs", double);
                }();
            }
            while (s.peek() < TickDuration.from!"msecs"(100));

            writefln!"    N = 10^^%s avg: %s msecs (sample: %s)"(n, result / sample, sample);
            
            n++;
        }
        while (1 < sample);
    }
}
