/**
 * Created by jackevsen on 03.06.15.
 */
package models {
import controllers.events.ImagesEvent;

import models.vios.ImageDataVO;

import org.robotlegs.mvcs.Actor;

public class ImagesDataModel extends Actor {
    private var _imagesDataVector:Vector.<ImageDataVO>;

    public function ImagesDataModel() {
        super();

        _imagesDataVector = new Vector.<ImageDataVO>();
    }

    public function ParseData(xmlData:XML):void{
        var length:int = xmlData.image.length();
        for(var i:int = 0; i < length; i++){
           var imageXML:XML = xmlData.image[i];

            var imageData:ImageDataVO = new ImageDataVO();
            imageData.url = imageXML.@url;
            imageData.width = imageXML.@width;
            imageData.height = imageXML.@height;

            _imagesDataVector.push(imageData);
        }

        if(eventDispatcher){
            dispatch(new ImagesEvent(ImagesEvent.COMPOUND_IMAGES));
        }
    }

    public function get imagesData():Vector.<ImageDataVO>{
        return _imagesDataVector;
    }

    public function ContainsImageData(item:ImageDataVO):Boolean{
        if(_imagesDataVector == null){
            return false;
        }

        return _imagesDataVector.indexOf(item) >= 0;
    }
}
}
