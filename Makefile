#!/usr/bin/env make


lib:  
	swift build
all: xcode lib simbuild
clean: 
	rm -rf .build
test:
	swift test
test-generate: 
	swift test --generate-linuxmain
doc: 
	jazzy
simbuild: 
	swift build -Xswiftc "-sdk" -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios13.0-simulator"
xcode: 
	swift package generate-xcodeproj --enable-code-coverage
