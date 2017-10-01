.PHONY: all clean include

EDITOR ?= gvim
ORG:=$(wildcard *.org)
DST:=$(ORG:%.org=%.html)
all: $(DST)

watch: jwatch.jar
	java -jar jwatch.jar
jwatch.jar:
	curl http://whudoc.qiniudn.com/2016/jwatch.jar > jwatch.jar
clean:
	rm *\* *~ *#
gh:
	git add -A; git commit -m "`uname`"; git push;
%.html: %.org nav.org theme.setup
	@mkdir -p $(@D)
	emacs --batch $< \
			--eval '(org-html-export-to-html)'
