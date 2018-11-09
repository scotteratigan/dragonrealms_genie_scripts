#REQUIRE Navigate.cmd
#REQUIRE Withdraw.cmd

gosub FestWithdraw %0
exit

FestWithdraw:
	var FestWithdraw.amount $0
	var FestWithdraw.success 0
FestWithdrawing:
	gosub Navigate 210 teller
	gosub Withdraw %FestWithdraw.amount
	if (%Withdraw.success == 1) then {
		var FestWithdraw.success 1
		return
	}
	return