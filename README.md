# Primary Flight Display Rework

A port/remake of our SAI final project in the Lua-based LÖVE framework. For more information on the original project, visit the [original repo page](https://github.com/ekspek/sai-2018/tree/master/project).

### Usage

To run the program on Linux, make sure you have LÖVE 11.0 or higher installed. Download the repo, navigate to the root folder and run
```
love ./
```
Instead of relying on input from external programs, like the original program, this version currently relies on keyboard inputs for testing. The mappings are found below.

| Variable  | Increase Key | Decrease key |
| --------- | ------------ | ------------ |
| Pitch | Up key | Down key |
| Roll | Right key | Left key |
| Airspeed | `Z` | `X` |
| Altitude | `A` | `S` |
| Heading | `W` | `Q` |
| Vertical speed | `1` | `2` |

Networking capabilites similar to the original project are planned but not yet implemented.

#### Font

The font used was the [B612 font family](https://b612-font.com/), available [on GitHub](https://github.com/polarsys/b612). Copyright goes to the font creators.

### Credits

Credit of this port goes to the repo owner, credit of the original project goes to [Daniel de Schiffart](https://github.com/ekspek), [João Manito](https://github.com/jonythunder) and [Pedro Afonso](https://github.com/stalone89).
