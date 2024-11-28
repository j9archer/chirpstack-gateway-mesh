.PHONY: build

build: 

	# mipsel is a tier-3 target.
	rustup toolchain install nightly-2024-05-17
	cross +nightly-2024-05-17 build -Z build-std=panic_abort,std --target mipsel-unknown-linux-musl --release

# Update the version.
version:
	test -n "$(VERSION)"
	sed -i 's/^  version.*/  version = "$(VERSION)"/g' ./Cargo.toml
	make test
	git add .
	git commit -v -m "Bump version to $(VERSION)"
	git tag -a v$(VERSION) -m "v$(VERSION)"

# Cleanup dist.
clean:
	cargo clean
	rm -rf dist

# Run tests
test:
	cargo clippy --no-deps
	cargo test

# Enter the devshell.
devshell:
	nix-shell
