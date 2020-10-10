deployg:
	rm -r docs
	./deploy.sh

up:
	hugo server -D

.PHONY: all clean sync build run kill
