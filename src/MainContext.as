/**
 * Created by jackevsen on 03.06.15.
 */
package {
import controllers.commands.CompoundImagesCommand;
import controllers.commands.StartupCommand;
import controllers.commands.UpdateCanvasSizeCommand;
import controllers.events.ImagesEvent;
import controllers.events.StartupEvent;
import controllers.services.DataLoadingService;
import controllers.services.ILoadingService;
import controllers.services.ImageLoadingService;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

import models.ImagesDataModel;
import models.canvas.CanvasModel;

import org.robotlegs.base.ContextEvent;

import org.robotlegs.mvcs.Context;

import view.canvas.ImagesCanvas;
import view.canvas.ImagesCanvasMediator;
import view.holder.ImageHolder;
import view.holder.ImageHolderMediator;

public class MainContext extends Context {

    public function MainContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
        super(contextView, autoStartup);
    }

    override public function startup():void{
        addEventListener(ContextEvent.STARTUP_COMPLETE, onStartupComplete);

        injector.mapSingleton(ImagesDataModel);
        injector.mapSingleton(CanvasModel);
        injector.mapSingleton(DataLoadingService);
        injector.mapClass(ILoadingService, ImageLoadingService);

        commandMap.mapEvent(StartupEvent.STARTUP, StartupCommand);
        commandMap.mapEvent(ImagesEvent.COMPOUND_IMAGES, CompoundImagesCommand);
        commandMap.mapEvent(Event.RESIZE, UpdateCanvasSizeCommand);

        mediatorMap.mapView(ImagesCanvas, ImagesCanvasMediator);
        mediatorMap.mapView(ImageHolder, ImageHolderMediator);

        super .startup();
    }

    private function onStartupComplete(e:ContextEvent):void{
        removeEventListener(ContextEvent.STARTUP_COMPLETE, onStartupComplete);

        contextView.stage.addEventListener(Event.RESIZE, onStageResized);

        contextView.addChild(new ImagesCanvas());

        dispatchEvent(new Event(Event.RESIZE));
        dispatchEvent(new ContextEvent(StartupEvent.STARTUP));
    }

    private function onStageResized(e:Event):void{
        dispatchEvent(e);
    }
}
}
