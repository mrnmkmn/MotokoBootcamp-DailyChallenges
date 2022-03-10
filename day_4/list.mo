module {
    // Challenge 7
    public type List<T> = ?(T, List<T>);

    public func is_null(l : List<T>) : async Bool {
        switch l {
            case null true;
            case ?_ false;
        };
    };

    // Challenge 8
    public func last(l : List<T>) : ?T {
        switch l {
            case null { null };
            case (?(x, null)) { ?x };
            case (?(_, t)) { last<T>(t) };
        };
    };

    // Challenge 9
    public func size(l : List<T>) : Nat {
        func rec(l : List<T>, n : Nat) : Nat {
            switch l {
                case null { n };
                case (?(_, t)) { rec(t, n + 1) };
            };
        };
        rec(l,0);
    };

    // Challenge 10
    public func get(l : List<T>, n : Nat) : ?T {
        switch (n, l) {
            case (_, null) { null };
            case (0, (?(h, t))) { ?h };
            case (_, (?(_, t))) { get<T>(t, n - 1) };
        };
    };

    // Challenge 11
    public func reverse(l : List<T>) : List<T> {
        func rec(l : List<T>, r : List<T>) : List<T> {
            switch l {
                case null { r };
                case (?(h, t)) { rec(t, ?(h, r)) };
            };
        };
        rec(l, null);
    };
};