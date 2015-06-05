/**
 * Created by jackevsen on 05.06.15.
 */
package controllers.services {

import flash.display.Bitmap;

import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

import org.osflash.signals.Signal;

import org.robotlegs.mvcs.Actor;

public class ImageLoadingService extends Actor implements ILoadingService{
    private var _loader:Loader;
    private var _processSignal:Signal;

    public function ImageLoadingService() {
        super();

        _processSignal = new Signal();

        _loader = new Loader();
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadingComplete);
        _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadingError);
    }

    public function Load(url:String):void{
        _loader.load(new URLRequest(url));
    }

    private function onLoadingComplete(e:Event):void{
        _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadingComplete);
        _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadingError);

        _processSignal.dispatch(Bitmap(_loader.contentLoaderInfo.content));
    }

    private function onLoadingError(e:IOErrorEvent):void{
        _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadingComplete);
        _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadingError);

        _processSignal.dispatch(null);
    }

    public function get processSignal():Signal {
        return _processSignal;
    }
}
}
