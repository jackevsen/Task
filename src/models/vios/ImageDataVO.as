/**
 * Created by jackevsen on 03.06.15.
 */
package models.vios {
public class ImageDataVO {
    private var _name:String;
    private var _url:String;
    private var _width:Number;
    private var _height:Number;
    private var _x:Number;
    private var _y:Number;

    public function ImageDataVO() {
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function get url():String {
        return _url;
    }

    public function set url(value:String):void {
        _url = value;
    }

    public function get width():Number {
        return _width;
    }

    public function set width(value:Number):void {
        _width = value;
    }

    public function get height():Number {
        return _height;
    }

    public function set height(value:Number):void {
        _height = value;
    }

    public function get x():Number {
        return _x;
    }

    public function set x(value:Number):void {
        _x = value;
    }

    public function get y():Number {
        return _y;
    }

    public function set y(value:Number):void {
        _y = value;
    }

    public function clone():ImageDataVO{
        var newData:ImageDataVO = new ImageDataVO();
        newData.name = this.name;
        newData.url = this.url;
        newData.width = this.width;
        newData.height = this.height;
        newData.x = this.x;
        newData.y = this.y;

        return newData;
    }
}
}
