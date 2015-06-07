/**
 * Created by jackevsen on 07.06.15.
 */
package controllers.loaders {
import org.osflash.signals.natives.NativeSignal;

public interface ILoader {
    function Load(url:String):void;
    function get completeSignal():NativeSignal;
    function get errorSignal():NativeSignal;
    function get content():*;
    function dispose():void;
}
}
