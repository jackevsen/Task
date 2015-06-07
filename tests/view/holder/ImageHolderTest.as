/**
 * Created by jackevsen on 07.06.15.
 */
package view.holder {
import flash.display.Bitmap;
import flash.display.Sprite;

import models.vios.ImageDataVO;

import org.flexunit.Assert;


public class ImageHolderTest {
    private var _imageHolder:ImageHolder;

    [Before]
    public function setUp():void {
        _imageHolder = new ImageHolder(new ImageDataVO());
    }

    [After]
    public function tearDown():void {
        _imageHolder = null;
    }

    [Test(order=1)]
    public function testImageData():void {
        Assert.assertNotNull("imageData not null", _imageHolder.imageData);
    }

    [Test(order=4)]
    public function testDispose():void {
        var newBitmap:Bitmap = new Bitmap();
        _imageHolder.AddBitmap(newBitmap);
        _imageHolder.dispose();
        Assert.assertNull("imageData is null", _imageHolder.imageData)
        Assert.assertNull("bitmap is disposed", _imageHolder.GetBitmap());
    }

    [Test(order=2)]
    public function testAddBitmap():void {
        var newBitmap:Bitmap = new Bitmap();
        _imageHolder.AddBitmap(newBitmap);
        var imageHolderBitmap:Bitmap = _imageHolder.GetBitmap();
        Assert.assertEquals("new bitmap equals imageHolder bitmap", newBitmap, imageHolderBitmap);
    }

    [Test(order=3)]
    public function testRemoveFromParent():void {
        var parentSprite:Sprite = new Sprite();
        parentSprite.addChild(_imageHolder);
        _imageHolder.removeFromParent();
        Assert.assertNull("removed from parent", _imageHolder.parent);
    }
}
}
