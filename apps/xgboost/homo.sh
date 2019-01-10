#!/bin/bash
#
#
kvm1="kvm1"
kvm2="kvm1"
ip1="192.168.122.96"
ip2="192.168.122.98"
ctx=$2

#mount disk
ssh $kvm1@$ip1 "/home/$kvm1/vMigrater/scripts/mount.sh"
ssh $kvm2@$ip2 "/home/$kvm2/vMigrater/scripts/mount.sh"

#bc
for i in 1 2 3 4 5
do
	ssh $kvm1@$ip1 "cd /home/kvm1/sda3/xgboost/demo/binary_classification; time taskset -c 0-22 ../../xgboost mushroom.conf nthread=$1" &>> $ctx/vm1.bc &
	ssh $kvm2@$ip2 "cd /home/kvm1/sda3/xgboost/demo/binary_classification; time taskset -c 0-22 ../../xgboost mushroom.conf nthread=$1" &>> $ctx/vm2.bc
	sleep 10
done

#mc
for i in 1 2 3 4 5
do
	ssh $kvm1@$ip1 "cd /home/kvm1/sda3/xgboost/demo/multiclass_classification; time taskset -c 0-22 time ./train23.py" &>> $ctx/vm1.mc &
	ssh $kvm2@$ip2 "cd /home/kvm1/sda3/xgboost/demo/multiclass_classification; time taskset -c 0-22 time ./train23.py" &>> $ctx/vm2.mc
	sleep 10
done

#regression
for i in 1 2 3 4 5
do
	ssh $kvm1@$ip1 "cd /home/kvm1/sda3/xgboost/demo/regression; time taskset -c 0-22 ../../xgboost machine.conf nthread=$1" &>> $ctx/vm1.re &
	ssh $kvm2@$ip2 "cd /home/kvm1/sda3/xgboost/demo/regression; time taskset -c 0-22 ../../xgboost machine.conf nthread=$1" &>> $ctx/vm2.re
	sleep 10
done

#year prediction
for i in 1 2 3 4 5
do
	ssh $kvm1@$ip1 "cd /home/kvm1/sda3/xgboost/demo/yearpredMSD; time taskset -c 0-22 ../../xgboost yearpredMSD.conf nthread=$1" &>> $ctx/vm1.year &
	ssh $kvm2@$ip2 "cd /home/kvm1/sda3/xgboost/demo/yearpredMSD; time taskset -c 0-22 ../../xgboost yearpredMSD.conf nthread=$1" &>> $ctx/vm2.year
	sleep 10
done

