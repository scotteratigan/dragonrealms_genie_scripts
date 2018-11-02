#REQUIRE ClearHand.cmd
#REQUIRE Navigate.cmd
#REQUIRE Go.cmd
#REQUIRE Move.cmd
#REQUIRE Get.cmd
#REQUIRE Put.cmd
#REQUIRE Trash.cmd


FestRafflebotInitialize:
     put #script abort all except %scriptname
     pause
     action goto FestRaffleBotDone when ^Done\!$
     action goto FestRafflebotGetTicket when ^Raffle Attendant Kentikatili says, "Raffle picks are now available
     action goto FestRafflebotClaimPrize when ^$charactername's name appears on the result board\!
     action goto FestRafflebotDoubleCheckTicketBeforeTrashing when ^Raffle Attendant Kentikatili exclaims, "Congratulations to all our winners
FestRaffleBotStart:
     gosub ClearHand both
     gosub Navigate 210 78
     gosub Go iron arch
     # Following fix is required because of custom room mechanics to prevent crashes in prime:
     put #mapper roomid 562
     gosub Get ticket
     goto FestRaffleBotLoop

FestRaffleBotLoop:
     pause 30
     put encumbrance
     goto FestRaffleBotLoop

FestRaffleBotDone:
     put .FestDarkbox
     pause
     exit

FestRafflebotGetTicket:
     gosub Get ticket
     goto FestRaffleBotLoop

FestRafflebotClaimPrize:
FestRafflebotDoubleCheckTicketBeforeTrashing:
     gosub Put my ticket on counter
     if contains("$lefthand $righthand", "ticket") then gosub Trash my ticket
     gosub ClearHand both
     goto FestRaffleBotLoop

# Raffle text:
# Raffle beginning:
# Raffles?  Raffles!
# 
# Raffle ending:
# Done!
#> get ticket
#You tear off a royal blue raffle ticket.
#...
#Raffle Attendant Kentikatili places a roll of raffle tickets in a wide granite counter.
#Raffle Attendant Kentikatili says, "Raffle picks are closed for this drawing!"
#Rubinium's name appears on the result board!
#Zada's name appears on the result board!
#Rellie's name appears on the result board!
#Raffle Attendant Kentikatili exclaims, "Congratulations to all our winners!  Please put your winning tickets on the counter to claim your prize.  The next raffle will begin shortly."
#> put ticket on counter
#Raffle Attendant Kentikatili examines your ticket and exclaims, "Congratulations!"  He smiles broadly as he takes the ticket and hands you a potency crystal.
#Attendant Kentikatili places a roll of raffle tickets out on a wide granite counter.
#Raffle Attendant Kentikatili says, "Raffle picks are now available for the next drawing!"