module test;

mixin template test(alias F, alias N)
{
    unittest
    {
        import std.stdio : writefln;
        import std.traits : fullyQualifiedName;
        import std.algorithm : map, reduce;
        import std.range : iota;

        writefln!"Test %s:"(fullyQualifiedName!F);
        foreach (n; 1 .. N + 1)
        {
            auto func = () {
                import std.random : randomShuffle;
                import std.range : array, iota;
                import std.datetime : Duration, StopWatch, to;
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
            };
            auto result = iota(100).map!(_ => func()).reduce!((a, b) => a + b) / 100;
            writefln!"    N = 10^^%s: %s msecs"(n, result);
        }
    }
}
