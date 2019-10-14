#!/usr/bin/python3
import sys

if len(sys.argv) < 1:
    print('Usage: ' + sys.argv[0] + ' <command>')
    sys.exit(1)


def encoder(string: str, max_length: int) -> str:
    encoded = 'eval(String.fromCharCode('

    a = 1
    for x in string:
        encoded += str(ord(x))

        if a < max_length:
            encoded += ', '
            a += 1

    return encoded + '));'


print(encoder(sys.argv[1], len(sys.argv[1])))
