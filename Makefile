REPO=/root/book/lll1
build:
	./tools/gh-pages.sh

clean:
	@rm -rf $(REPO)/gh-pages
	@git worktree prune 2>/dev/null || true
	@git worktree remove $(REPO)/gh-pages --force 2>/dev/null || true
	@echo "Done"
