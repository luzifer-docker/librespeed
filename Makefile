README.md:
	cp README.tpl.md README.md
	grep -Eo '\$$\{[A-Z][^\}]*\}' docker-entrypoint.sh | sed -E -e 's/\$$\{([^:]*)(|:-(.*))\}/| \1 | `\3` |/' -e 's/``//' | sort | uniq >>README.md

.PHONY: README.md

auto-hook-pre-commit: README.md
	git add README.md
