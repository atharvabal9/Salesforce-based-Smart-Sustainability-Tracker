trigger EmissionTrigger on Emission__c (before insert, before update) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert || Trigger.isUpdate) {
            EmissionCalculator.calculateEmissions(Trigger.new);
        }
    }
}
