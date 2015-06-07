/**
 * Created by jackevsen on 03.06.15.
 */
package view.canvas {
import controllers.events.CanvasEvent;

import org.robotlegs.mvcs.Mediator;

public class ImagesCanvasMediator extends Mediator {
    [Inject]
    public var view:ImagesCanvas;

    public function ImagesCanvasMediator() {
        super();
    }

    override public function onRegister():void{
        super.onRegister();

        eventDispatcher.addEventListener(CanvasEvent.ADD_TO_CANVAS, onAddToCanvas);
    }

    override public function onRemove():void{
        eventDispatcher.removeEventListener(CanvasEvent.ADD_TO_CANVAS, onAddToCanvas);

        super.onRemove();
    }

    private function onAddToCanvas(e:CanvasEvent):void{
        if(e.image){
            view.addChild(e.image);
            e.image.Show();
        }
    }
}
}
