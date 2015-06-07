/**
 * Created by jackevsen on 04.06.15.
 */
package view.holder {
import controllers.events.CanvasEvent;
import controllers.events.ImagesEvent;
import controllers.events.ImagesEvent;
import controllers.services.ILoadingService;

import flash.display.Bitmap;
import flash.events.MouseEvent;

import org.robotlegs.mvcs.Mediator;

public class ImageHolderMediator extends Mediator {
    [Inject]
    public var view:ImageHolder;

    [Inject]
    public var loadingService:ILoadingService;

    public function ImageHolderMediator() {
        super();
    }

    override public function onRegister():void{
        super.onRegister();

        eventDispatcher.addEventListener(ImagesEvent.MOVE_IMAGE, onMoveImage);
        eventDispatcher.addEventListener(ImagesEvent.DELETE_IMAGE, onMoveDeleteImage);

        view.imageClickSignal.addOnce(onViewClicked);

        loadingService.processSignal.addOnce(onImageEventDispatched);
        loadingService.Load(MainConstants.SERVER_URL + view.imageData.url);
    }

    override public function onRemove():void{
        eventDispatcher.removeEventListener(ImagesEvent.MOVE_IMAGE, onMoveImage);
        eventDispatcher.removeEventListener(ImagesEvent.DELETE_IMAGE, onMoveDeleteImage);

        dispatch(new ImagesEvent(ImagesEvent.COMPOUND_IMAGES));

        super.onRemove();
    }

    private function onImageEventDispatched(image:Bitmap):void{
        if(image){
            view.AddBitmap(image);
        }else{
            view.ShowLoadingError();
        }
    }

    private function onViewClicked(e:MouseEvent):void{
        dispatch(new CanvasEvent(CanvasEvent.REMOVE_FROM_CANVAS, view));
    }

    private function onMoveImage(e:ImagesEvent):void{
        view.Move();
    }

    private function onMoveDeleteImage(e:ImagesEvent):void{
        if(view.imageData.deleted){
            view.removeFromParent(true);
        }
    }
}
}
