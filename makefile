all: BootLoader.bin Disk.img Start.sh

BootLoader.bin:
	@echo
	@echo ================== Build BootLoader ======================
	@echo

	make -C BootLoader

	@echo
	@echo ================== Build Complete ========================
	@echo

Disk.img: BootLoader.bin
	@echo
	@echo ================== Disk Image Build Start ================
	@echo

	cp BootLoader/BootLoader.bin Disk.img

	@echo
	@echo ================== All Build Complete ====================
	@echo

Start.sh: BootLoader.bin Disk.img
	@echo
	@echo ================ Create Start Shell script ===============
	@echo 

	echo "#!$(SHELL)" > start.sh
	echo "qemu-system-x86_64 -L . -m 64 -fda Disk.img -M pc" >> start.sh
	chmod +x start.sh

	@echo
	@echo ================ Finish Start Shell script ===============
	@echo 


clean:
	make -C BootLoader clean
	rm -f Disk.img
	rm -f start.sh
