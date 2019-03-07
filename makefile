all: BootLoader Disk.img

BootLoader:
	@echo
	@echo ================== Build BootLoader ======================
	@echo

	make -C BootLoader

	@echo
	@echo ================== Build Complete ========================
	@echo

Disk.img: BootLoader/BootLoader.bin
	@echo
	@echo ================== Disk Image Build Start ================
	@echo

	cp BootLoader/BootLoader.bin Disk.img

	@echo
	@echo ================== All Build Complete ====================
	@echo

clean:
	make -C BootLoader clean
	rm -f Disk.img