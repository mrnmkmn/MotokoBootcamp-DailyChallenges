import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";

actor {
    /* Challenge 9 --- */

    // Challenge 2
    stable var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    // Challenge 3
    public shared({caller}) func add_favorite_number(n : Nat) : async () {
        favoriteNumber.put(caller, n);
    };
    public shared({caller}) func show_favorite_number() : async ?Nat {
        favoriteNumber.get(caller);
    };

    // Challenge 4
    public shared({caller}) func add_favorite_number_2(n : Nat) : async Text {
        switch (favoriteNumber.get(caller)) {
            case (null) {
                favoriteNumber.put(caller, n);
                return "You've successfully registered your number";
            };
            case (?_) {
                return "You've already registered your number";
            };
        };
    };

    // Challenge 5
    public shared({caller}) func update_favorite_number(n : Nat) : async ?Nat {
        return favoriteNumber.replace(caller, n);
    };
    public shared({caller}) func delete_favorite_number() : async () {
        favoriteNumber.delete(caller);
    };

    /* --- Challenge 9 */
}