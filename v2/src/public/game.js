var game = new Phaser.Game(
  1250, 714, Phaser.AUTO, '',
  { preload: preload, create: create, update: update }
)

var settings = {
  gravity: 1000,
  bounce: 0.0,
  jump: 800,
  move: 350
}

var platforms
var braveGirl
var cursors
var facing = 'idle'

function preload() {
  game.load.image('sky', 'assets/graveyard/bg.png')
  game.load.image('ground', 'assets/graveyard/tiles/Tile (1).png')
  game.load.spritesheet('brave-girl', 'assets/adventure_girl/run3.png', 64, 54)
}

function create() {
  cursors = game.input.keyboard.createCursorKeys();

  //  We're going to be using physics, so enable the Arcade Physics system
  game.physics.startSystem(Phaser.Physics.ARCADE);

  //  A simple background for our game
  game.add.sprite(0, 0, 'sky');

  //  The platforms group contains the ground and the 2 ledges we can jump on
  platforms = game.add.group();

  //  We will enable physics for any object that is created in this group
  platforms.enableBody = true;

  // Here we create the ground.
  var ground = platforms.create(0, game.world.height - 64, 'ground');

  //  Scale it to fit the width of the game (the original sprite is 400x32 in size)
  //ground.scale.setTo(1, 1);

  //  This stops it from falling away when you jump on it
  ground.body.immovable = true;

  //  Now let's create two ledges
  var ledge = platforms.create(400, 400, 'ground');

  ledge.body.immovable = true;

  ledge = platforms.create(-150, 250, 'ground');

  ledge.body.immovable = true;

  braveGirl = game.add.sprite(0, 0, 'brave-girl');

  //  We need to enable physics on the player
  game.physics.arcade.enable(braveGirl);

  //  Player physics properties. Give the little guy a slight bounce.
  braveGirl.body.bounce.y = settings.bounce
  braveGirl.body.gravity.y = settings.gravity
  braveGirl.body.collideWorldBounds = true

  //  Our two animations, walking left and right.
  braveGirl.animations.add('right', [0, 1, 2, 3, 4, 5, 6, 7], 40, true);
  braveGirl.animations.add('left', [8, 9, 10, 11, 12, 13, 14, 15], 40, true);
}

function update() {
  //  Collide the player and the stars with the platforms
  var hitPlatform = game.physics.arcade.collide(braveGirl, platforms);

  //  Reset the players velocity (movement)
  braveGirl.body.velocity.x = 0;

  if (cursors.left.isDown) {
    //  Move to the left
    braveGirl.body.velocity.x = (-1 * settings.move)
    braveGirl.animations.play('left');
    facing = 'left'
  } else if (cursors.right.isDown) {
    //  Move to the right
    braveGirl.body.velocity.x = settings.move
    braveGirl.animations.play('right');
    facing = 'right'
  } else {
    //  Stand still
    if (facing != 'idle') {
      braveGirl.animations.stop();
      if (facing == 'left') {
        braveGirl.frame = 8
      } else {
        braveGirl.frame = 0
      }
      facing = 'idle'
    }
  }

  //  Allow the player to jump if they are touching the ground.
  if (cursors.up.isDown && braveGirl.body.touching.down && hitPlatform) {
    braveGirl.body.velocity.y = (settings.jump * -1)
  }
}
