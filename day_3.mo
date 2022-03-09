import Nat "mo:base/Nat";
import Array "mo:base/Array";

actor {
    // Challenge 1
    private func swap(array : [var Nat], j : Nat, i : Nat) : [var Nat] {
        var swapped_array = array;
        var tmp = swapped_array[j];
        swapped_array[j] := swapped_array[i];
        swapped_array[i] := tmp;
        return swapped_array;
    };

    // Challenge 2
    public func init_count(n : Nat) : async [Nat] {
        return Array.tabulate(n, func (i : Nat) : Nat {
            return i;
        });
    };

    // Challenge 3
    public func seven(array : [Nat]) : async Text {
        var containsSeven : Bool = (Array.find<Nat>(array, func (n : Nat) : Bool {
            if (n == 7) { return true; };
            return false;
        }) != null);
        if (containsSeven) {
            return "Seven is found";
        } else {
            return "Seven not found";
        };
    };

    // Challenge 4
    public func nat_opt_to_nat(n : ?Nat, m : Nat) : async ?Nat {
        if (n == null) { return ?m; };
        return n;
    };

    // Challenge 5
    public func day_of_the_week(n : Nat) : async ?Text {
        switch (n) {
            case 1 ?"Monday";
            case 2 ?"Tuesday";
            case 3 ?"Wednesday";
            case 4 ?"Thursday";
            case 5 ?"Friday";
            case 6 ?"Saturday";
            case 7 ?"Sunday";
            case default null;
        };
    };

    // Challenge 6
    public func populate_array(array : [?Nat]) : async [Nat] {
        return Array.map(array, func (?num : ?Nat) : Nat {
            if (?num == null) { return 0; };
            return num;
        });
    };

    // Challenge 7
    public func sum_of_array(array : [Nat]) : async Nat {
        return Array.foldLeft(array, 0, func (acc : Nat, num : Nat) : Nat {
            return Nat.add(acc, num);
        });
    };

    // Challenge 8
    public func squared_array(array : [Nat]) : async [Nat] {
        return Array.map(array, func (num : Nat) : Nat {
            return Nat.mul(num, num);
        });
    };

    // Challenge 9
    public func increase_by_index(array : [Nat]) : async [Nat] {
        return Array.mapEntries(array, func (num : Nat, idx : Nat) : Nat {
            return num + idx;
        });
    };

    // Challenge 10
    func contains<A>(array : [A], a : A, f : (A,A) -> Bool) : async Bool {
        switch ((Array.find<A>(array, func (n : A) {f(n, a)}))) {
            case (?exists) true;
            case (null) false;
        };
    };
 };