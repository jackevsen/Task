/**
 * Created by jackevsen on 04.06.15.
 */
package controllers.commands {
import controllers.events.CanvasEvent;

import models.ImagesDataModel;
import models.canvas.CanvasModel;
import models.vios.ImageDataVO;

import org.robotlegs.mvcs.Command;

import view.holder.ImageHolder;

public class CompoundImagesCommand extends Command {
    [Inject]
    public var imageDataModel:ImagesDataModel;

    [Inject]
    public var canvasModel:CanvasModel;

    private var _needCreateViewVector:Vector.<ImageDataVO>;

    override public function execute():void{
        _needCreateViewVector = new Vector.<ImageDataVO>();

        Compound();
        CreateViews();
    }

    private function Compound():void{
        var curX:Number = 0;
        var curY:Number = 0;

        var length:int = canvasModel.items.length;
        var i:int;
        var imageData:ImageDataVO;
        var canvasIsFull:Boolean = false;
        for(i = 0; i < length; i++){
            imageData = canvasModel.items[i];

            if(curX + imageData.width > canvasModel.maxCanvasWidth){
                curY += 100;
                curX = 0;
            }else if(curY + imageData.height > canvasModel.maxCanvasHeight){
                canvasIsFull = true;
                break;
            }

            imageData.x = curX;
            imageData.y = curY;

            curX += 100;
        }

        if(!canvasIsFull){
            length = imageDataModel.imagesData.length;
            for(i = 0; i < length; i++){
                var imageData:ImageDataVO = imageDataModel.imagesData[i];

                if(curX + imageData.width > canvasModel.maxCanvasWidth){
                    curY += 100;
                    curX = 0;
                }else if(curY + imageData.height > canvasModel.maxCanvasHeight){
                    canvasIsFull = true;
                    break;
                }

                var newImageData = imageData.clone();
                canvasModel.items.push(newImageData);
                _needCreateViewVector.push(newImageData);

                newImageData.x = curX;
                newImageData.y = curY;

                curX += 100;
            }
        }

    }

    private function CreateViews():void{
        var length:int = _needCreateViewVector.length;
        for(var i:int = 0; i < length; i++){
            var imageData:ImageDataVO = _needCreateViewVector[i];
            var imageHolder:ImageHolder = new ImageHolder(imageData);

            dispatch(new CanvasEvent(CanvasEvent.ADD_TO_CANVAS, imageHolder));
        }
    }
}
}
