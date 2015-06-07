/**
 * Created by jackevsen on 04.06.15.
 */
package models.canvas {
import models.vios.ImageDataVO;

import org.robotlegs.mvcs.Actor;

public class CanvasModel extends Actor {
    private var _maxCanvasWidth:Number;
    private var _maxCanvasHeight:Number;

    private var _imagesDataVector:Vector.<ImageDataVO>;

    public function CanvasModel() {
        super();

        _imagesDataVector = new Vector.<ImageDataVO>();
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
        return _imagesDataVector;
    }

    public function AddItem(item:ImageDataVO):void{
        var index:int = _imagesDataVector.indexOf(item);
        if(index < 0){
            _imagesDataVector.push(item);
        }
    }

    public function RemoveItem(item:ImageDataVO):void{
        var index:int = _imagesDataVector.indexOf(item);
        if(index >= 0){
            _imagesDataVector.splice(index, 1);
        }
    }
}
}
