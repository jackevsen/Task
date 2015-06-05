/**
 * Created by jackevsen on 03.06.15.
 */
package controllers.services {

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.osflash.signals.Signal;

import org.robotlegs.mvcs.Actor;

public class DataLoadingService extends Actor implements ILoadingService{
    private var _loader:URLLoader;

    private var _processSignal:Signal;

    public function DataLoadingService() {
        super();

        _processSignal = new Signal();

        _loader = new URLLoader();
        _loader.addEventListener(Event.COMPLETE, onDataLoaded);
        _loader.addEventListener(IOErrorEvent.IO_ERROR, onDataLoadingError);
    }

    private function onDataLoaded(e:Event):void {
        //eventDispatcher.dispatchEvent(new DataLoadingEvent(DataLoadingEvent.ON_DATA_LOADED, e.target.data));
        _processSignal.dispatch(e.target.data);
    }

    private function onDataLoadingError(e:IOErrorEvent):void {
        //eventDispatcher.dispatchEvent(new DataLoadingEvent(DataLoadingEvent.ON_DATA_LOADING_ERROR, e.text));
        _processSignal.dispatch(null);
    }

    public function Load(url:String):void {
        _loader.load(new URLRequest(url));
    }

    public function get processSignal():Signal {
        return _processSignal;
    }
}
}
