all: postgres mongo

# all our targets are phony (no files to check).
.PHONY : postgres mongo

postgres:
	cd postgres && ./build.sh

mongo: postgres
	cd mongo && ./update_data.sh && ./build.sh

