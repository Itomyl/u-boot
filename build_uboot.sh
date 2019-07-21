source /opt/arm-linux-gnueabihf-7.4.1/setenv.sh
if [  $? -ne 0 ];then
    echo "source /opt/arm-linux-gnueabihf-7.4.1/setenv.sh error"
    exit
else
    echo "source /opt/arm-linux-gnueabihf-7.4.1/setenv.sh OK"
fi
make clean
make m4412_defconfig 
#make menuconfig  ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  -j8
make  ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  -j8
if [  $? -ne 0 ];then
    echo "make u-boot error"
    exit
else
    echo "make u-boot  OK"
fi
cp spl/u-boot-spl.bin u-boot.bin
if [  $? -ne 0 ];then
    echo "cp spl/u-boot-spl.bin u-boot.bin error"
    exit
else
    echo "cp spl/u-boot-spl.bin u-boot.bin OK"
fi
split -b 14336 u-boot.bin bl2
make -C sdfuse_q/
./sdfuse_q/chksum
./sdfuse_q/add_padding
rm bl2a*
cp u-boot.bin CodeSign4SecureBoot_SCP/
cd  CodeSign4SecureBoot_SCP/  
./scp_1gddr.sh 
if [  $? -ne 0 ];then
    echo "add bl1 bl2  error"
    exit
else
    echo " add bl1 bl2 OK"
fi
cp  u-boot-iTOP-4412.bin  /media/yutao/0000-3333/sdupdate/
if [  $? -ne 0 ];then
    echo "cp u-boot-iTOP-4412.bin  error"
    exit
else
    echo "cp u-boot-iTOP-4412.bin  OK"
fi
sync
umount /media/yutao/*
sync
cd -


