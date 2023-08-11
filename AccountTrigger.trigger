trigger AccountTrigger on Account (before insert, before update, after insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
            AccountTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isInsert) {
        AccountTriggerHandler.handleAfterInsert(Trigger.new);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
    AccountTriggerHandler.handleBeforeUpdate(Trigger.new);
    }
}

