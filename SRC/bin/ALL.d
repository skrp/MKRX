#!/sbin/dtrace -s
dtrace:::BEGIN
{
	i = 0;
}
syscall:::entry
/pid == $1/
{
	@syscalls[probefunc] = count();
}
profile:::tick-1sec
/i < $2/
{
	i = i + 1;
}
profile:::tick-1sec
/i == $2/
{
	exit(0);
}
