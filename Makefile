SRC = src/kuzzle.s
LD = ld
# LD = gcc
ASM = nasm
OBJ = $(SRC:.s=.o)
NAME = libkuzzle.so
ASMCFLAGS = -felf64 -g -i src/
LDFLAGS = -shared -g
# LDFLAGS = -shared -no-pie -g3

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

.PHONY: all clean fclean re
