REPO=$(shell git rev-parse --show-toplevel)	
build:
	@echo "run tools/gh-pages"
	@gh-pages
	@echo "Done"

clean:
	@rm -rf $(REPO)/gh-pages
	@git worktree prune 2>/dev/null || true
	@git worktree remove $(REPO)/gh-pages --force 2>/dev/null || true
	@echo "clean is Done"
