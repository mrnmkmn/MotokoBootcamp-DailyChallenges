module {
    // Challenge 2
    public type Animal = {
        specie : Text;
        energy : Nat;
    };
    
    // Challenge 3
    public func animal_sleep(animal : Animal) : Animal {
        var a : Animal = {
            specie = animal.specie;
            energy = animal.energy + 10;
        };
        return a;
    };
};