/**
 * Created by jackevsen on 07.06.15.
 */
package controllers.loaders {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.osflash.signals.natives.NativeSignal;

public class DataLoader implements ILoader {
    private var _loader:URLLoader;
    private var _completeSignal:NativeSignal;
    private var _errorSignal:NativeSignal;

    public function DataLoader() {
        _loader = new URLLoader();

        _completeSignal = new NativeSignal(_loader, Event.COMPLETE);
        _errorSignal = new NativeSignal(_loader, IOErrorEvent.IO_ERROR);
    }

    public function Load(url:String):void{
        _loader.load(new URLRequest(url));
    }

    public function get completeSignal():NativeSignal{
        return _completeSignal;
    }

    public function get errorSignal():NativeSignal{
        return _errorSignal;
    }

    public function get content():*{
        if(_loader){
            return _loader.data;
        }

        return null;
    }

    public function dispose():void{
        if(_completeSignal){
            _completeSignal.removeAll();
            _completeSignal = null;
        }

        if(_errorSignal){
            _errorSignal.removeAll();
            _errorSignal= null;
        }

        if(_loader){
            _loader = null;
        }
    }
}
}
