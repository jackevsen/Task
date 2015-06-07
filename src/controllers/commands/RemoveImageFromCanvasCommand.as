/**
 * Created by jackevsen on 06.06.15.
 */
package controllers.commands {
import controllers.events.CanvasEvent;

import models.canvas.CanvasModel;

import models.vios.ImageDataVO;

import org.robotlegs.mvcs.Command;

import view.holder.ImageHolder;

public class RemoveImageFromCanvasCommand extends Command {
    [Inject]
    public var event:CanvasEvent;

    [Inject]
    public var canvasModel:CanvasModel;

    override public function execute():void{
        var image:ImageHolder = event.image;
        if(image){
            var imageData:ImageDataVO = image.imageData;

            canvasModel.RemoveItem(imageData);

            image.Hide();
        }
    }
}
}
