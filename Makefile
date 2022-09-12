REPO=/root/book/book/lll1
build:
	./tools/gh-pages.sh

clean:
	@rm -rf $(REPO)
	@git worktree prune 2>/dev/null || true
	@git worktree remove $(REPO)/book/html --force 2>/dev/null || true
	@echo "Done"
