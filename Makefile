
NAME = please

SHELL = /bin/sh
RM = rm
GO = go

OUT_DIR = build
INSTALL_DIR = /usr/local/bin

# build

build:
	go build -o ./$(NAME) .

# linux
build-amd64:
	GOOS=linux GOARCH=amd64 $(GO) build -o $(OUT_DIR)/$(NAME)-linux-amd64 .

build-i386:
	GOOS=linux GOARCH=386 $(GO) build -o $(OUT_DIR)/$(NAME)-linux-386 .

build-arm:
	GOOS=linux GOARCH=arm $(GO) build -o $(OUT_DIR)/$(NAME)-linux-arm .

build-arm64:
	GOOS=linux GOARCH=arm64 $(GO) build -o $(OUT_DIR)/$(NAME)-linux-arm64 .

# windows
build-win-amd64:
	GOOS=windows GOARCH=amd64 $(GO) build -o $(OUT_DIR)/$(NAME)-windows-amd64.exe

build-win-i386:
	GOOS=windows GOARCH=386 $(GO) build -o $(OUT_DIR)/$(NAME)-windows-386.exe

# mac
build-mac:
	GOOS=darwin GOARCH=arm64 $(GO) build -o $(OUT_DIR)/$(NAME)-darwin-arm64

build-all: build-amd64 build-i386 build-arm build-win-amd64 build-win-i386 build-mac

# install

install:
	install -Dm755 ./$(NAME) $(INSTALL_DIR)/$(NAME)
	chmod u+s $(INSTALL_DIR)/$(NAME)

# uninstall

uninstall:
	$(RM) -f $(INSTALL_DIR)/$(NAME)

# clean

clean:
	$(RM) -rf build
