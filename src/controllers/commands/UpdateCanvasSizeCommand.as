/**
 * Created by jackevsen on 04.06.15.
 */
package controllers.commands {
import models.canvas.CanvasModel;

import org.robotlegs.mvcs.Command;

public class UpdateCanvasSizeCommand extends Command {
    [Inject]
    public var canvasModel:CanvasModel;

    override public function execute():void{
        if(contextView.stage){
            canvasModel.maxCanvasWidth = contextView.stage.stageWidth;
            canvasModel.maxCanvasHeight = contextView.stage.stageHeight;
        }
    }
}
}
