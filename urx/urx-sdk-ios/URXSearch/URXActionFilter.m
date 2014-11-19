//  Copyright (c) 2014 URX. All rights reserved.

#import "URXActionFilter.h"

@implementation URXActionFilter

-(instancetype) initWithAction:(NSString *)action
{
    return [super initWithType:@"action" andValue:action];
}

+(URXActionFilter *) leaveAction {
	return [[URXActionFilter alloc] initWithAction:@"LeaveAction"];
}

+(URXActionFilter *) tieAction {
	return [[URXActionFilter alloc] initWithAction:@"TieAction"];
}

+(URXActionFilter *) takeAction {
	return [[URXActionFilter alloc] initWithAction:@"TakeAction"];
}

+(URXActionFilter *) reserveAction {
	return [[URXActionFilter alloc] initWithAction:@"ReserveAction"];
}

+(URXActionFilter *) wantAction {
	return [[URXActionFilter alloc] initWithAction:@"WantAction"];
}

+(URXActionFilter *) bookmarkAction {
	return [[URXActionFilter alloc] initWithAction:@"BookmarkAction"];
}

+(URXActionFilter *) marryAction {
	return [[URXActionFilter alloc] initWithAction:@"MarryAction"];
}

+(URXActionFilter *) searchAction {
	return [[URXActionFilter alloc] initWithAction:@"SearchAction"];
}

+(URXActionFilter *) commentAction {
	return [[URXActionFilter alloc] initWithAction:@"CommentAction"];
}

+(URXActionFilter *) lendAction {
	return [[URXActionFilter alloc] initWithAction:@"LendAction"];
}

+(URXActionFilter *) befriendAction {
	return [[URXActionFilter alloc] initWithAction:@"BefriendAction"];
}

+(URXActionFilter *) checkOutAction {
	return [[URXActionFilter alloc] initWithAction:@"CheckOutAction"];
}

+(URXActionFilter *) endorseAction {
	return [[URXActionFilter alloc] initWithAction:@"EndorseAction"];
}

+(URXActionFilter *) sellAction {
	return [[URXActionFilter alloc] initWithAction:@"SellAction"];
}

+(URXActionFilter *) replaceAction {
	return [[URXActionFilter alloc] initWithAction:@"ReplaceAction"];
}

+(URXActionFilter *) drawAction {
	return [[URXActionFilter alloc] initWithAction:@"DrawAction"];
}

+(URXActionFilter *) tradeAction {
	return [[URXActionFilter alloc] initWithAction:@"TradeAction"];
}

+(URXActionFilter *) watchAction {
	return [[URXActionFilter alloc] initWithAction:@"WatchAction"];
}

+(URXActionFilter *) borrowAction {
	return [[URXActionFilter alloc] initWithAction:@"BorrowAction"];
}

+(URXActionFilter *) viewAction {
	return [[URXActionFilter alloc] initWithAction:@"ViewAction"];
}

+(URXActionFilter *) agreeAction {
	return [[URXActionFilter alloc] initWithAction:@"AgreeAction"];
}

+(URXActionFilter *) transferAction {
	return [[URXActionFilter alloc] initWithAction:@"TransferAction"];
}

+(URXActionFilter *) cookAction {
	return [[URXActionFilter alloc] initWithAction:@"CookAction"];
}

+(URXActionFilter *) informAction {
	return [[URXActionFilter alloc] initWithAction:@"InformAction"];
}

+(URXActionFilter *) ignoreAction {
	return [[URXActionFilter alloc] initWithAction:@"IgnoreAction"];
}

+(URXActionFilter *) planAction {
	return [[URXActionFilter alloc] initWithAction:@"PlanAction"];
}

+(URXActionFilter *) inviteAction {
	return [[URXActionFilter alloc] initWithAction:@"InviteAction"];
}

+(URXActionFilter *) allocateAction {
	return [[URXActionFilter alloc] initWithAction:@"AllocateAction"];
}

+(URXActionFilter *) donateAction {
	return [[URXActionFilter alloc] initWithAction:@"DonateAction"];
}

+(URXActionFilter *) insertAction {
	return [[URXActionFilter alloc] initWithAction:@"InsertAction"];
}

+(URXActionFilter *) orderAction {
	return [[URXActionFilter alloc] initWithAction:@"OrderAction"];
}

+(URXActionFilter *) winAction {
	return [[URXActionFilter alloc] initWithAction:@"WinAction"];
}

