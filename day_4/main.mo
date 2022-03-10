import List "mo:base/List";
import Zombie "custom";
import Animal "animal";

actor {
    // Challenge 1
    public func fun() : async Zombie.Zombie {
        var zombie : Zombie.Zombie = {
            dna = 0;
            name = "nobody";
        };
        return zombie;
    };

    // Challenge 2
    public type Animal = Animal.Animal;

    var sloth : Animal = {
        specie = "mammals";
        energy = 0;
    };

    // Challenge 4
    public func create_animal_then_takes_a_break(specie : Text, energy : Nat) : async Animal {
        var animal : Animal = {
            specie = specie;
            energy = energy;
        };
        return Animal.animal_sleep(animal);
    };

    // Challenge 5
    public type List<Animal> = ?(Animal, List<Animal>);

    var animals : List<Animal> = List.nil<Animal>();

    // Challenge 6
    func push_animal(_animal : Animal) : async () {
        animals := List.push(_animal, animals);
    };
    func get_animals() : async [Animal] {
        return List.toArray(animals);
    };
};