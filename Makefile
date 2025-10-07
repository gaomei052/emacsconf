EMACS = /Applications/Emacs.app/Contents/MacOS/Emacs
EMACSFLAGS = -batch -Q -l ~/.emacs.d/init.el -f batch-byte-compile
SRCDIR = ~/.emacs.d/packageConfig
TOOLSDIR = ~/.emacs.d/tools
SOURCES = $(wildcard $(SRCDIR)/*.el)

.PHONY: all compile clean

all: compile

compile:
	@echo "Compiling Emacs configuration..."
	@$(EMACS) $(EMACSFLAGS) $(SRCDIR)/*.el
	@$(EMACS) $(EMACSFLAGS) $(TOOLSDIR)/*.el

clean:
	@echo "Cleaning compiled files..."
	@rm -f $(SRCDIR)/*.elc

# 监控文件变化并自动编译
watch:
	@while true; do \
		inotifywait -e modify $(SRCDIR)/*.el; \
		make compile; \
	done
