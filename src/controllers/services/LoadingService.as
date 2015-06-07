/**
 * Created by jackevsen on 07.06.15.
 */
package controllers.services {
import controllers.loaders.ILoader;

import flash.events.Event;
import flash.events.IOErrorEvent;

import org.osflash.signals.Signal;
import org.robotlegs.mvcs.Actor;

public class LoadingService extends Actor implements ILoadingService {
    private var _processSignal:Signal;
    private var _loader:ILoader;

    public function LoadingService() {
        super();

        _processSignal = new Signal();
    }

    public function Load(url:String):void {
        _loader = GetLoaderFactory();
        if(_loader){
            _loader.completeSignal.addOnce(onDataLoaded);
            _loader.errorSignal.addOnce(onDataLoadingError);
            _loader.Load(url);
        }
    }

    public function get processSignal():Signal {
        return _processSignal;
    }

    public function dispose():void{
        if(_loader){
            _loader.dispose();
            _loader = null;
        }

        if(_processSignal){
            _processSignal.removeAll();
            _processSignal = null;
        }
    }

    protected function GetLoaderFactory():ILoader{
        return null;
    }

    private function onDataLoaded(e:Event):void {
        _processSignal.dispatch(_loader.content);

        dispose();
    }

    private function onDataLoadingError(e:IOErrorEvent):void {
        _processSignal.dispatch(null);

        dispose();
    }
}
}
