package entities;

import haxepunk.*;
import haxepunk.graphics.*;
import haxepunk.input.*;
import haxepunk.masks.*;
import haxepunk.math.*;
import haxepunk.Tween;
import haxepunk.tweens.misc.*;
import scenes.*;

class Cursor extends Entity
{
    private var sprite:Spritemap;

    public function new(x:Float, y:Float) {
        super(x, y);
        layer = -20;
        sprite = new Spritemap("graphics/player.png", 12, 12);
        sprite.add("idle", [0]);
        sprite.play("idle");
        graphic = sprite;
    }

    override public function update() {
        if(Input.check("left")) {
            heading.x = -1;
        }
        else if(Input.check("right")) {
            heading.x = 1;
        }
        else {
            heading.x = 0;
        }
        if(Input.check("up")) {
            heading.y = -1;
        }
        else if(Input.check("down")) {
            heading.y = 1;
        }
        else {
            heading.y = 0;
        }
        velocity = heading;
        velocity.normalize(SPEED);
        moveBy(velocity.x * HXP.elapsed, velocity.y * HXP.elapsed, ["walls"]);
        super.update();
    }
}