+(URXActionFilter *) cancelAction {
	return [[URXActionFilter alloc] initWithAction:@"CancelAction"];
}

+(URXActionFilter *) tipAction {
	return [[URXActionFilter alloc] initWithAction:@"TipAction"];
}

+(URXActionFilter *) voteAction {
	return [[URXActionFilter alloc] initWithAction:@"VoteAction"];
}

+(URXActionFilter *) createAction {
	return [[URXActionFilter alloc] initWithAction:@"CreateAction"];
}

+(URXActionFilter *) receiveAction {
	return [[URXActionFilter alloc] initWithAction:@"ReceiveAction"];
}

+(URXActionFilter *) wearAction {
	return [[URXActionFilter alloc] initWithAction:@"WearAction"];
}

+(URXActionFilter *) assignAction {
	return [[URXActionFilter alloc] initWithAction:@"AssignAction"];
}

+(URXActionFilter *) exerciseAction {
	return [[URXActionFilter alloc] initWithAction:@"ExerciseAction"];
}

+(URXActionFilter *) confirmAction {
	return [[URXActionFilter alloc] initWithAction:@"ConfirmAction"];
}

+(URXActionFilter *) replyAction {
	return [[URXActionFilter alloc] initWithAction:@"ReplyAction"];
}

+(URXActionFilter *) disagreeAction {
	return [[URXActionFilter alloc] initWithAction:@"DisagreeAction"];
}

+(URXActionFilter *) joinAction {
	return [[URXActionFilter alloc] initWithAction:@"JoinAction"];
}

+(URXActionFilter *) updateAction {
	return [[URXActionFilter alloc] initWithAction:@"UpdateAction"];
}

+(URXActionFilter *) subscribeAction {
	return [[URXActionFilter alloc] initWithAction:@"SubscribeAction"];
}

+(URXActionFilter *) loseAction {
	return [[URXActionFilter alloc] initWithAction:@"LoseAction"];
}

+(URXActionFilter *) filmAction {
	return [[URXActionFilter alloc] initWithAction:@"FilmAction"];
}

+(URXActionFilter *) organizeAction {
	return [[URXActionFilter alloc] initWithAction:@"OrganizeAction"];
}

+(URXActionFilter *) checkAction {
	return [[URXActionFilter alloc] initWithAction:@"CheckAction"];
}

+(URXActionFilter *) unRegisterAction {
	return [[URXActionFilter alloc] initWithAction:@"UnRegisterAction"];
}

+(URXActionFilter *) prependAction {
	return [[URXActionFilter alloc] initWithAction:@"PrependAction"];
}

+(URXActionFilter *) eatAction {
	return [[URXActionFilter alloc] initWithAction:@"EatAction"];
}

+(URXActionFilter *) consumeAction {
	return [[URXActionFilter alloc] initWithAction:@"ConsumeAction"];
}

+(URXActionFilter *) readAction {
	return [[URXActionFilter alloc] initWithAction:@"ReadAction"];
}

+(URXActionFilter *) quoteAction {
	return [[URXActionFilter alloc] initWithAction:@"QuoteAction"];
}

+(URXActionFilter *) deleteAction {
	return [[URXActionFilter alloc] initWithAction:@"DeleteAction"];
}

+(URXActionFilter *) interactAction {
	return [[URXActionFilter alloc] initWithAction:@"InteractAction"];
}

+(URXActionFilter *) checkInAction {
	return [[URXActionFilter alloc] initWithAction:@"CheckInAction"];
}

+(URXActionFilter *) departAction {
	return [[URXActionFilter alloc] initWithAction:@"DepartAction"];
}

+(URXActionFilter *) drinkAction {
	return [[URXActionFilter alloc] initWithAction:@"DrinkAction"];
}

+(URXActionFilter *) rejectAction {
	return [[URXActionFilter alloc] initWithAction:@"RejectAction"];
}

+(URXActionFilter *) playAction {
	return [[URXActionFilter alloc] initWithAction:@"PlayAction"];
}

+(URXActionFilter *) buyAction {
	return [[URXActionFilter alloc] initWithAction:@"BuyAction"];
}

+(URXActionFilter *) reviewAction {
	return [[URXActionFilter alloc] initWithAction:@"ReviewAction"];
}

+(URXActionFilter *) shareAction {
	return [[URXActionFilter alloc] initWithAction:@"ShareAction"];
}

+(URXActionFilter *) paintAction {
	return [[URXActionFilter alloc] initWithAction:@"PaintAction"];
}

