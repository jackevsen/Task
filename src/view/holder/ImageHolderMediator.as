/**
 * Created by jackevsen on 04.06.15.
 */
package view.holder {
import controllers.services.ILoadingService;

import flash.display.Bitmap;

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

        loadingService.processSignal.addOnce(onImageEventDispatched);
        loadingService.Load(MainConstants.SERVER_URL + view.imageData.url);
    }

    private function onImageEventDispatched(image:Bitmap):void{
        if(image){
            view.AddBitmap(image);
        }else{
            view.ShowLoadingError();
        }
    }
}
}
