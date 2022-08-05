// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PokeDIO is ERC721 {

    struct Pokemon {
        string name;
        uint level;
        string img;
    }

    Pokemon[] public pokemon;
    address public gameOwner;

    constructor() ERC721("PokeDIO", "PKD") {

        gameOwner = msg.sender;

    }

   modifier onlyOwnerOf(uint _monsterId) {

        require(ownerOf(_monsterId) == msg.sender,"Apenas o dono pode batalhar com este Pokemon");
        _;

    }

    function battle(uint _attackingPokemon, uint _defendingPokemon) public onlyOwnerOf(_attackingPokemon) {
        Pokemon storage attacker = pokemon[_attackingPokemon];
        Pokemon storage defender = pokemon[_defendingPokemon];

        if (attacker.level >= defender.level) {
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            attacker.level += 2;
        }

    }

    function createNewPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos pokemons!");
        uint id = pokemon.length;
        pokemon.push(Pokemon(_name, 1, _img));
        _safeMint(_to, id);
    }

}