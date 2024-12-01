default:
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -flto -c oldbloom/bloom.cpp -o oldbloom.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -flto -c bloom/bloom.cpp -o bloom.o
        gcc -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-unused-parameter -Ofast -ftree-vectorize -c base58/base58.c -o base58.o
        gcc -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c rmd160/rmd160.c -o rmd160.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -c sha3/sha3.c -o sha3.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -c sha3/keccak.c -o keccak.o
        gcc -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c xxhash/xxhash.c -o xxhash.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -c util.c -o util.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -c secp256k1/Int.cpp -o Int.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -c secp256k1/Point.cpp -o Point.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -c secp256k1/SECP256K1.cpp -o SECP256K1.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -c secp256k1/IntMod.cpp -o IntMod.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -flto -c secp256k1/Random.cpp -o Random.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -flto -c secp256k1/IntGroup.cpp -o IntGroup.o
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -o hash/ripemd160.o -ftree-vectorize -flto -c hash/ripemd160.cpp
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -o hash/sha256.o -ftree-vectorize -flto -c hash/sha256.cpp
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -o hash/ripemd160_sse.o -ftree-vectorize -flto -c hash/ripemd160_sse.cpp
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -o hash/sha256_sse.o -ftree-vectorize -flto -c hash/sha256_sse.cpp
        g++ -march=armv7-a -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Wno-deprecated-copy -Ofast -ftree-vectorize -o keyhunt keyhunt.cpp base58.o rmd160.o hash/ripemd160.o hash/ripemd160_sse.o
        rm -r *.o

clean:
        rm keyhunt

legacy:
	# Compilar os módulos do oldbloom
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -flto -c oldbloom/bloom.cpp -o oldbloom.o

	# Compilar os módulos do bloom
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -flto -c bloom/bloom.cpp -o bloom.o

	# Compilar os módulos do base58
	gcc -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c base58/base58.c -o base58.o

	# Compilar os módulos de hash
	gcc -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c xxhash/xxhash.c -o xxhash.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c sha3/sha3.c -o sha3.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c sha3/keccak.c -o keccak.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c hashing.c -o hashing.o

	# Compilar os módulos do gmp256k1
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c gmp256k1/Int.cpp -o Int.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c gmp256k1/Point.cpp -o Point.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c gmp256k1/GMP256K1.cpp -o GMP256K1.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -c gmp256k1/IntMod.cpp -o IntMod.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -flto -c gmp256k1/Random.cpp -o Random.o
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -flto -c gmp256k1/IntGroup.cpp -o IntGroup.o

	# Linkar os arquivos compilados para criar o binário "keyhunt_legacy"
	g++ -march=armv7-a -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -Wall -Wextra -Ofast -ftree-vectorize -o keyhunt_legacy keyhunt_legacy.cpp \
		base58.o bloom.o oldbloom.o xxhash.o util.o Int.o Point.o GMP256K1.o IntMod.o Random.o IntGroup.o

	# Limpar arquivos intermediários
	rm -f *.o
