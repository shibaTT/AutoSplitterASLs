state("Simple Fish Adventure")
{
	int   checkpoint               : 0x00; // 現在のチェックポイント
	int   isInited                 : 0x01; // 初期化フラグ
}

/**
 * やりたいこと
 *
 * ・varsでチェックポイントの管理をしたい（ポインタが急にnullになることがあるらしいから）
 * ・できるならどっかからIGT（In Game Time）を取ってきたい（これは家でやらなきゃいけない）
 * ・チェックポイントを戻って進んだ時にsplitされるのを防ぐ（現在がどうなってるのかわからないけど、多分Q押してE押したらsplitされる）
 * ・something
 *
 */

init
{
	vars.checkpoint = 0; // チェックポイントは10個（+ゴール）
	vars.timerModel = new TimerModel { CurrentState = timer };
}

update
{
	// リセット処理
	if (current.checkpoint == 0 && current.isInited == 0)
	{
		vars.checkpoint = 0;
		vars.timerModel.Reset();
	}
}

start
{
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
		vars.checkpoint = current.checkpoint;
		return true;
	}

	// チェックポイントが10から0になった時はゴールしたという意味
	if (vars.checkpoint == 10 && current.checkpoint == 0 && current.isInited != 0)
	{
		return true;
	}
}

reset
{
	return false;
}