+(URXActionFilter *) returnAction {
	return [[URXActionFilter alloc] initWithAction:@"ReturnAction"];
}

+(URXActionFilter *) rentAction {
	return [[URXActionFilter alloc] initWithAction:@"RentAction"];
}

+(URXActionFilter *) assessAction {
	return [[URXActionFilter alloc] initWithAction:@"AssessAction"];
}

+(URXActionFilter *) likeAction {
	return [[URXActionFilter alloc] initWithAction:@"LikeAction"];
}

+(URXActionFilter *) achieveAction {
	return [[URXActionFilter alloc] initWithAction:@"AchieveAction"];
}

+(URXActionFilter *) downloadAction {
	return [[URXActionFilter alloc] initWithAction:@"DownloadAction"];
}

+(URXActionFilter *) followAction {
	return [[URXActionFilter alloc] initWithAction:@"FollowAction"];
}

+(URXActionFilter *) dislikeAction {
	return [[URXActionFilter alloc] initWithAction:@"DislikeAction"];
}

+(URXActionFilter *) trackAction {
	return [[URXActionFilter alloc] initWithAction:@"TrackAction"];
}

+(URXActionFilter *) reactAction {
	return [[URXActionFilter alloc] initWithAction:@"ReactAction"];
}

+(URXActionFilter *) communicateAction {
	return [[URXActionFilter alloc] initWithAction:@"CommunicateAction"];
}

+(URXActionFilter *) writeAction {
	return [[URXActionFilter alloc] initWithAction:@"WriteAction"];
}

+(URXActionFilter *) photographAction {
	return [[URXActionFilter alloc] initWithAction:@"PhotographAction"];
}

+(URXActionFilter *) rsvpAction {
	return [[URXActionFilter alloc] initWithAction:@"RsvpAction"];
}

+(URXActionFilter *) discoverAction {
	return [[URXActionFilter alloc] initWithAction:@"DiscoverAction"];
}

+(URXActionFilter *) appendAction {
	return [[URXActionFilter alloc] initWithAction:@"AppendAction"];
}

+(URXActionFilter *) askAction {
	return [[URXActionFilter alloc] initWithAction:@"AskAction"];
}

+(URXActionFilter *) scheduleAction {
	return [[URXActionFilter alloc] initWithAction:@"ScheduleAction"];
}

+(URXActionFilter *) applyAction {
	return [[URXActionFilter alloc] initWithAction:@"ApplyAction"];
}

+(URXActionFilter *) addAction {
	return [[URXActionFilter alloc] initWithAction:@"AddAction"];
}

+(URXActionFilter *) useAction {
	return [[URXActionFilter alloc] initWithAction:@"UseAction"];
}

+(URXActionFilter *) moveAction {
	return [[URXActionFilter alloc] initWithAction:@"MoveAction"];
}

+(URXActionFilter *) travelAction {
	return [[URXActionFilter alloc] initWithAction:@"TravelAction"];
}

+(URXActionFilter *) giveAction {
	return [[URXActionFilter alloc] initWithAction:@"GiveAction"];
}

+(URXActionFilter *) chooseAction {
	return [[URXActionFilter alloc] initWithAction:@"ChooseAction"];
}

+(URXActionFilter *) installAction {
	return [[URXActionFilter alloc] initWithAction:@"InstallAction"];
}

+(URXActionFilter *) registerAction {
	return [[URXActionFilter alloc] initWithAction:@"RegisterAction"];
}

+(URXActionFilter *) payAction {
	return [[URXActionFilter alloc] initWithAction:@"PayAction"];
}

+(URXActionFilter *) listenAction {
	return [[URXActionFilter alloc] initWithAction:@"ListenAction"];
}

+(URXActionFilter *) performAction {
	return [[URXActionFilter alloc] initWithAction:@"PerformAction"];
}

+(URXActionFilter *) sendAction {
	return [[URXActionFilter alloc] initWithAction:@"SendAction"];
}

+(URXActionFilter *) acceptAction {
	return [[URXActionFilter alloc] initWithAction:@"AcceptAction"];
}

+(URXActionFilter *) arriveAction {
	return [[URXActionFilter alloc] initWithAction:@"ArriveAction"];
}

+(URXActionFilter *) findAction {
	return [[URXActionFilter alloc] initWithAction:@"FindAction"];
}

+(URXActionFilter *) authorizeAction {
	return [[URXActionFilter alloc] initWithAction:@"AuthorizeAction"];
}

@end
