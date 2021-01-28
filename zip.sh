e2fsck -y -f $OUTP/systemport.img
resize2fs $OUTP/systemport.img 786432


img2simg $OUTP/systemport.img $OUTP/sparsesystem.img
rm $OUTP/systemport.img
$TOOLS/img2sdat/img2sdat.py -v 4 -o $OUTP/zip -p system $OUTP/sparsesystem.img
rm $OUTP/sparsesystem.img
img2simg $OUTP/vendorport.img $OUTP/sparsevendor.img
rm $OUTP/vendorport.img
$TOOLS/img2sdat/img2sdat.py -v 4 -o $OUTP/zip -p vendor $OUTP/sparsevendor.img
rm $OUTP/sparsevendor.img
brotli -j -v -q 6 $OUTP/zip/system.new.dat
brotli -j -v -q 6 $OUTP/zip/vendor.new.dat

cd $OUTP/zip
zip -ry $OUTP/10_MIUI_12_jasmine_sprout_$ROMVERSION.zip *
cd $CURRENTDIR
rm -rf $OUTP/zip
chown -hR $CURRENTUSER:$CURRENTUSER $OUTP

rm $OUTP/systema2.img
rm $OUTP/vendora2.img
