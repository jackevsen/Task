/**
 * Created by jackevsen on 04.06.15.
 */
package controllers.commands {
import controllers.events.CanvasEvent;
import controllers.events.ImagesEvent;

import flash.geom.Rectangle;

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
    private var _imagesMaxrix:Vector.<Vector.<ImageDataVO>>;
    private var _currentAddImageIndex:int;

    override public function execute():void{
        _needCreateViewVector = new Vector.<ImageDataVO>();
        _imagesMaxrix = new Vector.<Vector.<ImageDataVO>>();
        _currentAddImageIndex = 0;

        Compound();

        CreateViews();
    }

    private function Compound():void{
        var currentY:Number = 0;

        var canvasImagesVector:Vector.<ImageDataVO> = canvasModel.items.slice();
        var continueCompound:Boolean = true;
        while(continueCompound){
            var rowVector:Vector.<ImageDataVO> = new Vector.<ImageDataVO>();

            CompoundRow(rowVector, canvasImagesVector, imageDataModel.imagesData, currentY, false);

            if(rowVector.length == 0){
                continueCompound = false;
            }else{
                var firstImage:ImageDataVO = rowVector[0];
                currentY = firstImage.y + firstImage.height;

                _imagesMaxrix.push(rowVector);
            }
        }

        if(canvasImagesVector.length){
            for each(var imageData:ImageDataVO in canvasImagesVector){
                imageData.deleted = true;
                canvasModel.RemoveItem(imageData);
            }
            dispatch(new ImagesEvent(ImagesEvent.DELETE_IMAGE));
        }


    }

    private function CompoundRow(rowDataVector:Vector.<ImageDataVO>, mainImagesDataVector:Vector.<ImageDataVO>, addImagesDataVector:Vector.<ImageDataVO>, startY:Number, repeat:Boolean = true):void{
        var freeSpaceInRowRectangle:Rectangle = new Rectangle(0, startY, canvasModel.maxCanvasWidth, canvasModel.maxCanvasHeight - startY);
        var imageData:ImageDataVO = FindImage(mainImagesDataVector, addImagesDataVector, freeSpaceInRowRectangle);

        while(imageData){
            if(rowDataVector.length == 0){
                freeSpaceInRowRectangle.setTo(0, startY, canvasModel.maxCanvasWidth - imageData.width, imageData.height);
            }else{
                imageData = FindImage(mainImagesDataVector, addImagesDataVector, freeSpaceInRowRectangle);
                if(imageData){
                    var newX:Number = freeSpaceInRowRectangle.x + imageData.width;
                    freeSpaceInRowRectangle.setTo(freeSpaceInRowRectangle.x, startY, canvasModel.maxCanvasWidth - (newX + imageData.width), freeSpaceInRowRectangle.height);
                }
            }

            if(imageDataModel.ContainsImageData(imageData)){
                imageData = imageData.clone();
                _needCreateViewVector.push(imageData);
                canvasModel.AddItem(imageData);
            }

            if(imageData){
                SetImagePosition(imageData, freeSpaceInRowRectangle.x, freeSpaceInRowRectangle.y);
                rowDataVector.push(imageData);

                freeSpaceInRowRectangle.x += imageData.width;
            }

            if(!repeat){
                RemoveFromVector(mainImagesDataVector, imageData);
            }

        }
    }

    private function FindImage(mainVector:Vector.<ImageDataVO>, addVector:Vector.<ImageDataVO>, rect:Rectangle):ImageDataVO{
        var imageData:ImageDataVO = GetImageBySize(mainVector, rect.width, rect.height);
        if(imageData == null){
            imageData = GetImageBySize(addVector, rect.width, rect.height, _currentAddImageIndex);
            if(imageData == null){
                imageData = GetImageBySize(addVector, rect.width, rect.height, 0);
            }else{
                _currentAddImageIndex ++;
                if(_currentAddImageIndex >= addVector.length){
                    _currentAddImageIndex = 0;
                }
            }
        }
        return imageData;
    }

    private function CreateViews():void{
        var length:int = _needCreateViewVector.length;
        var i:int;
        var imageData:ImageDataVO
        for(i = 0; i < length; i++){
            imageData = _needCreateViewVector[i];
            var imageHolder:ImageHolder = new ImageHolder(imageData);

            dispatch(new CanvasEvent(CanvasEvent.ADD_TO_CANVAS, imageHolder));
        }

        dispatch(new ImagesEvent(ImagesEvent.MOVE_IMAGE));
    }

    private function GetImageBySize(dataVector:Vector.<ImageDataVO>, maxWidth:Number, maxHeight:Number, startIndex:int = 0):ImageDataVO{
        if(dataVector == null){
            return null;
        }

        var length:int = dataVector.length;
        for(var i:int = startIndex; i < length; i++){
            var imageData:ImageDataVO = dataVector[i];
            if(imageData.width <= maxWidth && imageData.height <= maxHeight){
                return imageData;
            }
        }

        return null;
    }

    private function RemoveFromVector(vector:Vector.<ImageDataVO>, item:ImageDataVO):void{
        if(vector == null){
            return;
        }

        var index:int = vector.indexOf(item);
        if(index >= 0){
            vector.splice(index, 1);
        }
    }

    private function SetImagePosition(imageData:ImageDataVO, imageX:Number, imageY:Number):void{
        imageData.x = imageX;

        if(_imagesMaxrix.length){
            var topRow:Vector.<ImageDataVO> = _imagesMaxrix[_imagesMaxrix.length - 1];
            var rect:Rectangle = GetImagesRectByRange(imageData, topRow);
            imageData.y = rect.bottom;
        }else{
            imageData.y = imageY;
        }
    }

    private function GetImagesRectByRange(imageData:ImageDataVO, imagesRow:Vector.<ImageDataVO>):Rectangle{
        var imageRect:Rectangle = new Rectangle(imageData.x, 0, imageData.width, imageData.height);
        var resultRect:Rectangle = new Rectangle();
        var testRect:Rectangle = new Rectangle();

        var length:int = imagesRow.length;
        for(var i:int = 0; i < length; i++){
            var testImage:ImageDataVO = imagesRow[i];
            testRect.setTo(testImage.x, 0, testImage.width, testImage.height);
            if(imageRect.intersects(testRect)){
                testRect.y = testImage.y;
                resultRect = resultRect.union(testRect);
            }
        }

        return resultRect;
    }
}
}
