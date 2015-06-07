/**
 * Created by jackevsen on 07.06.15.
 */
package controllers.loaders {
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

import org.osflash.signals.natives.NativeSignal;

public class ImageLoader implements ILoader {
    private var _loader:Loader;
    private var _completeSignal:NativeSignal;
    private var _errorSignal:NativeSignal;

    public function ImageLoader() {
        _loader = new Loader();

        _completeSignal = new NativeSignal(_loader.contentLoaderInfo, Event.COMPLETE);
        _errorSignal = new NativeSignal(_loader.contentLoaderInfo, IOErrorEvent.IO_ERROR);
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
            return _loader.contentLoaderInfo.content;
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
