#================================================================
#   Copyright (C) 2019 Sangfor Ltd. All rights reserved.
#   
#   文件名称：build_uboot.sh
#   创 建 者：yutao : yutolier@126.com
#   创建日期：2019年07月28日
#   描    述：
#
#================================================================

check_ret()    
{
    if [  $? -ne 0 ];then
	echo $1" error"
	exit
    else
	echo $1"--- OK"
    fi
}

source /opt/arm-linux-gnueabihf-7.4.1/setenv.sh
check_ret "source /opt/arm-linux-gnueabihf-7.4.1/setenv.sh -------------"
                                                                     
make clean                                                           
check_ret "make clean --------------------------------------------------"
make m4412_defconfig                                                
check_ret "make m4412_defconfig ----------------------------------------"
make  ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  -j8               
check_ret "make  ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j8 -------"
cp spl/u-boot-spl.bin u-boot.bin                                     
check_ret "cp spl/u-boot-spl.bin u-boot.bin ----------------------------"
split -b 14336 u-boot.bin bl2                                        
check_ret "split -b 14336 u-boot.bin bl2 -------------------------------"
make -C sdfuse_q/                                                    
check_ret "make -C sdfuse_q/ -------------------------------------------"
./sdfuse_q/chksum                                                    
check_ret "./sdfuse_q/chksum -------------------------------------------"
./sdfuse_q/add_padding                                               
check_ret "./sdfuse_q/add_padding --------------------------------------"
rm bl2a*                                                             
cp u-boot.bin CodeSign4SecureBoot_SCP/                               
check_ret "cp u-boot.bin CodeSign4SecureBoot_SCP/ ----------------------"
cd  CodeSign4SecureBoot_SCP/                                         
check_ret "cd  CodeSign4SecureBoot_SCP/ --------------------------------"
./scp_1gddr.sh                                                       
check_ret "./scp_1gddr.sh ----------------------------------------------"
cp  u-boot-iTOP-4412.bin  /media/yutao/0000-3333/sdupdate/
check_ret "cp u-boot-iTOP-4412.bin /media/yutao/0000-3333/sdupdate/ ----"
sync
umount /media/yutao/*
check_ret "umount /media/yutao/* ---------------------------------------"
sync
cd -



