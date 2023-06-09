module github.com/mmogylenko/rules_deb_packages/cmd/update_deb_packages

go 1.20

require (
	github.com/bazelbuild/buildtools v0.0.0-20230510134650-37bd1811516d
	golang.org/x/crypto v0.9.0
	pault.ag/go/debian v0.15.0
)

require pault.ag/go/topsort v0.1.1 // indirect
