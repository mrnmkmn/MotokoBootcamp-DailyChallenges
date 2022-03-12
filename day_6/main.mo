import Nat "mo:base/Nat";
import Text "mo:base/Text";
import List "mo:base/List";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import HTTP "http";

actor {
    // Challenge 1
    public type TokenIndex = Nat;
    public type Error = {
        #AuthError;
        #InsufficientError;
    };

    // Challenge 2
    stable var entries : [(TokenIndex, Principal)] = [];
    // let registry = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash); // not stable
    let registry = HashMap.fromIter<TokenIndex, Principal>(entries.vals(), 0, Nat.equal, Hash.hash);

    // Challenge 3
    public type Result<T,E> = Result.Result<T, E>;

    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");
    var latest_minter : Principal = Principal.fromText("2vxsx-fae");

    var nextTokenIndex : Nat = 0;
    public shared ({caller}) func mint() : async Result<(), Error> {
        switch (Principal.equal(caller, anonymous_principal)) {
            case (true) {
                return #err(#AuthError);
            };
            case (false) {
                registry.put(nextTokenIndex, caller);
                nextTokenIndex += 1;
                latest_minter := caller;
                return #ok;
            };
        };
    };

    // Challenge 4
    public shared ({caller}) func transfer(to : Principal, tokenIndex : Nat) : async Result<(), Error> {
        switch (registry.get(tokenIndex)) {
            case (null) {
                return #err(#AuthError);
            };
            case (?_) {
                registry.put(tokenIndex, to);
                return #ok;
            };
        };
    };

    // Challenge 5
    public type List<TokenIndex> = ?(TokenIndex, List<TokenIndex>);

    public shared ({caller}) func balance() : async List<TokenIndex> {
        var caller_token_idxs = List.nil<TokenIndex>();
        for ((token_idx, principal) in registry.entries()) {
            if (Principal.equal(caller, principal)) {
                caller_token_idxs := List.push<TokenIndex>(token_idx, caller_token_idxs);
            };
        };
        return caller_token_idxs;
    };

    // Challenge 6
    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        var number_of_nft_minted_msg : Text = "number of nft minted so far: " # Nat.toText(nextTokenIndex);
        var principal_of_latest_minter_msg : Text = "principal of the latest minter: " # Principal.toText(latest_minter);
        let response = {
            body = Text.encodeUtf8(number_of_nft_minted_msg # " / " # principal_of_latest_minter_msg);
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            streaming_strategy = null;
        };
        return(response);
    };

    // Challenge 7
    system func preupgrade() {
        entries := Iter.toArray(registry.entries());
    };
    system func postupgrade() {
        entries := [];
    };

    // Challenge 8
    /* Code to call from other canisters */
    // actor {
    //     let other_canister : actor { mint : () -> async Result<(), Error>} = actor("CANISTER_ID");
    //     public func mint_test() : async Result<(), Error> {
    //         return(await other_canister.mint());
    //     };
    // };
};