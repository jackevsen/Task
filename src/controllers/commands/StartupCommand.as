/**
 * Created by jackevsen on 03.06.15.
 */
package controllers.commands {
import controllers.services.DataLoadingService;

import models.ImagesDataModel;

import org.robotlegs.mvcs.Command;

public class StartupCommand extends Command {
    [Inject]
    public var dataLoadingService:DataLoadingService;

    [Inject]
    public var imagesDataModel:ImagesDataModel;

    override public function execute():void{
        dataLoadingService.processSignal.addOnce(onDataDataEventDispatched);
        dataLoadingService.Load(MainConstants.DATA_URL);
    }

    private function onDataDataEventDispatched(data:String):void{
        if(data){
            imagesDataModel.ParseData(XML(data));
        }else{

        }
    }
}
}
