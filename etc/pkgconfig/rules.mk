%.pc: etc/pkgconfig/$(PACKAGE).pc.in VERSION
	sed -e "s:@VERSION@:$(VERSION):; s:@prefix@:$(prefix):; s:@exec_prefix@:$(exec_prefix):; s:@libdir@:$(libdir):; s:@includedir@:$(includedir):" < $< > $@
