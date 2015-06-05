/**
 * Created by jackevsen on 04.06.15.
 */
package view.holder {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import models.vios.ImageDataVO;

public class ImageHolder extends Sprite {
    private var _imageBitmap:Bitmap;
    private var _imageData:ImageDataVO;

    public function ImageHolder(data:ImageDataVO) {
        super();

        _imageData = data;

        if(_imageData){
            this.x = _imageData.x;
            this.y = _imageData.y;
        }

        this.buttonMode = true;
    }

    public function AddBitmap(bitmap:Bitmap):void{
        if(_imageBitmap){
            dispose();
        }

        _imageBitmap = bitmap;
        addChild(_imageBitmap);
    }

    public function dispose():void{
        if(_imageBitmap){
            if(_imageBitmap.parent){
                removeChild(_imageBitmap);
            }

            if(_imageBitmap.bitmapData){
                _imageBitmap.bitmapData.dispose();
                _imageBitmap.bitmapData = null;
            }

            _imageBitmap = null;
        }

        _imageData = null;
    }

    public function removeFromParent(dispose:Boolean = false):void{
        if(this.parent){
            this.parent.removeChild(this);
        }

        if(dispose){
            this.dispose();
        }
    }

    public function get imageData():ImageDataVO {
        return _imageData;
    }

    public function set imageData(value:ImageDataVO):void {
        _imageData = value;
    }
    public function ShowLoadingError():void{
        var textField:TextField = new TextField();
        textField.text = "Loading error";
        textField.autoSize = TextFieldAutoSize.LEFT;
        textField.x = (imageData.width - textField.width) / 2;
        textField.y = (imageData.height - textField.height) / 2;
        addChild(textField);
    }
}
}
