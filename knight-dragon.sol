/**
 *Submitted for verification at basescan.org on 2025-01-10
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KnightVsDragon {
    // Structure pour le chevalier
    struct Knight {
        string name;
        uint health;
        uint attackPower;
    }

    // Structure pour le dragon
    struct Dragon {
        string name;
        uint health;
        uint attackPower;
    }

    // Instance du chevalier
    Knight public knight;

    // Instance du dragon
    Dragon public dragon;

    // Événements pour suivre les attaques
    event Attack(string attacker, string target, uint damage, uint targetRemainingHealth);

    // Initialisation des personnages
    constructor(string memory knightName, string memory dragonName) {
        knight = Knight(knightName, 100, 15); // Chevalier avec 100 points de vie et 15 points d'attaque
        dragon = Dragon(dragonName, 200, 25); // Dragon avec 200 points de vie et 25 points d'attaque
    }

    // Fonction pour que le chevalier attaque le dragon
    function knightAttack() public {
        require(dragon.health > 0, "Le dragon est deja vaincu.");
        require(knight.health > 0, "Le chevalier est mort et ne peut pas attaquer.");

        // Réduction des points de vie du dragon
        if (dragon.health <= knight.attackPower) {
            dragon.health = 0;
        } else {
            dragon.health -= knight.attackPower;
        }

        emit Attack(knight.name, dragon.name, knight.attackPower, dragon.health);
    }

    // Fonction pour que le dragon attaque le chevalier
    function dragonAttack() public {
        require(knight.health > 0, "Le chevalier est deja vaincu.");
        require(dragon.health > 0, "Le dragon est mort et ne peut pas attaquer.");

        // Réduction des points de vie du chevalier
        if (knight.health <= dragon.attackPower) {
            knight.health = 0;
        } else {
            knight.health -= dragon.attackPower;
        }

        emit Attack(dragon.name, knight.name, dragon.attackPower, knight.health);
    }

    // Fonction pour récupérer l'état du jeu
    function getGameState() public view returns (string memory) {
        if (knight.health == 0) {
            return "Le chevalier est vaincu. Le dragon a gagne!";
        } else if (dragon.health == 0) {
            return "Le dragon est vaincu. Le chevalier a gagne!";
        } else {
            return "Le combat continue!";
        }
    }
}
