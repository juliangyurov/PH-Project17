## [Project 17: Space Race](https://www.hackingwithswift.com/read/17/overview)
Written by [Paul Hudson](https://www.hackingwithswift.com/about)  ![twitter16](https://github.com/juliangyurov/PH-Project6a/assets/13259596/445c8ea0-65c4-4dba-8e1f-3f2750f0ef51)
  [@twostraws](https://twitter.com/twostraws)

**Description:** Dodge space debris while you learn about per-pixel collision detection.

- Setting up

- Space: the final frontier

- Bring on the enemies: Timer, linearDamping, angularDamping

- Making contact: didBegin()

- Wrap up


## [Review what you learned](https://www.hackingwithswift.com/review/hws/project-17-space-race)

**Challenge**

1. Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing touchesEnded() to make it work.

2. Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call invalidate() on gameTimer before giving it a new value, otherwise you end up with multiple timers.

3. Stop creating space debris after the player has died.
