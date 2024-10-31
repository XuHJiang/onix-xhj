BUILD:=../build
SRC:=.
$(BUILD)/boot/%.bin: $(SRC)/boot/%.asm
	$(shell mkdir -p $(dir $@))
	nasm -f bin $< -o $@

$(BUILD)/master.img: $(BUILD)/boot/boot.bin \ 
	$(BUILD)/bootloader.bin

	yes | bximage -hd -mode="flat" -size=60 -q master.img $@
	dd if=$(BUILD)/boot/boot.bin of=master.img bs=512 count=1 conv=notrunc
	dd if=$(BUILD)/bootloader.bin of=master.img bs=512 count=4 seek=2 conv=notrunc

test: $(BUILD)/master.img

.PHONY: clean
clean:
	rm -rf *.bin
	rm -rf *.img

.PHONY: bochs
bochs: master.img
	bochs -q
