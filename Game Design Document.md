# Master Game Design Document: Project Tactical Breaker
## Theme: Micro-Universe (The Tactical Slingshot)

---

### 1. Executive Summary
A turn-based, strategic "Brick Breaker" set in a blown-out-of-proportion "Micro-Universe." The game replaces traditional reflex-based gameplay with a "Think-Aim-Action" loop, emphasizing a coin-based economy and deck-building mechanics.

---

### 2. The Hook: Strategic Economy
* **Economy:** Players earn coins by destroying blocks and achieving high-skill combos.
* **Deck-Building Lite:** Players manage a 2-slot hand of power-up cards purchased from a shop.
* **Power-up Taxonomy:**
    * **Tool Buffs:** Long Aim, Multi-ball.
    * **Ball Types:** Fire (piercing), Explosive, Acid (damage over time).
    * **Board Spells:** Earthquake (AOE damage), Tsunami (push blocks back).

---

### 3. Gameplay Loop & States
The game follows a strict state machine to ensure tactical clarity:
1.  **Preparation (Shop):** Player curates their 2-card hand.
2.  **Tactical (Aim):** Drag-to-aim (Slingshot). Cards must be activated in this phase.
3.  **Kinetic (Action):** RigidBody physics take over. Input is locked. Balls bounce until they return to the paddle or are recalled.
4.  **Resolution:** Blocks move down one row. Health check is performed. Status effects tick.

---

### 4. Progression & Stakes
* **Win Condition:** Survive a 30-row "sprint" and defeat a 5-row Boss (e.g., giant Alarm Clock).
* **Loss Condition:** Player health (Hearts) reaches zero. 
* **Damage Trigger:** Blocks reaching the "Dead Zone" (bottom of the game area) reduce player health.
* **Block Hierarchy:**
    * **Weak (1-2 hits):** Sugar cubes, paper scraps.
    * **Robust (4-6 hits):** Lego blocks, erasers.
    * **Strong (10+ hits):** Metal nuts, AA batteries.

---

### 5. Physics & Technical Spec
* **Engine:** Godot 4.x (GDScript).
* **Physics Mode:** **RigidBody2D**. This allows for tactile collisions, mass manipulation, and "emergent chaos."
* **Aiming:** Utilizes a "Ghost World" prediction system for an honest trajectory line.
* **Architecture:** Signal-based interaction between the `GameManager` (Global), `ProjectileContainer`, and `BlockContainer`.

---

### 6. UI Layout & Screen Real Estate
The screen is divided into three functional zones (20/70/10 split):

| Zone | Size | Content |
| :--- | :--- | :--- |
| **Header** | 20% | Score, Coins, Health (Hearts), Settings Gear. |
| **Arena** | 70% | The Physics world, blocks, walls, and the Dead Zone line. |
| **Footer** | 10% | 2-card hand slots, Shop toggle, and Recall button. |

---

### 7. Senior Designer Notes
* **Balance:** The game must be winnable with the base ball; cards are strategic "force multipliers."
* **Feel:** Use screen shake and particle effects on impacts to emphasize the "Micro-Universe" scale.
* **Logic:** Use Godot `Resources` for Card/Power-up data to ensure the system is easily expandable.
Tactical_Breaker_Master_GDD.md
Displaying Tactical_Breaker_Master_GDD.md.