state("Simple Fish Adventure")
{
	int   checkpoint               : 0x00; // 現在のチェックポイント
	int   isInited                 : 0x01; // 初期化フラグ
}

/**
 * やりたいこと
 *
 * ・できるならどっかからIGT（In Game Time）を取ってきたい
 * ・メニュー画面にいるかどうかを把握できる変数が欲しい
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
