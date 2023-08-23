state("Simple Fish Adventure")
{
	// CheckpointNow
	int checkpoint: "UnityPlayer.dll", 0x013A9FD0, 0x0, 0x24, 0x18, 0xC, 0x6C;
	int isInited: "UnityPlayer.dll", 0x013A9FD0, 0x0, 0x24, 0x18, 0xC, 0x70;
}

init
{
	vars.checkpoint = 0;
	vars.timerModel = new TimerModel { CurrentState = timer };
}

update
{
	// Reset
	if (current.checkpoint == 0 && current.isInited == 0)
	{
		vars.checkpoint = 0;
		vars.timerModel.Reset();
	}
}

start
{
	// print("test" + current.checkpoint);
	// print("" + current.isInited);
	if (current.checkpoint == 0 && old.isInited == 0 && current.isInited != 0)
	{
		vars.checkpoint = current.checkpoint;
		return true;
	}
}

split
{
	if (current.checkpoint > vars.checkpoint)
	{
		print("split!");
		vars.checkpoint = current.checkpoint;
		return true;
	}

	// Goal
	if (vars.checkpoint == 10 && current.checkpoint == 0 && current.isInited != 0)
	{
		print("End!");
		return true;
	}
}

reset
{
	return false;
}
