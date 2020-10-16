SRC = src/kuzzle.s
LD = ld
GCC = gcc
ASM = nasm
OBJ = $(SRC:.s=.o)
NAME = libkuzzle.so
ASMCFLAGS = -felf64 -g -i src/
LDFLAGS = -shared -g

CFLAGS = -W -Wall

%.o: %.s
	$(ASM) -o $@ $< $(ASMCFLAGS)

all:	$(NAME)

$(NAME): $(OBJ)
	$(LD) $(LDFLAGS) -o $(NAME) $(OBJ)

clean:
	rm -f src/*.o

fclean: clean
	rm -f $(NAME)

re: clean fclean all

example:
	 $(GCC) $(CFLAGS) example/main.c -L. -lkuzzle -o example/example -Wl,-rpath=`pwd`

.PHONY: all clean fclean re example
