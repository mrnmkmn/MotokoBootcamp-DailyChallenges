import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";

actor {
    // Challenge 1
    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");

    public shared({caller}) func is_anonymous() : async Bool {
        return Principal.equal(caller, anonymous_principal);
    };

    // Challenge 2
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

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

    // Challenge 6
    public func deposit_cycles() : async Nat {
        return Cycles.accept(Cycles.available());
    };

    // Challenge 7
     var savings : Nat = 0;
    //  public shared(msg) func withdraw_cycles(amount : Nat) : async () {
    //     assert (msg.caller == msg.caller);
    //     assert (amount <= savings);
    //     Cycles.add(amount);
    //     let refund = Cycles.refunded();
    //     savings -= amount - refund;
    // };

    // Challenge 8
    stable var versionNumber : Nat = 0;
    stable var counter : Nat = 0;
    public func increment_counter(n : Nat) : async () {
        versionNumber += 1;
        counter += n;
    };
    
    // Challenge 10
};