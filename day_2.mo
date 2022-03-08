import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {
    // Challenge 1
    public func nat_to_nat8(n : Nat) : async ?Nat8 {
        if (n > 255) { return null; };
        return ?Nat8.fromNat(n);
    };

    // Challenge 2
    public func max_number_with_n_bits(n : Nat) : async Nat {
        return Nat.pow(2, n);
    };

    // Challenge 3
    public func decimal_to_bits(n : Nat) : async Text {
        if (n == 0) { return "0"; };
        var decimal : Nat = n;
        var bits : Text = "";
        while (decimal > 0) {
            bits := Nat.toText(decimal % 2) # bits;
            decimal := decimal / 2;
        };
        return bits;
    };

    // Challenge 4
    private func capitalize_character(c : Char) : Char {
        var asc2 : Nat32 = Char.toNat32(c);
        if (Nat32.greaterOrEqual(asc2, 97) and Nat32.lessOrEqual(asc2, 122)) {
            return Char.fromNat32(Char.toNat32(c) - 32);
        };
        return c;
    };
    // public func test_capitalize_character(asc2 : Nat32) : async Char {
    //     return capitalize_character(Char.fromNat32(asc2));
    // };

    // Challenge 5
    public func capitalize_text(t : Text) : async Text {
        return Text.map(t, func (c : Char) : Char {
            return capitalize_character(c);
        });
    };

    // Challenge 6
    private func is_inside(t : Text, c : Char) : Bool {
        return Text.contains(t, #char c);
    };
    // public func test_is_inside(t : Text, asc2 : Nat32) : async Bool {
    //     return is_inside(t, Char.fromNat32(asc2));
    // };

    // Challenge 7
    public func trim_whitespace(t : Text) : async Text {
        return Text.trim(Text.trim(t, #char ' '), #char '　');
    };

    // Challenge 8
    public func duplicated_character(t : Text) : async Text {
        var chars : [Char] = Iter.toArray(t.chars());
        var last_idx : Nat = chars.size() - 1;
        for (i in Iter.range(0, last_idx)) {
            for (j in Iter.range(i + 1, last_idx)) {
                if (Char.equal(chars[i], chars[j])) {
                    return Char.toText(chars[i]);
                };
            };
        };
        return t;
    };

    // Challenge 9
    public func size_in_bytes(t : Text) : async Nat {
        return Text.encodeUtf8(t).size();
    };

    // Challenge 10
    public func bubble_sort(nums : [Nat]) : async [Nat] {
        var sorted_nums : [var Nat] = Array.thaw(nums);
        var last_idx : Nat = sorted_nums.size() - 1;
        for (i in Iter.range(0, last_idx)) {
            for (j in Iter.range(0, last_idx - i - 1)) {
                if (sorted_nums[j] > sorted_nums[j+1]) {
                    var tmp = sorted_nums[j];
                    sorted_nums[j] := sorted_nums[j+1];
                    sorted_nums[j+1] := tmp;
                }; 
            };
        };
        return Array.freeze(sorted_nums);
    };
};