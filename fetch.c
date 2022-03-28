int main() {
	struct utsname info;
	if (uname(&info) == 0)
		err(1, "uname");

	printf("Hostname:\t%s\n", info.nodename);
	printf("Arch:    \t%s\n", info.machine);
	printf("OS:      \t%s %s\n", info.sysname, info.release);
	printf("Info:    \t%s\n", info.version);
	(void)info.domainname;
}
