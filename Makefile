.ONESHELL: # Applies to every targets in the file!
.SHELLFLAGS += -e

build:
	mdbook build
	rm -rf /tmp/gh-pages/*
	cp -rf ./book/html/* /tmp/gh-pages/
	cd /tmp/gh-pages/
	git update-ref -d refs/heads/gh-pages
	git add .
	git commit -m "expected: one commit"
	git push --force -u origin gh-pages

init:
	@rm -rf /tmp/gh-pages
	@mkdir -p /tmp/gh-pages
	@git worktree prune || true
	@git branch -D gh-pages || true
	@git branch gh-pages || true
	@git worktree add /tmp/gh-pages || true
	@echo 'finish'

clean:
	rm -rf book
