all: postgres mongo oracle

# all our targets are phony (no files to check).
.PHONY : postgres mongo oracle

postgres:
	cd postgres && ./build.sh

mongo: postgres
	cd mongo && ./update_data.sh && ./build.sh

oracle:
	cd oracle && ./build.sh
