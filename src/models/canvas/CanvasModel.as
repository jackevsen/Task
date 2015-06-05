/**
 * Created by jackevsen on 04.06.15.
 */
package models.canvas {
import models.vios.ImageDataVO;

import org.robotlegs.mvcs.Actor;

public class CanvasModel extends Actor {
    private var _maxCanvasWidth:Number;
    private var _maxCanvasHeight:Number;

    private var _imagesModelsVector:Vector.<ImageDataVO>;

    public function CanvasModel() {
        super();

        _imagesModelsVector = new Vector.<ImageDataVO>();
    }

    public function get maxCanvasWidth():Number {
        return _maxCanvasWidth;
    }

    public function set maxCanvasWidth(value:Number):void {
        _maxCanvasWidth = value;
    }

    public function get maxCanvasHeight():Number {
        return _maxCanvasHeight;
    }

    public function set maxCanvasHeight(value:Number):void {
        _maxCanvasHeight = value;
    }

    public function get items():Vector.<ImageDataVO> {
        return _imagesModelsVector;
    }
}
}
