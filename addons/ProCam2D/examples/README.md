# ProCam2D Examples

This directory contains example projects demonstrating various uses of ProCam2D.

## Available Examples

### [Platformer](platformer/)

An atmospheric 2D platformer with parallax backgrounds:
- Character controller with smooth acceleration and jumping
- ProCam2D following the player with smooth camera movement
- Large explorable level with atmospheric design
- Parallax background layers for depth

**Perfect for**: Learning the basics of ProCam2D integration and camera following

### [Mouse Follow](mouse_follow/)

A top-down aiming demo showcasing dynamic camera movement:
- Player that rotates to face the mouse cursor
- ProCam2D with PCamMouseFollow addon configured
- Camera shifts toward cursor for better visibility
- Training arena with targets and obstacles

**Perfect for**: Understanding mouse follow addon for aiming games, twin-stick shooters, and top-down games

## Running the Examples

1. Make sure the ProCam2D plugin is enabled in your project settings
2. Open any example scene in the Godot editor
3. Run the scene (F6) or set it as the main scene

## Creating Your Own Examples

If you've created an example using ProCam2D and would like to contribute it:

1. Create a new folder in the `examples/` directory
2. Include all necessary files (scenes, scripts, assets)
3. Add a README.md explaining the example
4. Submit a pull request

See [CONTRIBUTING.md](../CONTRIBUTING.md) for more details.

## Example Ideas

Here are some ideas for additional examples that could be added:

- **Multi-target following**: Demonstrate camera following multiple characters
- **Cinematic platformer**: Showcase PCamCinematic for cutscenes and camera sequences
- **Metroidvania-style**: Demonstrate PCamRoom for room-based cameras
- **Boss fight**: Use PCamZoom and PCamMagnet for dynamic camera behavior
- **Racing game**: Show path constraints with PCamPath
- **Screen shake showcase**: Demonstrate all shake types and presets

Contributions welcome!
