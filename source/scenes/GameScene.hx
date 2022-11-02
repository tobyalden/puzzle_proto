package scenes;

import entities.*;
import haxepunk.*;
import haxepunk.graphics.*;
import haxepunk.graphics.tile.*;
import haxepunk.input.*;
import haxepunk.masks.*;
import haxepunk.math.*;
import haxepunk.Tween;
import haxepunk.tweens.misc.*;
import haxepunk.utils.*;
import openfl.Assets;

@:structInit class TileCoordinates {
    public var tileX:Int;
    public var tileY:Int;
}

class GameScene extends Scene
{
    public static inline var GRID_WIDTH = 6;
    public static inline var GRID_HEIGHT = 12;
    public static inline var TILE_SIZE = 10;

    private var grid:Tilemap;
    private var cursor:Image;
    private var cursorCoordinates:TileCoordinates;

    override public function begin() {
        cursor = new Image("graphics/cursor.png");
        addGraphic(cursor, -20);
        cursorCoordinates = { tileX: 2, tileY: 5 };

        grid = new Tilemap(
            "graphics/grid.png",
            (GRID_WIDTH + 1) * TILE_SIZE,
            (GRID_HEIGHT + 1) * TILE_SIZE,
            TILE_SIZE,
            TILE_SIZE
        );
        for(tileX in 0...grid.columns) {
            for(tileY in 0...grid.rows) {
                if(tileX == GRID_WIDTH && tileY == GRID_HEIGHT) {
                    grid.setTile(tileX, tileY, 3);
                }
                else if(tileX == GRID_WIDTH) {
                    grid.setTile(tileX, tileY, 2);
                }
                else if(tileY == GRID_HEIGHT) {
                    grid.setTile(tileX, tileY, 1);
                }
                else {
                    grid.setTile(tileX, tileY, 0);
                }
            }
        }
        grid.x = 20;
        grid.y = 20;
        addGraphic(grid, -10);

        var playfieldData = [for (i in 0...GRID_WIDTH * GRID_HEIGHT) HXP.choose(0, 1, 2, 3, 4)];
        var playfield = new Tilemap(
            "graphics/tiles.png",
            GRID_WIDTH * TILE_SIZE,
            GRID_HEIGHT * TILE_SIZE,
            TILE_SIZE,
            TILE_SIZE
        );
        for(tileX in 0...GRID_WIDTH) {
            for(tileY in 0...GRID_HEIGHT) {
                playfield.setTile(tileX, tileY, playfieldData[tileX + tileY * GRID_WIDTH]);
            }
        }
        playfield.x = grid.x;
        playfield.y = grid.y;
        addGraphic(playfield);
    }

    override public function update() {
        if(Input.pressed("left")) {
            cursorCoordinates.tileX -= 1;
        }
        if(Input.pressed("right")) {
            cursorCoordinates.tileX += 1;
        }
        if(Input.pressed("up")) {
            cursorCoordinates.tileY -= 1;
        }
        if(Input.pressed("down")) {
            cursorCoordinates.tileY += 1;
        }
        cursorCoordinates.tileX = MathUtil.iclamp(cursorCoordinates.tileX, 0, GRID_WIDTH - 1);
        cursorCoordinates.tileY = MathUtil.iclamp(cursorCoordinates.tileY, 0, GRID_HEIGHT - 1);
        cursor.x = grid.x + cursorCoordinates.tileX * TILE_SIZE - 1;
        cursor.y = grid.y + cursorCoordinates.tileY * TILE_SIZE - 1;
        super.update();
    }
}
