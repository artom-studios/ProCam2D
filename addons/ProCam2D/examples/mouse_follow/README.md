# Mouse Follow Example

A complete top-down shooter showcasing **ProCam2D's PCamMouseFollow addon**, with shooting mechanics, enemies, and particle effects.

## Features

- **Dynamic Mouse Follow**: Camera shifts toward your cursor for better visibility in aim direction
- **Top-Down Combat**: Shoot enemies that chase and attack you
- **Custom Crosshair Cursor**: Your mouse pointer becomes a crosshair for precise aiming
- **Particle Effects**: Muzzle flashes, hit sparks, and death explosions
- **Enemy AI**: Purple enemies chase the player and attack on contact
- **Dynamic Enemy Spawning**: New enemies spawn randomly around the player every 3 seconds
- **Score System**: Earn 100 points per enemy defeated
- **High Score Tracking**: Your best score is saved and displayed
- **Health System**: Player and enemies have health with visual damage feedback

## What's Included

- **Player.gd**: Top-down character controller with shooting, health, and damage (Godot 4.5)
- **Player.tscn**: Player scene with turret, muzzle flash particles, and PCamTarget
- **Enemy.gd**: AI-controlled enemy with chase behavior and health
- **Enemy.tscn**: Enemy scene with hexagon body and particle effects
- **Bullet.gd/tscn**: Projectile with collision detection
- **GameManager.gd**: Handles score tracking, high score saving, and enemy spawning
- **MouseFollow.tscn**: Complete arena with initial enemies, obstacles, and ProCam2D configured

## How to Run

1. Make sure ProCam2D plugin is enabled in your Godot 4.5 project
2. Open `MouseFollow.tscn` in the Godot editor
3. Run the scene (F6) or set it as the main scene and run the project (F5)
4. Your mouse cursor will automatically become a crosshair

## Controls

- **WASD / Arrow Keys**: Move in all directions
- **Mouse**: Aim (player rotates to face cursor, camera shifts toward aim direction)
- **Left Click**: Shoot bullets

## How Mouse Follow Works

The **PCamMouseFollow addon** is configured on the ProCam2D node with these settings:

### Key Parameters

- **max_distance** (300.0): Maximum distance from camera center where mouse influence applies
- **influence** (0.5, 0.5): How much the camera shifts toward the cursor (50% in both axes)
- **smoothing** (8.0): How quickly the camera interpolates to the target position
- **deadzone_radius** (10.0): Small area around center where no influence is applied

### How It Feels

When you move your mouse cursor away from the center of the screen:
- The camera smoothly shifts toward the cursor direction
- You get better visibility in the direction you're aiming
- The effect is subtle but makes a huge difference in gameplay feel
- Perfect for twin-stick shooters, top-down games, or any game with aiming mechanics

## Design Elements

### Color Palette
- **Background**: Dark blue-gray (#181a26) - reduces eye strain
- **Grid Lines**: Subtle blue guides (10% opacity)
- **Player**: Red/coral body (#ff4d66) with cyan turret (#3399cc) and white gun
- **Enemies**: Purple hexagons (#cc4de6) - threatening and distinct
- **Obstacles**: Vibrant orange (#ff8033) with darker outlines
- **Targets**: Teal/cyan pentagons (#33cc99) for reference
- **Bullets**: Yellow projectiles with trail effect
- **UI**: Bright cyan text (#66ccff)
- **Crosshair**: Semi-transparent white

### Why This Color Scheme?
- Dark background reduces visual fatigue during aiming
- Purple enemies immediately stand out as threats
- Warm obstacles (orange) vs cool targets (cyan) for instant recognition
- Player uses both warm (body) and cool (turret) colors to stand out
- Yellow bullets are highly visible against all backgrounds
- High contrast for clarity during fast-paced combat

## Gameplay Mechanics

### Combat System
- **Shooting**: Rapid fire with automatic cooldown (0.15s between shots)
- **Bullet System**: Projectiles with collision detection and 3-second lifetime
- **Muzzle Flash**: Yellow particle burst when firing for visual feedback
- **Hit Effects**: White spark particles when bullets connect with enemies

### Enemy Behavior
- **Chase AI**: Enemies detect and pursue the player within 600px range
- **Smart Movement**: Enemies stop at 150px distance to avoid stacking
- **Health**: Each enemy takes 3 hits to eliminate
- **Contact Damage**: Enemies deal 1 damage when touching the player
- **Death Effects**: Purple particle explosion when defeated

### Player Stats
- **Health**: 5 hit points
- **Damage Flash**: Red color flash when taking damage
- **Death**: Creates particle effect on elimination
- **Movement**: Smooth acceleration/deceleration for responsive control

### Enemy Spawning System
- **Spawn Timer**: New enemies appear every 3 seconds
- **Random Positioning**: Spawns 400-800px away from the player at a random angle
- **Arena Bounds**: Enemies spawn within the 2400x2400 arena
- **Max Enemies**: Limited to 15 simultaneous enemies to maintain performance
- **Initial Spawn**: 6 enemies placed at start, then dynamic spawning begins

### Score System
- **Points per Kill**: 100 points for each enemy defeated
- **Real-time Display**: Yellow score label shows current score
- **High Score Tracking**: Purple high score label shows your best performance
- **Persistent Saving**: High score saved to disk (user://mouse_follow_highscore.save)
- **Auto-update**: High score automatically updates when beaten

## Customizing the Mouse Follow

Select the ProCam2D node and expand the "Addons" array to adjust the PCamMouseFollow settings:

### Increasing Mouse Influence
```gdscript
# More aggressive camera shift toward cursor
influence = Vector2(0.8, 0.8)  # Default is (0.5, 0.5)
```

### Faster Camera Response
```gdscript
# Snappier camera movement
smoothing = 15.0  # Default is 8.0 (higher = faster)
```

### Wider Active Area
```gdscript
# Mouse affects camera from farther away
max_distance = 500.0  # Default is 300.0
```

### Larger Deadzone
```gdscript
# Bigger center area with no camera shift
deadzone_radius = 50.0  # Default is 10.0
```

## Adding Mouse Follow to Your Game

To add mouse follow to your own project:

1. Add a ProCam2D node to your scene
2. Add a PCamTarget as a child of your player
3. In the ProCam2D inspector, expand "Addons" array and increase size
4. Click the [empty] field and select "New PCamMouseFollow"
5. Configure the parameters to taste
6. Test and tweak until it feels right!

### Code Example

You can also add it via code:

```gdscript
var mouse_follow = PCamMouseFollow.new()
mouse_follow.max_distance = 300.0
mouse_follow.influence = Vector2(0.5, 0.5)
mouse_follow.smoothing = 8.0
mouse_follow.deadzone_radius = 10.0
procam.add_addon(mouse_follow)
```

## Tips for Best Results

1. **Start Subtle**: Begin with low influence (0.3-0.5) and increase if needed
2. **Match Your Game Speed**: Fast games need faster smoothing
3. **Consider UI**: Make sure UI elements don't interfere with mouse tracking
4. **Test on Different Screen Sizes**: Mouse follow feels different on various resolutions
5. **Combine with Other Features**: Works great with zoom and look-ahead drag types

## Use Cases

This mouse follow setup is perfect for:

- **Top-down shooters**: Better visibility in aim direction
- **Twin-stick games**: Enhanced spatial awareness
- **Strategy games**: Preview areas before moving
- **Adventure games**: Look around without moving character
- **Any game with cursor-based aiming or interaction**

## Learn More

Check out the main [ProCam2D README](../../../../README.md) for complete documentation on all features, addons, and camera behaviors.
