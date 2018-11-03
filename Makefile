BOX_OUTPUT_PATH ?= box/virtualbox

DESKTOP_BUILD_VERSION ?= 1.3.0
DESKTOP_VM_NAME ?= pythonbox-desktop
DESKTOP_BUILD_NAME ?= $(DESKTOP_VM_NAME)-$(DESKTOP_BUILD_VERSION)
DESKTOP_BOX_NAME ?= $(DESKTOP_BUILD_NAME).box
DESKTOP_BOX_PATH ?= $(BOX_OUTPUT_PATH)/$(DESKTOP_BOX_NAME)
DESKTOP_OVA_NAME ?= $(DESKTOP_BUILD_NAME).ova
DESKTOP_OUTPUT_PATH ?= output-$(DESKTOP_VM_NAME)
DESKTOP_OVA_PATH ?= $(DESKTOP_OUTPUT_PATH)/$(DESKTOP_OVA_NAME)

BUCKET_NAME ?= io-blimp-pythonbox

desktop:
	packer build desktop.json
	cd $(DESKTOP_OUTPUT_PATH) && zip -X $(DESKTOP_OVA_NAME).zip $(DESKTOP_OVA_NAME)
	cd $(BOX_OUTPUT_PATH) && zip -X $(DESKTOP_BOX_NAME).zip $(DESKTOP_BOX_NAME)

clean: clean/desktop

clean/desktop:
	rm -rf $(DESKTOP_OUTPUT_PATH) $(DESKTOP_BOX_PATH)

upload: upload/desktop/ova

upload/desktop:
	s3cmd --access_key=$(AWS_ACCESS_KEY_ID) --secret_key=$(AWS_SECRET_ACCESS_KEY) put $(DESKTOP_BOX_PATH) $(DESKTOP_OVA_PATH) s3://$(BUCKET_NAME)/

upload/desktop/box:
	s3cmd --access_key=$(AWS_ACCESS_KEY_ID) --secret_key=$(AWS_SECRET_ACCESS_KEY) put $(DESKTOP_BOX_PATH) s3://$(BUCKET_NAME)/

upload/desktop/ova:
	s3cmd --access_key=$(AWS_ACCESS_KEY_ID) --secret_key=$(AWS_SECRET_ACCESS_KEY) put $(DESKTOP_OVA_PATH) s3://$(BUCKET_NAME)/
